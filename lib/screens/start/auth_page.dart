import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:radish_app/constants/common_size.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);

  final inputBorder = OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      Size size = MediaQuery.of(context).size;

      return Scaffold(
        appBar: AppBar(
            title: Text(
              '로그인 하기',
              style: Theme.of(context).textTheme.headline5,
            ),
            elevation: Theme.of(context).appBarTheme.elevation),
        body: Padding(
          padding: EdgeInsets.all(common_bg_padding),
          child: Column(
            children: [
              Row(
                children: [
                  ExtendedImage.asset(
                    'assets/images/security.png',
                    width: size.width * 0.25,
                    height: size.width * 0.25,
                  ),
                  SizedBox(width: 10.0,),
                  Text('무마켓은 전화번호로 가입합니다. \n여러분의 개인정보는 안전히 보관되며\n외부에 노출되지 않습니다.')
                ],
              ),
              SizedBox(height: common_sm_padding,),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: inputBorder,
                  focusedBorder: inputBorder,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
