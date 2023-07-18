import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class RegisterClientRequestModel {
  XFile? profilePhoto;
  XFile? formalPhoto1Path;
  XFile? formalPhoto2Path;
  XFile? idFilePath;
  XFile? licenseFilePath;
  XFile? workExperienceFilePath;
// user model
  String? name;
  String? icNo;
  String? phoneNo;
  String? address;
  String? email;
  String? password;
  String? accountNumber;
  int? bankId;
  int? genderId;
  int? worldDivisionId;
  int? worldCityId;

  //nurse model
  int? nationalityId;
  int? educationLevelId;
  String? collegeName;
  String? licenseNo;
  String? workExperience;
  int? raceId;
  // emergency c model

  String? ecName;
  String? ecPhoneNo;
  int? relationship;

  RegisterClientRequestModel({
    this.name,
    this.icNo,
    this.phoneNo,
    this.address,
    this.email,
    this.password,
    this.accountNumber,
    this.bankId,
    this.genderId,
    this.worldDivisionId,
    this.worldCityId,
    this.formalPhoto1Path,
    this.formalPhoto2Path,
    this.idFilePath,
    this.licenseFilePath,
    this.workExperienceFilePath,
    this.nationalityId,
    this.educationLevelId,
    this.collegeName,
    this.licenseNo,
    this.workExperience,
    this.raceId,
    this.ecName,
    this.ecPhoneNo,
    this.relationship,
  });

  RegisterClientRequestModel.fromJson(Map<String, dynamic> json) {
    // profilePhoto = json['profile_photo'];
    // formalPhoto1Path = json['formal_photo_1_path'];
    // formalPhoto2Path = json['formal_photo_2_path'];
    // idFilePath = json["id_file_path"];
    // licenseFilePath = json["license_file_path"];
    // workExperienceFilePath = json["work_experience_file_path"];
    name = json['name'];
    bankId = json['bank_id'];
    genderId = json['gender'];
    worldCityId = json['world_city_id'];
    password = json['password'];
    address = json['address'];
    worldDivisionId = json['world_division_id'];
    worldCityId = json['world_city_id'];
    email = json['email'];
    phoneNo = json['phone_no'];
    icNo = json['ic_no'];
    accountNumber = json['acc_no'];

    //nurse model
    nationalityId = json['nationality_id'];
    educationLevelId = json['education_level'];
    collegeName = json['college_name'];
    licenseNo = json['license_no'];
    workExperience = json['work_experience'];
    raceId = json['race'];

    //ec model
    ecName = json['name'];
    ecPhoneNo = json['phone_no'];
    relationship = json['relationship'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    // data['profile_photo'] = encodeFile(this.profilePhoto!);
    // data['formal_photo_1_path'] = encodeFile(this.formalPhoto1Path!);
    // data['formal_photo_2_path'] = encodeFile(this.formalPhoto2Path!);
    // data['id_file_path'] = encodeFile(this.idFilePath!);
    // data['license_file_path'] = encodeFile(this.licenseFilePath!);
    // data['work_experience_file_path'] =
    //     encodeFile(this.workExperienceFilePath!);
    data['user[name]'] = this.name!;
    data['user[bank_id]'] = this.bankId.toString();
    data['user[gender]'] = this.genderId.toString();
    data['user[world_city_id]'] = this.worldCityId.toString();
    data['user[password]'] = this.password!;
    data['user[address]'] = this.address!;
    data['user[world_division_id]'] = this.worldDivisionId.toString();
    data['user[email]'] = this.email!;
    data['user[phone_no]'] = this.phoneNo!;
    data['user[ic_no]'] = this.icNo!;
    data['user[acc_no]'] = this.accountNumber!;

    //nurse model
    data['nurse[nationality_id]'] = this.nationalityId.toString();
    data['nurse[education_level]'] = this.educationLevelId.toString();
    data['nurse[college_name]'] = this.collegeName!;
    data['nurse[license_no]'] = this.licenseNo!;
    data['nurse[work_experience]'] = this.workExperience!;
    data['nurse[race]'] = this.raceId.toString();

    data['emergency_contact[name]'] = this.ecName!;
    data['emergency_contact[phone_no]'] = this.ecPhoneNo!;
    data['emergency_contact[relationship]'] = this.relationship!.toString();

    return data;
  }
}
