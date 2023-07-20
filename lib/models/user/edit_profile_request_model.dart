import 'package:image_picker/image_picker.dart';

class EditProfileRequestModel {
  XFile? photoPath;

  String? address;
  String? phoneNo;
  String? ecName;
  String? ecPhoneNo;
  String? worldDivisionId;
  String? worldCityId;
  String? ecRelationshipId;

  EditProfileRequestModel({
    this.photoPath,
    this.address,
    this.phoneNo,
    this.worldDivisionId,
    this.worldCityId,
    this.ecRelationshipId,
    this.ecName,
    this.ecPhoneNo,
  });

  EditProfileRequestModel.fromJson(Map<String, dynamic> json) {
    address = json['user[address]'];
    phoneNo = json['user[phone_no]'];
    worldDivisionId = json['user[world_division_id]'];
    worldCityId = json['user[world_city_id]'];
    ecRelationshipId = json['emergency_contact[relationship]'];
    ecName = json['emergency_contact[name]'];
    ecPhoneNo = json['emergency_contact[phone_no]'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();

    data['user[address]'] = this.address! ;
    data['user[phone_no]'] = this.phoneNo! ;
    data['user[world_division_id]'] = this.worldDivisionId.toString();
    data['user[world_city_id]'] = this.worldCityId.toString();
    data['emergency_contact[relationship]'] = this.ecRelationshipId.toString();
    data['emergency_contact[name]'] = this.ecName!;
    data['emergency_contact[phone_no]'] = this.ecPhoneNo!;
    return data;
  }
}
