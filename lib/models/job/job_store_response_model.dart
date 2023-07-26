import 'package:private_nurse_for_client/helpers/base_api_response.dart';
import 'package:private_nurse_for_client/models/job/job_form_error_model.dart';
import 'package:private_nurse_for_client/models/paginator_model.dart';

class JobStoreResponseModel
    extends BaseAPIResponse<dynamic, JobFormErrorModel> {
  JobStoreResponseModel(fullJson) : super(fullJson);

  @override
  dataToJson(data) {
    return null;
  }

  @override
  errorsToJson(errors) {
    return null;
  }

  @override
  jsonToData(Map<String, dynamic>? json) {
    if (json != null) {
      return json["data"];
    }
  }

  @override
  JobFormErrorModel? jsonToError(Map<String, dynamic> json) {
    if (json["errors"] != null) {
      return JobFormErrorModel.fromJson(json["errors"]);
    }
    return null;
  }

  @override
  PaginatorModel? jsonToPaginator(Map<String, dynamic> json) {
    return null;
  }

  @override
  PaginatorModel? paginatorToJson(PaginatorModel? paginatorModel) {
    return null;
  }
}
