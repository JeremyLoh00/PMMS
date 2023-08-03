import 'package:private_nurse_for_client/models/feedback/feedback_model.dart';
import 'package:private_nurse_for_client/models/job/job_store_response_model.dart';
import 'package:private_nurse_for_client/resource/feedback_resource.dart';
import 'package:private_nurse_for_client/services/web_services.dart';

class FeedbackBloc {

  Future<JobStoreResponseModel> storeFeedback(FeedbackModel feedModel) async {
    return await WebService.post(FeedbackResource.storeReview(feedModel));
  }

}
