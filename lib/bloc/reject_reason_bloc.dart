import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/job/job_store_response_model.dart';
import 'package:private_nurse_for_client/models/job/list_job_response_model.dart';
import 'package:private_nurse_for_client/models/job_filter_request/job_filter_request_model.dart';
import 'package:private_nurse_for_client/models/review_model/review_nurse_request_model.dart';
import 'package:private_nurse_for_client/models/reject_reason/reject_reason_list_response_model.dart';
import 'package:private_nurse_for_client/resource/job_resource.dart';
import 'package:private_nurse_for_client/resource/reject_reason_resource.dart';
import 'package:private_nurse_for_client/services/web_services.dart';

class RejectReasonBloc {
  Future<RejectReasonListResponseModel> getListRejectReason() async {
    return await WebService.get(RejectReasonResource.getListRejectReason());
  }
   Future<DefaultResponseModel> rejectNurse(int rejectId) async {
    return await WebService.put(RejectReasonResource.rejectNurse(rejectId));
  }

}
