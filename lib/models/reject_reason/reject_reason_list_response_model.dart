import 'package:private_nurse_for_client/helpers/base_api_response.dart';
import 'package:private_nurse_for_client/models/paginator_model.dart';
import 'package:private_nurse_for_client/models/reject_reason/list_reject_reason_model.dart';

class RejectReasonListResponseModel
    extends BaseAPIResponse<List<ListRejectReasonModel>, void> {
  RejectReasonListResponseModel(fullJson) : super(fullJson);

  @override
  dataToJson(List<ListRejectReasonModel>? data) {
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
  List<ListRejectReasonModel>? jsonToData(Map<String, dynamic>? json) {
     if (json != null) {
      data = [];

      json["data"].forEach((v) {
        data!.add(ListRejectReasonModel.fromJson(v));
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
