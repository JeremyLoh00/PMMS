class EmergencyContactModel {
  int? id;
  String? name;
  String? phoneNo;
  String? relationship;
  int? relationshipId;

  EmergencyContactModel(
      {this.id,
      this.name,
      this.phoneNo,
      this.relationship,
      this.relationshipId});

  EmergencyContactModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNo = json['phone_no'];
    relationship = json['relationship'];
    relationshipId = json['relationship_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone_no'] = this.phoneNo;
    data['relationship'] = this.relationship;
    data['relationship_id'] = this.relationshipId;
    return data;
  }
}