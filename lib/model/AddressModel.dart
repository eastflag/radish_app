import 'Page.dart';
import 'Result.dart';

class AddressModel {
  AddressModel({
      this.page,
      this.result,});

  AddressModel.fromJson(dynamic json) {
    page = json['page'] != null ? Page.fromJson(json['page']) : null;
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  Page? page;
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (page != null) {
      map['page'] = page?.toJson();
    }
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }

}
