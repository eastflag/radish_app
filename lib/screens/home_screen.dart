import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radish_app/states/user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("홈스크림", style: Theme.of(context).appBarTheme.titleTextStyle,),
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Icons.search)),
          IconButton(onPressed: (){

          }, icon: Icon(Icons.list)),
          IconButton(onPressed: (){

          }, icon: Icon(Icons.notifications))
        ],
      ),
    );
  }
}
