import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/list_feedback_for_specific_nurse/list_feedback_response_model.dart';
import 'package:private_nurse_for_client/models/user/list_user_response_model.dart';
import 'package:private_nurse_for_client/models/nurse/nurse_filter_request_model.dart';
import 'package:private_nurse_for_client/resource/nurse_resource.dart';
import 'package:private_nurse_for_client/services/web_services.dart';

class NurseBloc {
  Future<ListUserResponseModel> getListNurseHistory(
      NurseFilterRequestModel nurseHistoryFilterRequestModel) async {
    return await WebService.get(
        NurseResource.getListNurseHistory(nurseHistoryFilterRequestModel));
  }

  Future<ListUserResponseModel> getListNurseBlocked(
      NurseFilterRequestModel nurseHistoryFilterRequestModel) async {
    return await WebService.get(
        NurseResource.getListNurseBlocked(nurseHistoryFilterRequestModel));
  }
    
    Future<ListFeedbackResponseModel> getListFeedbackForSpecificNurse(
      NurseFilterRequestModel nurseHistoryFilterRequestModel) async {
    return await WebService.get(
        NurseResource.getListFeedbackForSpecificNurse(nurseHistoryFilterRequestModel));
  }
  //Bloc or unblock nurse
  Future<DefaultResponseModel> blockNurse(int nurseId) async {
    return await WebService.put(NurseResource.blockNurse(nurseId));
  }
  
}
