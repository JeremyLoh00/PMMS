import 'package:private_nurse_for_client/helpers/base_api_response.dart';
import 'package:private_nurse_for_client/models/job_schedule/job_schedule_model.dart';
import 'package:private_nurse_for_client/models/paginator_model.dart';

class ScheduleListResponseModel
    extends BaseAPIResponse<List<JobScheduleModel>, void> {
  ScheduleListResponseModel(fullJson) : super(fullJson);

  @override
  dataToJson(List<JobScheduleModel>? data) {
    if (data != null) {
      return this.data?.map((v) => v.toJson()).toList();
    }
    return null;
  }

  @override
  errorsToJson(void errors) {
    return null;
  }

  @override
  List<JobScheduleModel>? jsonToData(Map<String, dynamic>? json) {
    if (json != null) {
      data = [];

      json["data"].forEach((v) {
        data!.add(JobScheduleModel.fromJson(v));
      });

      return data!;
    }

    return null;
  }

  @override
  void jsonToError(Map<String, dynamic> json) {
    return;
  }

  @override
  PaginatorModel? jsonToPaginator(Map<String, dynamic> json) {
    // Convert json["paginator"] data to PaginatorModel
    if (json["paginator"] != null) {
      return PaginatorModel.fromJson(json["paginator"]);
    }
    return null;
  }

  @override
  PaginatorModel? paginatorToJson(PaginatorModel? paginatorModel) {
    return null;
  }
}
