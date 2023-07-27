
import 'package:private_nurse_for_client/models/nurse/nurse_model.dart';

class ListOfAppliedNurseModel {
  int? id;
  String? name;
  String? dob;
  String? age;
  String? phoneNo;
  String? address;
  String? email;
  String? profilePhoto;
  String? rejectedReason;
  String? gender;
  int? genderId;
  int? worldDivisionId;
  String? worldDivision;
  int? worldCityId;
  String? worldCity;
  String? registrationStatus;
  int? registrationStatusId;
  NurseModel? nurse;

  ListOfAppliedNurseModel(
      {this.id,
      this.name,
      this.dob,
      this.age,
      this.phoneNo,
      this.address,
      this.email,
      this.profilePhoto,
      this.rejectedReason,
      this.gender,
      this.genderId,
      this.worldDivisionId,
      this.worldDivision,
      this.worldCityId,
      this.worldCity,
      this.registrationStatus,
      this.registrationStatusId,
      this.nurse});

  ListOfAppliedNurseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dob = json['dob'];
    age = json['age'];
    phoneNo = json['phone_no'];
    address = json['address'];
    email = json['email'];
    profilePhoto = json['profile_photo'];
    rejectedReason = json['rejected_reason'];
    gender = json['gender'];
    genderId = json['gender_id'];
    worldDivisionId = json['world_division_id'];
    worldDivision = json['world_division'];
    worldCityId = json['world_city_id'];
    worldCity = json['world_city'];
    registrationStatus = json['registration_status'];
    registrationStatusId = json['registration_status_id'];
    nurse = json['nurse'] != null ? new NurseModel.fromJson(json['nurse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['phone_no'] = this.phoneNo;
    data['address'] = this.address;
    data['email'] = this.email;
    data['profile_photo'] = this.profilePhoto;
    data['rejected_reason'] = this.rejectedReason;
    data['gender'] = this.gender;
    data['gender_id'] = this.genderId;
    data['world_division_id'] = this.worldDivisionId;
    data['world_division'] = this.worldDivision;
    data['world_city_id'] = this.worldCityId;
    data['world_city'] = this.worldCity;
    data['registration_status'] = this.registrationStatus;
    data['registration_status_id'] = this.registrationStatusId;
    if (this.nurse != null) {
      data['nurse'] = this.nurse!.toJson();
    }
    return data;
  }
}