import 'package:flutter/material.dart';

import 'address_page.dart';
import 'intro_page.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          IntroPage(_pageController),
          AddressPage(),
          Container(color: Colors.accents[2],),
        ]
      ),
    );
  }

  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
    viewportFraction: 1.0
  );
}
