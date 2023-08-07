import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/job/job_store_response_model.dart';
import 'package:private_nurse_for_client/models/job/list_job_response_model.dart';
import 'package:private_nurse_for_client/models/job_filter_request/job_filter_request_model.dart';
import 'package:private_nurse_for_client/models/list_feedback_for_specific_nurse/review_nurse_request_model.dart';
import 'package:private_nurse_for_client/models/subscription/list_subscription_response_model.dart';
import 'package:private_nurse_for_client/models/subscription/subscription_filter_request_model.dart';
import 'package:private_nurse_for_client/models/subscription/subscription_model.dart';
import 'package:private_nurse_for_client/models/subscription/subscription_store_response_model.dart';
import 'package:private_nurse_for_client/resource/job_resource.dart';
import 'package:private_nurse_for_client/resource/subscription_resource.dart';
import 'package:private_nurse_for_client/services/web_services.dart';

class SubscriptionBloc {
  Future<ListSubscriptionResponseModel> getListSubcription(
      SubscriptionFilterRequestModel subscriptionFilterRequestModel) async {
    return await WebService.get(
        SubscriptionResource.getListSubscription(subscriptionFilterRequestModel));
  }

  // Store Item and tab
  Future<SubscriptionStoreResponseModel> storeSubscription(SubscriptionModel subscriptionModel) async {
    return await WebService.post(SubscriptionResource.storeSubscription(subscriptionModel));
  }

}
