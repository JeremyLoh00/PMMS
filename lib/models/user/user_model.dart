
import 'package:private_nurse_for_client/models/bank/bank_model.dart';
import 'package:private_nurse_for_client/models/emergency_contact/patient_emergency_contact_model.dart';
import 'package:private_nurse_for_client/models/nurse/nurse_model.dart';

class UserModel {
  int? id;
  int? bankId;
  String? name;
  String? dob;
  String? age;
  String? icNo;
  String? phoneNo;
  String? address;
  String? email;
  String? accountNumber;
  String? profilePhoto;
  String? rejectedReason;
  int? genderId;
  int? raceId;
  int? worldDivisionId;
  int? worldCityId;
  String? worldDivision;
  int? registrationStatusId;
  String? accessToken;
  String? formalPhoto1Path;
  String? formalPhoto2Path;
  String? idFilePath;
  String? licenseFilePath;
  String? workExperienceFilePath;
  NurseModel? nurseModel;

  BankModel? bankModel;
  String? collegeNursingSchool;
  String? licenseNo;
  String? workExperience;
  String? emergencyName;
  String? emergencyPhoneNo;
  String? relationship;
  int? educationId;
  int? nationalityId;
  String? password;
  bool? isPaidUniformFee;

  UserModel({
    this.id,
    this.isPaidUniformFee,
    this.bankId,
    this.rejectedReason,
    this.genderId,
    this.raceId,
    this.worldCityId,
    this.registrationStatusId,
    this.name,
    this.dob,
    this.age,
    this.address,
    this.worldDivisionId,
    this.worldDivision,
    this.email,
    this.phoneNo,
    this.icNo,
    this.accountNumber,
    this.bankModel,
    this.nurseModel,
    this.profilePhoto,
    this.accessToken,
    this.collegeNursingSchool,
    this.licenseNo,
    this.workExperience,
    this.emergencyName,
    this.emergencyPhoneNo,
    this.relationship,
    this.educationId,
    this.nationalityId,
    this.password,
    this.formalPhoto1Path,
    this.formalPhoto2Path,
    this.idFilePath,
    this.licenseFilePath,
    this.workExperienceFilePath,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isPaidUniformFee = json['is_paid_uniform_fee'];

    name = json['name'];
    bankId = json['bank_id'];

    genderId = json['gender_id'];
    raceId = json['race_id'];
    worldCityId = json['world_city_id'];
    rejectedReason = json['rejected_reason'];
    registrationStatusId = json['registration_status_id'];
    dob = json['dob'];
    age = json['age'];
    password = json['password'];
    address = json['address'];
    educationId = json['education_id'];
    nationalityId = json['nationality_id'];
    worldDivisionId = json['world_division_id'];
    worldDivision = json['world_division'];
    email = json['email'];
    phoneNo = json['phone_no'];
    icNo = json['ic_no'];
    accountNumber = json['acc_no'] ?? "";
    bankModel = json['bank'] != null
        ? new BankModel.fromJson(json['bank'])
        : new BankModel(id: -1, name: "No Bank");

    nurseModel = json['nurse'] != null
        ? new NurseModel.fromJson(json['nurse'])
        : null;

    profilePhoto = json['profile_photo'];

    accessToken = json['access_token'];
    collegeNursingSchool = json['college_name'] ?? "";
    licenseNo = json['license_no'] ?? "";
    workExperience = json['work_experience'] ?? "";
    emergencyName = json['emergency_name'] ?? "";
    emergencyPhoneNo = json['emergency_phone_no'] ?? "";
    relationship = json['relationship'] ?? "";
    formalPhoto1Path = json['formal_photo_1_path'];
    formalPhoto2Path = json['formal_photo_2_path'];
    idFilePath = json["id_file_path"];
    licenseFilePath = json["license_file_path"];
    workExperienceFilePath = json["work_experience_file_path"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    data['name'] = this.name;
    data['bank_id'] = this.bankId;
    data['rejected_reason'] = this.rejectedReason;
    data['gender_id'] = this.genderId;
    data['race_id'] = this.raceId;
    data['world_city_id'] = this.worldCityId;
    data['registration_status_id'] = this.registrationStatusId;

    data['dob'] = this.dob;
    data['age'] = this.age;
    data['address'] = this.address;
    data['world_division_id'] = this.worldDivisionId;
    data['world_division'] = this.worldDivision;
    data['password'] = this.password;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['ic_no'] = this.icNo;
    data['acc_no'] = this.accountNumber;
    if (this.bankModel != null) {
      data['bank'] = this.bankModel!.toJson();
    }
    if (this.nurseModel != null) {
      data['nurse'] = this.nurseModel!.toJson();
    }

    data['profile_photo'] = this.profilePhoto;
    data['education_id'] = this.educationId;
    data['nationality_id'] = this.nationalityId;
    data['access_token'] = this.accessToken;
    data['college_name'] = this.collegeNursingSchool;
    data['nursing_license'] = this.licenseNo;
    data['work_experience'] = this.workExperience;
    data['emergency_name'] = this.emergencyName;
    data['emergency_phone_no'] = this.emergencyPhoneNo;
    data['relationship'] = this.relationship;
    data['formal_photo_1_path'] = this.formalPhoto1Path;
    data['formal_photo_2_path'] = this.formalPhoto2Path;
    data['id_file_path'] = this.idFilePath;
    data['license_file_path'] = this.licenseFilePath;
    data['work_experience_file_path'] = this.workExperienceFilePath;
    data['is_paid_uniform_fee'] = this.isPaidUniformFee;
    return data;
  }
}
