

import 'package:private_nurse_for_client/models/feedback/feedback_filter_request_model.dart';
import 'package:private_nurse_for_client/models/feedback/list_feedback_response_model.dart';
import 'package:private_nurse_for_client/models/list_feedback_for_specific_nurse/list_feedback_response_model.dart';
import 'package:private_nurse_for_client/resource/feedback_resource.dart';
import 'package:private_nurse_for_client/services/web_services.dart';

class FeedbackBloc {
  Future<ListFeedbackResponseModel> getFeedbackList(
      FeedbackFilterRequestModel requestModel ) async {
    return await WebService.get(FeedbackResource.getListFeedback(requestModel));
  }
}
