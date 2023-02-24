import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String userKey;
  late String phoneNumber;
  late String address;
  late num lat;
  late num lon;
  late GeoPoint geoPoint;
  late DateTime createdDate;
  DocumentReference? reference;

  UserModel({
    required this.userKey,
    required this.phoneNumber,
    required this.address,
    required this.lat,
    required this.lon,
    required this.geoPoint,
    required this.createdDate,
    this.reference
  });

  UserModel.fromJson(dynamic json) {
    userKey = json['userKey'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    lat = json['lat'];
    lon = json['lon'];
    geoPoint = json['geoPoint'];
    createdDate = json['createdDate'];
    reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phoneNumber'] = phoneNumber;
    map['address'] = address;
    map['lat'] = lat;
    map['lon'] = lon;
    map['geoPoint'] = geoPoint;
    map['createdDate'] = createdDate;
    return map;
  }
}
