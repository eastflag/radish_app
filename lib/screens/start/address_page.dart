import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radish_app/screens/start/address_service.dart';

import '../../model/AddressModel.dart';

class AddressPage extends StatefulWidget {
  AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController _addressController = TextEditingController();

  AddressModel? _addressModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            onFieldSubmitted: (text) async {
              _addressModel = await AddressService().SearchAddressByStr(text);
              setState(() {

              });
            },
            controller: _addressController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                prefixIconConstraints: BoxConstraints(minWidth: 24, minHeight: 24),
                hintText: '도로명으로 검색하세요',
                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                hintStyle: TextStyle(color: Theme.of(context).hintColor)),
          ),
          TextButton.icon(
              onPressed: () => {},
              icon: Icon(CupertinoIcons.compass, color: Colors.white),
              label: Text("현재 위치로 찾기", style: Theme.of(context).textTheme.button),
              style: TextButton.styleFrom(backgroundColor: Theme.of(context).primaryColor)),
          Expanded(
            child: ListView.builder(
                itemCount: (_addressModel?.result?.items == null ? 0 : _addressModel?.result?.items?.length),
                itemBuilder: (context, index) {
                  if (_addressModel == null || _addressModel?.result == null || _addressModel!.result!.items == null
                  || _addressModel!.result!.items![index].address == null) {
                    return Container();
                  }

                  return ListTile(
                    leading: ExtendedImage.asset('assets/images/carrot.jpg'),
                    title: Text(_addressModel?.result?.items?[index].address?.road ?? ""),
                    subtitle: Text(_addressModel?.result?.items?[index].address?.parcel ?? ""),
                    trailing: Icon(Icons.more),
                  );
                }),
          )
        ],
      ),
    );
  }
}
