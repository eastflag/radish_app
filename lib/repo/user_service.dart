import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/Movie.dart';

class UserService {
  final moviesRef = FirebaseFirestore.instance
      .collection('firestore-example-app')
      .withConverter<Movie>(
    fromFirestore: (snapshots, _) => Movie.fromJson(snapshots.data()!),
    toFirestore: (movie, _) => movie.toJson(),
  );

  Future fireStoreWriteTest() async{
    await FirebaseFirestore.instance
        .collection('TEST_COLLECTION')
        .add({
          'test': 'testing value',
          'number': '123456'
        });
  }
}
