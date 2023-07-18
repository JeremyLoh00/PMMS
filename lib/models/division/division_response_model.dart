import 'package:private_nurse_for_client/helpers/base_api_response.dart';
import 'package:private_nurse_for_client/models/division/division_model.dart';
import 'package:private_nurse_for_client/models/paginator_model.dart';

class DivisionResponseModel extends BaseAPIResponse<List<DivisionModel>, Null> {
  DivisionResponseModel(fullJson) : super(fullJson);

  @override
  dataToJson(List<DivisionModel>? data) {
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
  List<DivisionModel>? jsonToData(Map<String, dynamic>? json) {
    if (json != null) {
      data = [];

      json["data"].forEach((v) {
        data!.add(DivisionModel.fromJson(v));
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
