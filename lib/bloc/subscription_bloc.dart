import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/subscription/subscription_response_model.dart';
import 'package:private_nurse_for_client/models/subscription/subscription_model.dart';
import 'package:private_nurse_for_client/models/subscription/subscription_store_response_model.dart';
import 'package:private_nurse_for_client/resource/subscription_resource.dart';
import 'package:private_nurse_for_client/services/web_services.dart';

class SubscriptionBloc {
  Future<SubscriptionResponseModel> getListSubcription() async {
    return await WebService.get(
        SubscriptionResource.getListSubscription());
  }

 Future<DefaultResponseModel> generateSubscriptionBillPayment(int jobId) async {
    return await WebService.post(SubscriptionResource.generateSubscriptionBillPayment(jobId));
  }

}
