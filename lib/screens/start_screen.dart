import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radish_app/screens/start/auth_page.dart';
import 'start/address_page.dart';
import 'start/intro_page.dart';

class StartScreen extends StatelessWidget {
  PageController _pageController = PageController();

  StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<PageController>.value(
      value: _pageController,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
            controller: _pageController,
            // physics: NeverScrollableScrollPhysics(),
            children: [
              IntroPage(),
              AddressPage(),
              AuthPage(),
            ]),
      ),
    );
  }
}
