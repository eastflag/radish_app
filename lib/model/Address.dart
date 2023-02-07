class Address {
  Address({
      this.zipcode,
      this.category,
      this.road,
      this.parcel,
      this.bldnm,
      this.bldnmdc,});

  Address.fromJson(dynamic json) {
    zipcode = json['zipcode'];
    category = json['category'];
    road = json['road'];
    parcel = json['parcel'];
    bldnm = json['bldnm'];
    bldnmdc = json['bldnmdc'];
  }
  String? zipcode;
  String? category;
  String? road;
  String? parcel;
  String? bldnm;
  String? bldnmdc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['zipcode'] = zipcode;
    map['category'] = category;
    map['road'] = road;
    map['parcel'] = parcel;
    map['bldnm'] = bldnm;
    map['bldnmdc'] = bldnmdc;
    return map;
  }

}
