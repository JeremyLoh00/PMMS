import 'package:private_nurse_for_client/helpers/base_api_response.dart';
import 'package:private_nurse_for_client/models/list_feedback_for_specific_nurse/list_feedback_for_specific_nurse_model.dart';
import 'package:private_nurse_for_client/models/nurse/nurse_model.dart';
import 'package:private_nurse_for_client/models/paginator_model.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';

class ListFeedbackResponseModel extends BaseAPIResponse<List<ListFeedbackForSpecificNurseModel>, Null> {
  ListFeedbackResponseModel(fullJson) : super(fullJson);

  @override
  dataToJson(List<ListFeedbackForSpecificNurseModel>? data) {
    if (this.data != null) {
      return this.data?.map((v) => v.toJson()).toList();
    }
    return null;
  }

  @override
  errorsToJson(Null errors) {
    return null;
  }

  @override
  List<ListFeedbackForSpecificNurseModel>? jsonToData(Map<String, dynamic>? json) {
    if (json != null) {
      data = [];

      json["data"].forEach((v) {
        data!.add(ListFeedbackForSpecificNurseModel.fromJson(v));
      });

      return data!;
    }

    return null;
  }

  @override
  Null jsonToError(Map<String, dynamic> json) {
    return null;
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
