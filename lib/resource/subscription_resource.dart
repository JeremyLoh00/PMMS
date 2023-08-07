import 'dart:convert';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/job/job_store_response_model.dart';
import 'package:private_nurse_for_client/models/job/list_job_response_model.dart';
import 'package:private_nurse_for_client/models/subscription/list_subscription_response_model.dart';
import 'package:private_nurse_for_client/models/subscription/subscription_filter_request_model.dart';
import 'package:private_nurse_for_client/models/subscription/subscription_model.dart';
import 'package:private_nurse_for_client/models/subscription/subscription_store_response_model.dart';
import 'package:private_nurse_for_client/services/resource.dart';

class SubscriptionResource {
  static Resource getListSubscription(SubscriptionFilterRequestModel subscriptionFilterRequestModel) {
    return Resource(
        url: 'client/subscription-packages',
        params: {
          'take': subscriptionFilterRequestModel.take.toString(),
        },
        parse: (response) {
          return ListSubscriptionResponseModel(json.decode(response.body));
        });
  }

  static Resource storeSubscription(SubscriptionModel subscriptionModel) {
    return Resource(
        url: 'client/generate-bill/subscription-fee/1',
        data: subscriptionModel.toJson(),
        parse: (response) {
          return SubscriptionStoreResponseModel(json.decode(response.body));
        });
  }
}
