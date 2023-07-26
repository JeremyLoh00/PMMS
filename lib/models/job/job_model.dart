import 'package:private_nurse_for_client/models/emergency_contact/emergency_contact_model.dart';
import 'package:private_nurse_for_client/models/patient/patient_model.dart';
import 'package:private_nurse_for_client/models/job/schedule_model.dart';
import 'package:private_nurse_for_client/models/review/review_model.dart';
import 'package:private_nurse_for_client/models/service/service_model.dart';

class JobModel {
  int? id;
  PatientModel? patient;
  ServiceModel? service;
  String? systemServiceFee;
  String? nursingServiceFee;
  String? totalServiceFee;
  List<ScheduleModel>? jobSchedule;
  String? status;
  int? statusId;
  String? address;
  String? phoneNo;
  List<ReviewModel>? feedbacks;
  String? height;
  String? weight;
  String? patientPhoto1Path;
  String? patientPhoto2Path;
  String? allMedicalHistories;
  String? allCondition;
  String? allDiagnosis;
  EmergencyContactModel? emergencyContact;

  JobModel(
      {this.id,
      this.patient,
      this.service,
      this.systemServiceFee,
      this.nursingServiceFee,
      this.totalServiceFee,
      this.jobSchedule,
      this.status,
      this.statusId,
      this.address,
      this.phoneNo,
      this.feedbacks,
      this.height,
      this.weight,
      this.patientPhoto1Path,
      this.patientPhoto2Path,
      this.allMedicalHistories,
      this.allCondition,
      this.allDiagnosis,
      this.emergencyContact});

  JobModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patient = json['patient'] != null
        ? new PatientModel.fromJson(json['patient'])
        : null;
    service = json['service'] != null
        ? new ServiceModel.fromJson(json['service'])
        : null;
    systemServiceFee = json['system_service_fee'];
    nursingServiceFee = json['nursing_service_fee'];
    totalServiceFee = json['total_service_fee'];
    if (json['job_schedule'] != null) {
      jobSchedule = <ScheduleModel>[];
      json['job_schedule'].forEach((v) {
        jobSchedule!.add(new ScheduleModel.fromJson(v));
      });
    }
    status = json['status'];
    statusId = json['status_id'];
    address = json['address'];
    phoneNo = json['phone_no'];
    if (json['feedbacks'] != null) {
      feedbacks = <ReviewModel>[];
      json['feedbacks'].forEach((v) {
        feedbacks!.add(new ReviewModel.fromJson(v));
      });
    }
    height = json['height'];
    weight = json['weight'];
    patientPhoto1Path = json['patient_photo_1_path'];
    patientPhoto2Path = json['patient_photo_2_path'];
    allMedicalHistories = json['all_medical_histories'];
    allCondition = json['all_condition'];
    allDiagnosis = json['all_diagnosis'];
    emergencyContact = json['emergency_contact'] != null
        ? new EmergencyContactModel.fromJson(json['emergency_contact'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    data['system_service_fee'] = this.systemServiceFee;
    data['nursing_service_fee'] = this.nursingServiceFee;
    data['total_service_fee'] = this.totalServiceFee;
    if (this.jobSchedule != null) {
      data['job_schedule'] = this.jobSchedule!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['status_id'] = this.statusId;
    data['address'] = this.address;
    data['phone_no'] = this.phoneNo;
    if (this.feedbacks != null) {
      data['feedbacks'] = this.feedbacks!.map((v) => v.toJson()).toList();
    }
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['patient_photo_1_path'] = this.patientPhoto1Path;
    data['patient_photo_2_path'] = this.patientPhoto2Path;
    data['all_medical_histories'] = this.allMedicalHistories;
    data['all_condition'] = this.allCondition;
    data['all_diagnosis'] = this.allDiagnosis;
    if (this.emergencyContact != null) {
      data['emergency_contact'] = this.emergencyContact!.toJson();
    }
    return data;
  }
}
