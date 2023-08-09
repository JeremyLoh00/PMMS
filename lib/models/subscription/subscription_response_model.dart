import 'package:private_nurse_for_client/helpers/base_api_response.dart';
import 'package:private_nurse_for_client/models/paginator_model.dart';
import 'package:private_nurse_for_client/models/subscription/subscription_model.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';

class SubscriptionResponseModel extends BaseAPIResponse<SubscriptionModel, Null> {
  SubscriptionResponseModel(fullJson) : super(fullJson);

  @override
  dataToJson(SubscriptionModel? data) {
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
  SubscriptionModel? jsonToData(Map<String, dynamic>? json) {
    return json!["data"] != null ? SubscriptionModel.fromJson(json["data"]) : null;
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
