import 'package:private_nurse_for_client/helpers/base_api_response.dart';
import 'package:private_nurse_for_client/models/paginator_model.dart';
import 'package:private_nurse_for_client/models/service/service_model.dart';

class ServiceListResponseModel
    extends BaseAPIResponse<List<ServiceModel>, void> {
  ServiceListResponseModel(fullJson) : super(fullJson);

  @override
  dataToJson(List<ServiceModel>? data) {
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
  List<ServiceModel>? jsonToData(Map<String, dynamic>? json) {
    if (json != null) {
      data = [];

      json["data"].forEach((v) {
        data!.add(ServiceModel.fromJson(v));
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
