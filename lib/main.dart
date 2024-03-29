import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radish_app/router/locations.dart';
import 'package:radish_app/screens/start_screen.dart';
import 'package:radish_app/screens/splash_screen.dart';
import 'package:radish_app/states/user_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// 비머 전역 선언
final _routerDelegate = BeamerDelegate(
  guards: [
    BeamGuard(
      pathBlueprints: ['/'],
      check: (context, location) {
        return context.watch<UserNotifier>().user != null;
        // return true;
      },
      showPage: BeamPage(child: StartScreen()),
    ),
  ],
  locationBuilder: BeamerLocationBuilder(
    beamLocations: [HomeLocation(), InputLocation()],
  ),
);

void main() async {
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // final emulatorHost =
  // (!kIsWeb && defaultTargetPlatform == TargetPlatform.android)
  //     ? '10.0.2.2'
  //     : 'localhost';
  //
  // await FirebaseStorage.instance.useStorageEmulator(emulatorHost, 9199);

  Provider.debugCheckInvalidValueType = null;
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
        });
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
    return ChangeNotifierProvider<UserNotifier>(
      create: (BuildContext context) {
        return UserNotifier();
      },
      child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationParser: BeamerParser(),
          routerDelegate: _routerDelegate,
          theme: ThemeData(
            hintColor: Colors.grey[350],
            fontFamily: 'DoHyeon',
            primarySwatch: Colors.green,
            textTheme: TextTheme(
                headline5: TextStyle(fontFamily: 'DoHyeon'),
                subtitle1: TextStyle(fontSize: 17, color: Colors.black87),
                subtitle2: TextStyle(fontSize: 13, color: Colors.black38),
                button: TextStyle(color: Colors.white),
                bodyText2: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w300),
            ),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              minimumSize: Size(48, 48),
            )),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              titleTextStyle: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w700),
              elevation: 2,
              actionsIconTheme: IconThemeData(color: Colors.black),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: Colors.black87,
              unselectedItemColor: Colors.black38,
            ),
          )),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
