import 'Items.dart';

class Result {
  Result({
      this.crs,
      this.type,
      this.items,});

  Result.fromJson(dynamic json) {
    crs = json['crs'];
    type = json['type'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }
  String? crs;
  String? type;
  List<Items>? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['crs'] = crs;
    map['type'] = type;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
