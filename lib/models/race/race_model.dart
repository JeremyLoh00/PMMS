class RaceModel {
  int? id;
  String? name;
  String? code;
  String? value;

  RaceModel({this.id, this.name, this.code, this.value});

  RaceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['value'] = this.value;
    return data;
  }
}