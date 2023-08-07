import 'dart:convert';

import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/job/job_store_response_model.dart';
import 'package:private_nurse_for_client/models/job/list_job_response_model.dart';
import 'package:private_nurse_for_client/models/job_filter_request/job_filter_request_model.dart';
import 'package:private_nurse_for_client/models/list_feedback_for_specific_nurse/review_nurse_request_model.dart';
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

  static Resource applyJob(int jobId) {
    return Resource(
        url: 'client/jobs/$jobId/apply-jobs',
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }
  static Resource ongoingJob(int jobId) {
    return Resource(
        url: 'client/jobs/$jobId/ongoing-jobs',
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }
  static Resource completeJob(int jobId) {
    return Resource(
        url: 'client/jobs/$jobId/cancel-jobs',
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }
  static Resource cancelJob(int jobId) {
    return Resource(
        url: 'client/jobs/$jobId/complete-jobs',
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }
  static Resource generateBillPayment() {
    return Resource(
        url: 'client/generate-bill/uniform-fee',
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }
    static Resource storeReview(ReviewNurseRequestModel reviewNurseRequestModel) {
    return Resource(
        url: 'client/jobs/1/review',
        data: reviewNurseRequestModel.toJson(),
        parse: (response) {
          return JobStoreResponseModel(json.decode(response.body));
        });
  }
}
