import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/job/job_store_response_model.dart';
import 'package:private_nurse_for_client/models/job/list_job_response_model.dart';
import 'package:private_nurse_for_client/models/job_filter_request/job_filter_request_model.dart';
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

  Future<DefaultResponseModel> applyJob(int jobId) async {
    return await WebService.post(JobResource.applyJob(jobId));
  }
Future<DefaultResponseModel> ongoingJob(int jobId) async {
    return await WebService.post(JobResource.ongoingJob(jobId));
  }
  Future<DefaultResponseModel> completeJob(int jobId) async {
    return await WebService.post(JobResource.completeJob(jobId));
  }
Future<DefaultResponseModel> cancelJob(int jobId) async {
    return await WebService.post(JobResource.cancelJob(jobId));
  }
  Future<DefaultResponseModel> generateBillPayment() async {
    return await WebService.post(JobResource.generateBillPayment());
  }
}
