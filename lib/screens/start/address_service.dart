import 'package:dio/dio.dart';
import 'package:radish_app/constants/keys.dart';
import 'package:radish_app/model/AddressModel.dart';

import 'intro_page.dart';

class AddressService {
  Future<AddressModel> SearchAddressByStr (String text) async {
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
}
