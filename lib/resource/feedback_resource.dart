import 'dart:convert';
import 'package:private_nurse_for_client/models/feedback/feedback_filter_request_model.dart';
import 'package:private_nurse_for_client/models/feedback/feedback_model.dart';
import 'package:private_nurse_for_client/models/feedback/list_feedback_response_model.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/job/job_store_response_model.dart';
import 'package:private_nurse_for_client/services/resource.dart';

class FeedbackResource {
      static Resource getListFeedback(int nurseId,
      FeedbackFilterRequestModel requestModel ) {
    return Resource(
        url: 'client/nurse-history/feedback/$nurseId',
        params: {
          'page': ((requestModel.page! / requestModel.take!) + 1)
              .toInt()
              .toString(),
          'take': requestModel.take.toString(),
        },
        parse: (response) {
          return ListFeedbackResponseModel(json.decode(response.body));
        });
  }

  static Resource storeReview(FeedbackModel feedbackModel) {
    return Resource(
        url: 'client/jobs/1/review',
        data: feedbackModel.toJson(),
        parse: (response) {
          return JobStoreResponseModel(json.decode(response.body));
        });
  }

}
