import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:radish_app/utils/logger.dart';

class UserProvider extends ChangeNotifier {

  // bool _userLoggedIn = false;
  //
  // void setUserAuth(bool authState) {
  //   _userLoggedIn = authState;
  //   notifyListeners();
  // }
  //
  // bool get userState => _userLoggedIn;

  UserProvider() {
    initUser();
  }

  User? _user;

  User? get user => _user;

  void initUser() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _user = user;
      logger.d('현재 유저 상태: $user');
      notifyListeners();
    });
  }
}
