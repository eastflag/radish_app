import 'dart:typed_data';

import 'package:beamer/beamer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';
import 'package:radish_app/constants/common_size.dart';
import 'package:radish_app/model/item_model.dart';
import 'package:radish_app/repo/image_storage.dart';
import 'package:radish_app/repo/item_service.dart';
import 'package:radish_app/states/category_notifier.dart';
import 'package:radish_app/states/select_image_notifier.dart';

import '../states/user_notifier.dart';
import '../utils/logger.dart';
import 'multi_image_select.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  bool _suggestPriceSelected = false;
  TextEditingController _priceController = TextEditingController();

  var _border = UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent));

  var _divider = Divider(
    height: 1,
    color: Colors.grey,
    thickness: 1,
    indent: common_bg_padding,
    endIndent: common_bg_padding,
  );

  bool isCreatingItem = false; // firebase 저장시 다른 메뉴 클릭 안되게

  TextEditingController _titleController = TextEditingController();
  TextEditingController _detailController = TextEditingController();

  void attemptCreateItem() async {
    if (FirebaseAuth.instance.currentUser == null) {
      return;
    }

    isCreatingItem = true;
    setState(() {});

    final String userKey = FirebaseAuth.instance.currentUser!.uid;
    final String itemKey = ItemModel.generateItemKey(userKey);

    List<Uint8List> images = context
        .read<SelectImageNotifier>()
        .images;

    UserNotifier userNotifier = context.read<UserNotifier>();

    if (userNotifier.userModel == null) {
      return;
    }

    List<String> downloadUrls = await ImageStorage.uploadImages(images, itemKey);

    final num? price = num.tryParse(_priceController.text.replaceAll(new RegExp(r"\D"), ''));

    ItemModel itemModel = ItemModel(itemKey: itemKey,
        userkey: userKey,
        imageDownloadUrls: downloadUrls,
        title: _titleController.text,
        category: context.read<CategoryNotifier>().currentCagegoryInEng,
        price: price ?? 0,
        negotiable: _suggestPriceSelected,
        detail: _detailController.text,
        address: userNotifier.userModel!.address,
        geoFirePoint: userNotifier.userModel!.geoFirePoint,
        createdDate: DateTime.now().toUtc());

    logger.d('upload fininished - ${downloadUrls.toString()}');

    await ItemService().createNewItem(itemModel.toJson(), itemKey);

    isCreatingItem = false;
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          Size _size = MediaQuery
              .of(context)
              .size;
          return IgnorePointer( // 저장 중일때 메뉴 화면 터치 안되도록 처리
            ignoring: isCreatingItem,
            child: Scaffold(
              appBar: AppBar(
                bottom: PreferredSize( // 앱바 아래 라인으로 로딩중인 상태를 나타내기 위해 사용
                    preferredSize: Size(_size.width, 2),
                    child: isCreatingItem ? LinearProgressIndicator(minHeight: 2) : Container()
                ),
                leading: TextButton(
                    onPressed: () {
                      context.beamBack();
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.black87, // 눌렀을때 머티리얼 효과
                        backgroundColor: Theme
                            .of(context)
                            .appBarTheme
                            .backgroundColor),
                    child: Text(
                      '뒤로',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText2,
                    )),
                title: Text('중고상품 업로드'),
                centerTitle: true,
                actions: [
                  TextButton(
                      onPressed: attemptCreateItem,
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.black87, // 눌렀을때 머티리얼 효과.
                          backgroundColor: Theme
                              .of(context)
                              .appBarTheme
                              .backgroundColor),
                      child: Text('완료', style: Theme
                          .of(context)
                          .textTheme
                          .bodyText2))
                ],
              ),
              body: ListView(
                children: [
                  MultiImageSelect(),
                  _divider,
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: common_bg_padding),
                      hintText: '상품 제목',
                      border: _border,
                      enabledBorder: _border,
                      focusedBorder: _border,
                    ),
                  ),
                  _divider,
                  ListTile(
                    onTap: () {
                      context.beamToNamed('/input/category_input');
                    },
                    dense: true,
                    title: Text(context
                        .watch<CategoryNotifier>()
                        .currentCategoryInKor),
                    trailing: Icon(Icons.navigate_next),
                  ),
                  _divider,
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                            inputFormatters: [MoneyInputFormatter(trailingSymbol: '원', mantissaLength: 0)],
                            controller: _priceController,
                            onChanged: (value) {
                              setState(() {
                                if (value == '0원') {
                                  _priceController.clear();
                                }
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: common_bg_padding),
                              hintText: '상품가격을 입력하세요.',
                              border: _border,
                              enabledBorder: _border,
                              focusedBorder: _border,
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: common_bg_padding),
                        child: TextButton.icon(
                          onPressed: () {
                            setState(() {
                              _suggestPriceSelected = !_suggestPriceSelected;
                            });
                          },
                          icon: Icon(_suggestPriceSelected ? Icons.check_circle : Icons.check_circle_outline,
                              color: _suggestPriceSelected ? Theme
                                  .of(context)
                                  .primaryColor : Colors.black54),
                          label: Text(
                            '가격 제안 받기',
                            style: TextStyle(color: _suggestPriceSelected ? Theme
                                .of(context)
                                .primaryColor : Colors.black54),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            primary: Colors.black38,
                          ),
                        ),
                      )
                    ],
                  ),
                  _divider,
                  TextFormField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: common_bg_padding),
                        hintText: '상품 및 필요한 세부설명을 입력해주세요.',
                        border: _border,
                        enabledBorder: _border,
                        focusedBorder: _border),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}
