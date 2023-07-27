import 'package:private_nurse_for_client/models/job_schedule/job_schedule_model.dart';
import 'package:private_nurse_for_client/models/list_of_applied_nurse/list_of_applied_nurse_model.dart';
import 'package:private_nurse_for_client/models/patient/patient_model.dart';
import 'package:private_nurse_for_client/models/service/service_model.dart';

class JobModel {
  int? id;
  PatientModel? patient;
  ServiceModel? service;
  String? systemServiceFee;
  String? nursingServiceFee;
  String? totalServiceFee;
  List<JobScheduleModel>? jobSchedule;
  String? status;
  int? statusId;
  List<ListOfAppliedNurseModel>? listOfAppliedNurse;

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
      this.listOfAppliedNurse});

  JobModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patient =
        json['patient'] != null ? new PatientModel.fromJson(json['patient']) : null;
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
    status = json['status'];
    statusId = json['status_id'];
    if (json['list_of_applied_nurse'] != null) {
      listOfAppliedNurse = <ListOfAppliedNurseModel>[];
      json['list_of_applied_nurse'].forEach((v) {
        listOfAppliedNurse!.add(new ListOfAppliedNurseModel.fromJson(v));
      });
    }
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
    if (this.listOfAppliedNurse != null) {
      data['list_of_applied_nurse'] =
          this.listOfAppliedNurse!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}







