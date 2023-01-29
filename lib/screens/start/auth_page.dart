import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인 하기', style: Theme.of(context).textTheme.headline5,),
        elevation: Theme.of(context).appBarTheme.elevation
      ),
    );
  }
}
