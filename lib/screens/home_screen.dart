import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radish_app/states/user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("홈스크림"),
        actions: [
          IconButton(onPressed: (){
            context.read<UserProvider>().setUserAuth(false);
          }, icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
