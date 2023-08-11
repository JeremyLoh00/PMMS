import 'dart:convert';

import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/feedback/feedback_response_model.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/job/job_response_model.dart';
import 'package:private_nurse_for_client/models/job/job_store_response_model.dart';
import 'package:private_nurse_for_client/models/job/list_job_response_model.dart';
import 'package:private_nurse_for_client/models/job_filter_request/job_filter_request_model.dart';
import 'package:private_nurse_for_client/models/review_model/review_nurse_request_model.dart';
import 'package:private_nurse_for_client/models/reject_reason/list_reject_reason_response_model.dart';
import 'package:private_nurse_for_client/services/resource.dart';

class JobResource {
  static Resource getListJobs(JobFilterRequestModel jobFilterRequestModel) {
    return Resource(
        url: 'client/jobs',
        params: {
          // Calculate number page based on offset and take
          'page':
              ((jobFilterRequestModel.page! / jobFilterRequestModel.take!) + 1)
                  .toInt()
                  .toString(),
          'take': jobFilterRequestModel.take.toString(),

          'tab': jobFilterRequestModel.tab.toString(),
        },
        parse: (response) {
          return ListJobResponseModel(json.decode(response.body));
        });
  }

  static Resource storeJob(JobModel jobModel) {
    return Resource(
        url: 'client/jobs',
        data: jobModel.toJson(),
        parse: (response) {
          return JobStoreResponseModel(json.decode(response.body));
        });
  }

  static Resource acceptJob(int jobId) {
    return Resource(
        url: 'client/jobs/$jobId/accept',
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }

  static Resource rejectJob(int jobId, List<String> rejectedReasons) {
    return Resource(
        url: 'client/jobs/$jobId/reject',
        data: {"rejected_reason": rejectedReasons},
        parse: (response) {
          return JobResponseModel(json.decode(response.body));
        });
  }

  static Resource completeJob(int jobId) {
    return Resource(
        url: 'client/jobs/$jobId/complete-jobs',
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }

  static Resource cancelJob(int jobId) {
    return Resource(
        url: 'client/jobs/$jobId/canceled',
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }

  static Resource generateBillPayment(int jobId) {
    return Resource(
        url: 'client/generate-bill/nursing-fee/$jobId',
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }

  static Resource storeReview(
      int jobId, ReviewNurseRequestModel reviewNurseRequestModel) {
    return Resource(
        url: 'client/jobs/$jobId/review',
        data: reviewNurseRequestModel.toJson(),
        parse: (response) {
          return FeedbackResponseModel(json.decode(response.body));
        });
  }
   static Resource getListRejectReason() {
    return Resource(
        url: 'reject-reason',
        parse: (response) {
          return ListRejectReasonResponseModel(json.decode(response.body));
        });
  }
}
