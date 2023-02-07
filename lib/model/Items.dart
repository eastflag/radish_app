import 'Address.dart';
import 'Point.dart';

class Items {
  Items({
      this.id,
      this.address,
      this.point,});

  Items.fromJson(dynamic json) {
    id = json['id'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    point = json['point'] != null ? Point.fromJson(json['point']) : null;
  }
  String? id;
  Address? address;
  Point? point;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    if (point != null) {
      map['point'] = point?.toJson();
    }
    return map;
  }

}
