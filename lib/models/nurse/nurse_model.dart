import 'package:private_nurse_for_client/models/emergency_contact/patient_emergency_contact_model.dart';

class NurseModel {
  int? id;
  String? licenseNo;
  String? workExperience;
  String? nationality;
  int? nationalityId;
  String? race;
  int? raceId;
  String? educationLevel;
  int? educationLevelId;
  String? collegeName;
  PatientEmergencyContactModel? emergencyContact;
  String? income;
  bool? isCompanyNurse;
  int? totalPatientServed;
  int? points;
  int? totalFeedback;
  String? averageRating;
  int? applyJobStatusId;
  String? applyJobStatus;

  NurseModel(
      {this.id,
      this.licenseNo,
      this.workExperience,
      this.nationality,
      this.nationalityId,
      this.race,
      this.raceId,
      this.educationLevel,
      this.educationLevelId,
      this.collegeName,
      this.emergencyContact,
      this.income,
      this.isCompanyNurse,
      this.totalPatientServed,
      this.points,
      this.totalFeedback,
      this.averageRating,
      this.applyJobStatusId,
      this.applyJobStatus});

  NurseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    licenseNo = json['license_no'];
    workExperience = json['work_experience'];
    nationality = json['nationality'];
    nationalityId = json['nationality_id'];
    race = json['race'];
    raceId = json['race_id'];
    educationLevel = json['education_level'];
    educationLevelId = json['education_level_id'];
    collegeName = json['college_name'];
    emergencyContact = json['emergency_contact'] != null
        ? new PatientEmergencyContactModel.fromJson(json['emergency_contact'])
        : null;
    income = json['income'];
    isCompanyNurse = json['is_company_nurse'];
    totalPatientServed = json['total_patient_served'];
    points = json['points'];
    totalFeedback = json['total_feedback'];
    averageRating = json['average_rating'];
    applyJobStatusId = json['apply_job_status_id'];
    applyJobStatus = json['apply_job_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['license_no'] = this.licenseNo;
    data['work_experience'] = this.workExperience;
    data['nationality'] = this.nationality;
    data['nationality_id'] = this.nationalityId;
    data['race'] = this.race;
    data['race_id'] = this.raceId;
    data['education_level'] = this.educationLevel;
    data['education_level_id'] = this.educationLevelId;
    data['college_name'] = this.collegeName;
    if (this.emergencyContact != null) {
      data['emergency_contact'] = this.emergencyContact!.toJson();
    }
    data['income'] = this.income;
    data['is_company_nurse'] = this.isCompanyNurse;
    data['total_patient_served'] = this.totalPatientServed;
    data['points'] = this.points;
    data['total_feedback'] = this.totalFeedback;
    data['average_rating'] = this.averageRating;
    data['apply_job_status_id'] = this.applyJobStatusId;
    data['apply_job_status'] = this.applyJobStatus;
    return data;
  }
}