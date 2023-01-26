import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:radish_app/router/locations.dart';
import 'package:radish_app/screens/auth_screen.dart';
import 'package:radish_app/screens/splash_screen.dart';

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
      return RadishApp();
    } else {
      return SplashScreen();
    }
  }
}

class RadishApp extends StatelessWidget {
  RadishApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: BeamerParser(),
      routerDelegate: _routerDelegate,
      theme: ThemeData(
        fontFamily: 'DoHyeon',
        primarySwatch: Colors.green,
        textTheme: TextTheme(
          headline5: TextStyle(fontFamily: 'DoHyeon'),
          button: TextStyle(color: Colors.white)
        )
      )
    );
  }

  final _routerDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [HomeLocation()],
    ),
    guards: [
      BeamGuard(
        pathBlueprints: ['/'],
        check: (context, location) { return false; },
        showPage: BeamPage(child: AuthScreen()),
      ),
    ]
  );
}
