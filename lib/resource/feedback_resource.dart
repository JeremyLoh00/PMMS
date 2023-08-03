import 'dart:convert';
import 'package:private_nurse_for_client/models/feedback/feedback_model.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/job/job_store_response_model.dart';
import 'package:private_nurse_for_client/services/resource.dart';

class FeedbackResource {

  static Resource storeReview(FeedbackModel feedbackModel) {
    return Resource(
        url: 'client/jobs/1/review',
        data: feedbackModel.toJson(),
        parse: (response) {
          return JobStoreResponseModel(json.decode(response.body));
        });
  }

}
