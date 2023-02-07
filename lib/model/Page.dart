class Page {
  Page({
      this.total,
      this.current,
      this.size,});

  Page.fromJson(dynamic json) {
    total = json['total'];
    current = json['current'];
    size = json['size'];
  }
  String? total;
  String? current;
  String? size;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['current'] = current;
    map['size'] = size;
    return map;
  }

}
