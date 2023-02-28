import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:radish_app/constants/data_keys.dart';

import '../model/Movie.dart';
import '../model/user_model.dart';

class UserService {
  // 싱글턴 패턴 실행
  static final UserService _userService = UserService._internal();
  factory UserService() => _userService;
  UserService._internal();

  Future createNewUser(Map<String, dynamic> json, String userKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);

    final DocumentSnapshot documentSnapshot = await documentReference.get();

    if (!documentSnapshot.exists) {
      await documentReference.set(json);
    }
  }

  Future fireStoreWriteTest() async{
    await FirebaseFirestore.instance
        .collection('TEST_COLLECTION')
        .add({
          'test': 'testing value',
          'number': '123456'
        });
  }

  // 파이어스토어에서 유저정보 불러오기(캐시저장용)
  Future<UserModel> getUserModel(String userKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
      FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);

    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentReference.get();

    UserModel userModel = UserModel.fromSnapshot(documentSnapshot);
    return userModel;
  }
}
