import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class UserProvider extends ChangeNotifier {

  // bool _userLoggedIn = false;
  //
  // void setUserAuth(bool authState) {
  //   _userLoggedIn = authState;
  //   notifyListeners();
  // }
  //
  // bool get userState => _userLoggedIn;

  User? _user;

  User? get user => _user;

  void initUser() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }
}
