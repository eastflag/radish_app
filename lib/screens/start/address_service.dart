import 'package:dio/dio.dart';
import 'package:radish_app/constants/keys.dart';
import 'package:radish_app/model/AddressModel.dart';
import 'package:radish_app/model/AddressPointModel.dart';

import 'intro_page.dart';

class AddressService {
  Future<AddressModel> SearchAddressByStr(String text) async {
    final formData = {
      // 'service': 'search',
      'key': VWORLD_KEY,
      'request': 'search',
      'type': 'ADDRESS',
      'category': 'ROAD',
      'query': text,
      'size': 30
    };

    final response = await Dio().get('http://api.vworld.kr/req/search', queryParameters: formData).catchError((e) {
      logger.e(e.message);
    });

    AddressModel addressModel = AddressModel.fromJson(response.data["response"]);

    logger.d(addressModel);

    return addressModel;
  }

  Future<List<AddressPointModel>> findAddressByCoordinate({required double log, required double lat}) async {
    final List<Map<String, dynamic>> formDatas = <Map<String, dynamic>>[];

    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'GetAddress',
      'type': 'PARCEL',
      'point': '$log,$lat',
    });

    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'GetAddress',
      'type': 'PARCEL',
      'point': '${log + 0.01},$lat',
    });

    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'GetAddress',
      'type': 'PARCEL',
      'point': '${log - 0.01},$lat',
    });

    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'GetAddress',
      'type': 'PARCEL',
      'point': '$log,${lat + 0.01}',
    });

    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'GetAddress',
      'type': 'PARCEL',
      'point': '$log,${lat - 0.01}',
    });

    List<AddressPointModel> addressList = [];

    for (Map<String, dynamic> formData in formDatas) {
      final response = await Dio().get('http://api.vworld.kr/req/address', queryParameters: formData).catchError((e) {
        logger.e(e.message);
      });

      AddressPointModel addressPointModel = AddressPointModel.fromJson(response.data["response"]);
      addressList.add(addressPointModel);
    }

    return addressList;
  }
}
