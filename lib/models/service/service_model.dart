
class ServiceModel {
  int? id;
  String? name;
  String? description;
  String? note;
  String? type;
  int? typeId;
  String? hour;
  String? photoPath;

  ServiceModel(
      {this.id,
      this.name,
      this.description,
      this.note,
      this.type,
      this.typeId,
      this.hour,
      this.photoPath});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    note = json['note'];
    type = json['type'];
    typeId = json['type_id'];
    hour = json['hour'];
    photoPath = json['photo_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['note'] = this.note;
    data['type'] = this.type;
    data['type_id'] = this.typeId;
    data['hour'] = this.hour;
    data['photo_path'] = this.photoPath;
    return data;
  }
}
