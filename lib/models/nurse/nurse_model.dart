import 'package:private_nurse_for_client/models/emergency_contact/emergency_contact_model.dart';

class NurseModel {
  int? id;
  int? nationalityId;
  String? nationality;
  int? educationLevelId;
  String? collegeName;
  String? licenseNo;
  String? workExperience;
  int? raceId;
  String? race;
  String? educationLevel;
  EmergencyContactModel? emergencyContactModel;
  int? income;
  bool? isCompanyNurse;

  NurseModel(
      {this.id,
      this.nationalityId,
      this.nationality,
      this.educationLevelId,
      this.collegeName,
      this.licenseNo,
      this.workExperience,
      this.raceId,
      this.race,
      this.educationLevel,
      this.emergencyContactModel,
      this.income,
      this.isCompanyNurse});

  NurseModel.fromJson(Map<String, dynamic> json) {
    nationalityId = json['nationality_id'] ?? -1;
    id = json['id'] ?? -1;
    nationality = json['nationality'] ?? "";
    educationLevelId = json['education_level_id'] ?? -1;
    collegeName = json['college_name'] ?? '';
    licenseNo = json['license_no'] ?? "";
    workExperience = json['work_experience'] ?? "";
    raceId = json['race_id'] ?? -1;
    race = json['race'] ?? "";
    educationLevel = json['education_level'] ?? "";
    income = json['income'];
    isCompanyNurse = json['is_company_nurse'];

    emergencyContactModel = json['emergency_contact'] != null
        ? new EmergencyContactModel.fromJson(json['emergency_contact'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nationality_id'] = this.nationalityId;
    data['nationality'] = this.nationality;
    data['education_level_id'] = this.educationLevelId;
    data['education_level'] = this.educationLevel;
    data['college_name'] = this.collegeName;
    data['license_no'] = this.licenseNo;
    data['work_experience'] = this.workExperience;
    data['race_id'] = this.raceId;
    data['race'] = this.race;
    data['income'] = this.income;
    data['is_company_nurse'] = this.isCompanyNurse;
    if (this.emergencyContactModel != null) {
      data['emergency_contact'] = this.emergencyContactModel!.toJson();
    }
    return data;
  }
}
