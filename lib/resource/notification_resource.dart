import 'dart:convert';

import 'package:private_nurse_for_client/models/notification/list_notification_request_model.dart';
import 'package:private_nurse_for_client/models/notification/list_notification_response_model.dart';
import 'package:private_nurse_for_client/services/resource.dart';

 

class NotificationResource {
  static Resource getListNotification(
      ListNotificationRequestModel requestModel) {
    return Resource(
        url: 'notification',
        params: {
          'page': ((requestModel.page! / requestModel.take!) + 1)
              .toInt()
              .toString(),
          'take': requestModel.take.toString(),
        },
        parse: (response) {
          return ListNotificationResponseModel(json.decode(response.body));
        });
  }
}
