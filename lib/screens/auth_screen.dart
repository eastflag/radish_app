import 'package:flutter/material.dart';

import 'intro_page.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
      // body: PageView(
      //   children: [
      //     IntroPage(),
      //     Container(color: Colors.accents[2],),
      //     Container(color: Colors.accents[3],),
      //   ]
      // ),
      body: IntroPage(),
    );
  }

  final _controller = PageController(
    initialPage: 0,
  );
}
