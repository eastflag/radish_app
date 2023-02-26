import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:radish_app/constants/shared_pref_keys.dart';
import 'package:radish_app/model/user_model.dart';
import 'package:radish_app/repo/user_service.dart';
import 'package:radish_app/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      _setNewUser(user);
      logger.d('현재 유저 상태: $user');
      notifyListeners();
    });
  }

  void _setNewUser(User? user) async {
    _user = user;
    if (user != null && user.phoneNumber != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String address = prefs.getString(SHARED_ADDRESS) ?? "";
      double lat = prefs.getDouble(SHARED_LAT) ?? 0;
      double lon = prefs.getDouble(SHARED_LON) ?? 0;
      String phoneNumber = user.phoneNumber!;
      String userKey = user.uid;

      UserModel userModel = UserModel(
          userKey: "",
          phoneNumber: phoneNumber,
          address: address,
          lat: lat,
          lon: lon,
          geoFirePoint: GeoFirePoint(lat, lon),
          createdDate: DateTime.now().toUtc());

      await UserService().createNewUser(userModel.toJson(), userKey);
    }
  }
}
