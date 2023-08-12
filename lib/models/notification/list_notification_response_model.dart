 

import 'package:private_nurse_for_client/helpers/base_api_response.dart';
import 'package:private_nurse_for_client/models/notification/notification_model.dart';
import 'package:private_nurse_for_client/models/paginator_model.dart';

class ListNotificationResponseModel extends BaseAPIResponse<List<NotificationModel>, Null> {
  ListNotificationResponseModel(fullJson) : super(fullJson);

  @override
  dataToJson(List<NotificationModel>? data) {
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
  List<NotificationModel>? jsonToData(Map<String, dynamic>? json) {
    if (json != null) {
      data = [];

      json["data"].forEach((v) {
        data!.add(NotificationModel.fromJson(v));
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
