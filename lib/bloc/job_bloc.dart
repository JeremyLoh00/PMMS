import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/feedback/feedback_response_model.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/job/job_response_model.dart';
import 'package:private_nurse_for_client/models/job/job_store_response_model.dart';
import 'package:private_nurse_for_client/models/job/list_job_response_model.dart';
import 'package:private_nurse_for_client/models/job_filter_request/job_filter_request_model.dart';
import 'package:private_nurse_for_client/models/review_model/review_nurse_request_model.dart';
import 'package:private_nurse_for_client/models/reject_reason/list_reject_reason_response_model.dart';
import 'package:private_nurse_for_client/resource/job_resource.dart';
import 'package:private_nurse_for_client/services/web_services.dart';

class JobsBloc {
  Future<ListJobResponseModel> getListJobs(
      JobFilterRequestModel jobsFilterRequestModel) async {
    return await WebService.get(
        JobResource.getListJobs(jobsFilterRequestModel));
  }

  // Store Item and tab
  Future<JobStoreResponseModel> storeJob(JobModel jobModel) async {
    return await WebService.post(JobResource.storeJob(jobModel));
  }

  Future<DefaultResponseModel> acceptJob(int jobId) async {
    return await WebService.put(JobResource.acceptJob(jobId));
  }

  Future<JobResponseModel> rejectJob(
      int jobId, List<String> rejectedReasons) async {
    return await WebService.put(JobResource.rejectJob(jobId, rejectedReasons));
  }

  Future<DefaultResponseModel> completeJob(int jobId) async {
    return await WebService.post(JobResource.completeJob(jobId));
  }

  Future<DefaultResponseModel> cancelJob(int jobId) async {
    return await WebService.put(JobResource.cancelJob(jobId));
  }

  Future<DefaultResponseModel> generateBillPayment(int jobId) async {
    return await WebService.post(JobResource.generateBillPayment(jobId));
  }

  Future<FeedbackResponseModel> storeReview(
      int jobId, ReviewNurseRequestModel reviewNurseRequestModel) async {
    return await WebService.postUpdateReview(
        JobResource.storeReview(jobId, reviewNurseRequestModel),
        reviewNurseRequestModel);
  }

  Future<ListRejectReasonResponseModel> getListRejectReason() async {
    return await WebService.get(JobResource.getListRejectReason());
  }

  Future<JobResponseModel> showJob(String jobId) async {
    return await WebService.get(JobResource.showJob(jobId));
  }
}
