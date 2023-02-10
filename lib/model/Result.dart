import 'Items.dart';

class Result {
  Result({
      this.crs,
      this.type,
      this.text,
      this.items,});

  Result.fromJson(dynamic json) {
    crs = json['crs'];
    type = json['type'];
    text = json['text'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }
  String? crs;
  String? type;
  String? text;
  List<Items>? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['crs'] = crs;
    map['type'] = type;
    map['text'] = text;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
