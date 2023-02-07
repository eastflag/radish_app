class Point {
  Point({
      this.x,
      this.y,});

  Point.fromJson(dynamic json) {
    x = json['x'];
    y = json['y'];
  }
  String? x;
  String? y;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['x'] = x;
    map['y'] = y;
    return map;
  }

}
