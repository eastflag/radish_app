import 'package:flutter/material.dart';
import 'package:radish_app/home_screen.dart';
import 'package:radish_app/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3), () => 100),
      builder: (context, snapshot) {
        return AnimatedSwitcher(
          duration: const Duration(microseconds: 900),
          child: _splashLoadingWidget(snapshot),
        );
      }
    );
  }

  StatelessWidget _splashLoadingWidget(AsyncSnapshot<Object> snapshot) {
    if (snapshot.hasError) {
      print("에러가 발생했습니다");
      return Text("error");
    } else if (snapshot.hasData) {
      return HomeScreen();
    } else {
      return SplashScreen();
    }
  }
}

