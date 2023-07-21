import 'package:private_nurse_for_client/models/nurse/list_nurse_response_model.dart';
import 'package:private_nurse_for_client/models/nurse/nurse_filter_request_model.dart';
import 'package:private_nurse_for_client/resource/nurse_resource.dart';
import 'package:private_nurse_for_client/services/web_services.dart';

class NurseBloc {
  Future<ListNurseResponseModel> getListNurseHistory(
      NurseFilterRequestModel nurseHistoryFilterRequestModel) async {
    return await WebService.get(
        NurseResource.getListNurseHistory(nurseHistoryFilterRequestModel));
  }
    Future<ListNurseResponseModel> getLisNurseBlocked(
      NurseFilterRequestModel nurseHistoryFilterRequestModel) async {
    return await WebService.get(
        NurseResource.getListNurseBlocked(nurseHistoryFilterRequestModel));
  }
}
