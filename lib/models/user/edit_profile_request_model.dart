import 'package:image_picker/image_picker.dart';

class EditProfileRequestModel {
  XFile? photoPath;

  String? address;
  String? worldCityId;
  String? worldDivisionId;
  String? phoneNo;

  EditProfileRequestModel({
    this.photoPath,
    this.address,
    this.worldCityId,
    this.worldDivisionId,
    this.phoneNo,
  });

  EditProfileRequestModel.fromJson(Map<String, dynamic> json) {
    address = json['user[address]'];
    worldCityId = json['user[world_city_id]'];
    worldDivisionId = json['user[world_division_id]'];
    phoneNo = json['user[phone_no]'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();

    data['user[address]'] = this.address!;
    data['user[world_city_id]'] = this.worldCityId.toString();
    data['user[world_division_id]'] = this.worldDivisionId.toString();
    data['user[phone_no]'] = this.phoneNo!;
    return data;
  }
}
