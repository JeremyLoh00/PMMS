import 'package:private_nurse_for_client/models/condition/condition_model.dart';
import 'package:private_nurse_for_client/models/diagnosis/diagnosis_model.dart';
import 'package:private_nurse_for_client/models/emergency_contact/patient_emergency_contact_model.dart';
import 'package:private_nurse_for_client/models/feedback/feedback_model.dart';
import 'package:private_nurse_for_client/models/job_schedule/job_schedule_model.dart';
import 'package:private_nurse_for_client/models/list_of_applied_nurse/list_of_applied_nurse_model.dart';
import 'package:private_nurse_for_client/models/medical_history/medical_history_model.dart';
import 'package:private_nurse_for_client/models/patient/patient_model.dart';
import 'package:private_nurse_for_client/models/service/service_model.dart';
class JobModel {
  int? id;
  int? jobStatusId;
  String? jobStatus;
  ServiceModel? service;
  String? systemServiceFee;
  String? nursingServiceFee;
  String? totalServiceFee;
  List<JobScheduleModel>? jobSchedule;
  PatientModel? patient;
  String? address;
  int? worldDivisionId;
  String? worldDivision;
  int? worldCityId;
  String? worldCity;
  String? phoneNo;
  String? height;
  String? weight;
  List<String>? patientPhotoList;
  String? allMedicalHistories;
  List<MedicalHistoryModel>? medicalHistories;
  String? allCondition;
  List<ConditionModel>? conditions;
  String? allDiagnosis;
  List<DiagnosisModel>? diagnoses;
  PatientEmergencyContactModel? patientEmergencyContact;
  List<ListOfAppliedNurseModel>? listOfAppliedNurse;
  List<FeedbackModel>? feedbacks;

  JobModel(
      {this.id,
      this.jobStatusId,
      this.jobStatus,
      this.service,
      this.systemServiceFee,
      this.nursingServiceFee,
      this.totalServiceFee,
      this.jobSchedule,
      this.patient,
      this.address,
      this.worldDivisionId,
      this.worldDivision,
      this.worldCityId,
      this.worldCity,
      this.phoneNo,
      this.height,
      this.weight,
      this.patientPhotoList,
      this.allMedicalHistories,
      this.medicalHistories,
      this.allCondition,
      this.conditions,
      this.allDiagnosis,
      this.diagnoses,
      this.patientEmergencyContact,
      this.listOfAppliedNurse,
      this.feedbacks});

  JobModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobStatusId = json['job_status_id'];
    jobStatus = json['job_status'];
    service =
        json['service'] != null ? new ServiceModel.fromJson(json['service']) : null;
    systemServiceFee = json['system_service_fee'];
    nursingServiceFee = json['nursing_service_fee'];
    totalServiceFee = json['total_service_fee'];
    if (json['job_schedule'] != null) {
      jobSchedule = <JobScheduleModel>[];
      json['job_schedule'].forEach((v) {
        jobSchedule!.add(new JobScheduleModel.fromJson(v));
      });
    }
    patient =
        json['patient'] != null ? new PatientModel.fromJson(json['patient']) : null;
    address = json['address'];
    worldDivisionId = json['world_division_id'];
    worldDivision = json['world_division'];
    worldCityId = json['world_city_id'];
    worldCity = json['world_city'];
    phoneNo = json['phone_no'];
    height = json['height'];
    weight = json['weight'];
    patientPhotoList = json['patient_photo_list'].cast<String>();
    allMedicalHistories = json['all_medical_histories'];
    if (json['medical_histories'] != null) {
      medicalHistories = <MedicalHistoryModel>[];
      json['medical_histories'].forEach((v) {
        medicalHistories!.add(new MedicalHistoryModel.fromJson(v));
      });
    }
    allCondition = json['all_condition'];
    if (json['conditions'] != null) {
      conditions = <ConditionModel>[];
      json['conditions'].forEach((v) {
        conditions!.add(new ConditionModel.fromJson(v));
      });
    }
    allDiagnosis = json['all_diagnosis'];
    if (json['diagnoses'] != null) {
      diagnoses = <DiagnosisModel>[];
      json['diagnoses'].forEach((v) {
        diagnoses!.add(new DiagnosisModel.fromJson(v));
      });
    }
    patientEmergencyContact = json['patient_emergency_contact'] != null
        ? new PatientEmergencyContactModel.fromJson(
            json['patient_emergency_contact'])
        : null;
    if (json['list_of_applied_nurse'] != null) {
      listOfAppliedNurse = <ListOfAppliedNurseModel>[];
      json['list_of_applied_nurse'].forEach((v) {
        listOfAppliedNurse!.add(new ListOfAppliedNurseModel.fromJson(v));
      });
    }
    if (json['feedbacks'] != null) {
      feedbacks = <FeedbackModel>[];
      json['feedbacks'].forEach((v) {
        feedbacks!.add(new FeedbackModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_status_id'] = this.jobStatusId;
    data['job_status'] = this.jobStatus;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    data['system_service_fee'] = this.systemServiceFee;
    data['nursing_service_fee'] = this.nursingServiceFee;
    data['total_service_fee'] = this.totalServiceFee;
    if (this.jobSchedule != null) {
      data['job_schedule'] = this.jobSchedule!.map((v) => v.toJson()).toList();
    }
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    data['address'] = this.address;
    data['world_division_id'] = this.worldDivisionId;
    data['world_division'] = this.worldDivision;
    data['world_city_id'] = this.worldCityId;
    data['world_city'] = this.worldCity;
    data['phone_no'] = this.phoneNo;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['patient_photo_list'] = this.patientPhotoList;
    data['all_medical_histories'] = this.allMedicalHistories;
    if (this.medicalHistories != null) {
      data['medical_histories'] =
          this.medicalHistories!.map((v) => v.toJson()).toList();
    }
    data['all_condition'] = this.allCondition;
    if (this.conditions != null) {
      data['conditions'] = this.conditions!.map((v) => v.toJson()).toList();
    }
    data['all_diagnosis'] = this.allDiagnosis;
    if (this.diagnoses != null) {
      data['diagnoses'] = this.diagnoses!.map((v) => v.toJson()).toList();
    }
    if (this.patientEmergencyContact != null) {
      data['patient_emergency_contact'] =
          this.patientEmergencyContact!.toJson();
    }
    if (this.listOfAppliedNurse != null) {
      data['list_of_applied_nurse'] =
          this.listOfAppliedNurse!.map((v) => v.toJson()).toList();
    }
    if (this.feedbacks != null) {
      data['feedbacks'] = this.feedbacks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}




// class JobModel {
//   int? id;
//   PatientModel? patient;
//   ServiceModel? service;
//   String? systemServiceFee;
//   String? nursingServiceFee;
//   String? totalServiceFee;
//   List<JobScheduleModel>? jobSchedule;
//   String? status;
//   int? statusId;
//   List<ListOfAppliedNurseModel>? listOfAppliedNurse;
//   String? address;
//   String? phoneNo;
//   List<FeedbackModel>? feedbacks;
//   String? height;
//   String? weight;
//   String? patientPhoto1Path;
//   String? patientPhoto2Path;
//   String? allMedicalHistories;
//   String? allCondition;
//   String? allDiagnosis;
//   EmergencyContactModel? emergencyContact;

//   JobModel(
//       {this.id,
//       this.patient,
//       this.service,
//       this.systemServiceFee,
//       this.nursingServiceFee,
//       this.totalServiceFee,
//       this.jobSchedule,
//       this.status,
//       this.statusId,
//       this.listOfAppliedNurse,
//       this.address,
//       this.phoneNo,
//       this.feedbacks,
//       this.height,
//       this.weight,
//       this.patientPhoto1Path,
//       this.patientPhoto2Path,
//       this.allMedicalHistories,
//       this.allCondition,
//       this.allDiagnosis,
//       this.emergencyContact});

//   JobModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     patient =
//         json['patient'] != null ? new PatientModel.fromJson(json['patient']) : null;
//     service =
//         json['service'] != null ? new ServiceModel.fromJson(json['service']) : null;
//     systemServiceFee = json['system_service_fee'];
//     nursingServiceFee = json['nursing_service_fee'];
//     totalServiceFee = json['total_service_fee'];
//     if (json['job_schedule'] != null) {
//       jobSchedule = <JobScheduleModel>[];
//       json['job_schedule'].forEach((v) {
//         jobSchedule!.add(new JobScheduleModel.fromJson(v));
//       });
//     }
//     status = json['status'];
//     statusId = json['status_id'];
//     if (json['list_of_applied_nurse'] != null) {
//       listOfAppliedNurse = <ListOfAppliedNurseModel>[];
//       json['list_of_applied_nurse'].forEach((v) {
//         listOfAppliedNurse!.add(new ListOfAppliedNurseModel.fromJson(v));
//       });
//     }
//     address = json['address'];
//     phoneNo = json['phone_no'];
//     if (json['feedbacks'] != null) {
//       feedbacks = <FeedbackModel>[];
//       json['feedbacks'].forEach((v) {
//         feedbacks!.add(new FeedbackModel.fromJson(v));
//       });
//     }
//     height = json['height'];
//     weight = json['weight'];
//     patientPhoto1Path = json['patient_photo_1_path'];
//     patientPhoto2Path = json['patient_photo_2_path'];
//     allMedicalHistories = json['all_medical_histories'];
//     allCondition = json['all_condition'];
//     allDiagnosis = json['all_diagnosis'];
//     emergencyContact = json['emergency_contact'] != null
//         ? new EmergencyContactModel.fromJson(json['emergency_contact'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.patient != null) {
//       data['patient'] = this.patient!.toJson();
//     }
//     if (this.service != null) {
//       data['service'] = this.service!.toJson();
//     }
//     data['system_service_fee'] = this.systemServiceFee;
//     data['nursing_service_fee'] = this.nursingServiceFee;
//     data['total_service_fee'] = this.totalServiceFee;
//     if (this.jobSchedule != null) {
//       data['job_schedule'] = this.jobSchedule!.map((v) => v.toJson()).toList();
//     }
//     data['status'] = this.status;
//     data['status_id'] = this.statusId;
//     if (this.listOfAppliedNurse != null) {
//       data['list_of_applied_nurse'] =
//           this.listOfAppliedNurse!.map((v) => v.toJson()).toList();
//     }
//     data['address'] = this.address;
//     data['phone_no'] = this.phoneNo;
//     if (this.feedbacks != null) {
//       data['feedbacks'] = this.feedbacks!.map((v) => v.toJson()).toList();
//     }
//     data['height'] = this.height;
//     data['weight'] = this.weight;
//     data['patient_photo_1_path'] = this.patientPhoto1Path;
//     data['patient_photo_2_path'] = this.patientPhoto2Path;
//     data['all_medical_histories'] = this.allMedicalHistories;
//     data['all_condition'] = this.allCondition;
//     data['all_diagnosis'] = this.allDiagnosis;
//     if (this.emergencyContact != null) {
//       data['emergency_contact'] = this.emergencyContact!.toJson();
//     }
//     return data;
//   }
// }
