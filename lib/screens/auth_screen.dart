import 'package:flutter/material.dart';

import 'intro_page.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        children: [
          const IntroPage(),
          Container(color: Colors.accents[3],),
          Container(color: Colors.accents[2],),
        ]
      ),
      // body: IntroPage(),
    );
  }

  final _controller = PageController(
    initialPage: 0,
  );
}
