import 'package:private_nurse_for_client/models/notification/list_notification_request_model.dart';
import 'package:private_nurse_for_client/models/notification/list_notification_response_model.dart';
import 'package:private_nurse_for_client/resource/notification_resource.dart';
import 'package:private_nurse_for_client/services/web_services.dart';

class NotificationBloc {
  Future<ListNotificationResponseModel> getNotificationList(ListNotificationRequestModel requestModel) async {
    return await WebService.get(NotificationResource.getListNotification(requestModel));
  }
}
