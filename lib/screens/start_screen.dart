import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:radish_app/screens/start/auth_page.dart';

import 'start/address_page.dart';
import 'start/intro_page.dart';

class StartScreen extends StatelessWidget {
  StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: MouseDraggableScrollBehavior(),
        child: PageView(
          controller: _pageController,
          // physics: NeverScrollableScrollPhysics(),
          children: [
            IntroPage(_pageController),
            AddressPage(),
            AuthPage(),
          ]
        ),
      ),
    );
  }

  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
    viewportFraction: 1.0
  );
}

class MouseDraggableScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
