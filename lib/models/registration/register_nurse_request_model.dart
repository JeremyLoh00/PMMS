import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class RegisterClientRequestModel {
  XFile? profilePhoto;
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
    return data;
  }
}
