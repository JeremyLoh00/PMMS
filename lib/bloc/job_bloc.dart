import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/job/job_store_response_model.dart';
import 'package:private_nurse_for_client/resource/job_resource.dart';
import 'package:private_nurse_for_client/services/web_services.dart';

class JobBloc {
  // Store Item and tab
  Future<JobStoreResponseModel> storeJob(JobModel jobModel) async {
    return await WebService.post(JobResource.storeJob(jobModel));
  }
}