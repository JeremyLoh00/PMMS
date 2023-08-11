
import 'package:private_nurse_for_client/helpers/base_api_response.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/paginator_model.dart';

class JobResponseModel extends BaseAPIResponse<JobModel, Null> {
  JobResponseModel(fullJson) : super(fullJson);

  @override
  dataToJson(JobModel? data) {
    if (this.data != null) {
      return this.data!.toJson();
    }
    return null;
  }

  @override
  errorsToJson(Null errors) {
    return null;
  }

  @override
  JobModel? jsonToData(Map<String, dynamic>? json) {
    return json!["data"] != null ? JobModel.fromJson(json["data"]) : null;
  }

  @override
  Null jsonToError(Map<String, dynamic> json) {
    return null;
  }

  @override
  PaginatorModel? jsonToPaginator(Map<String, dynamic> json) {
   
    throw UnimplementedError();
  }

  @override
  PaginatorModel? paginatorToJson(PaginatorModel? paginatorModel) {
   
    throw UnimplementedError();
  }
}