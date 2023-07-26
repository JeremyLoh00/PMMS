import 'package:private_nurse_for_client/models/job/schedule_list_response_model.dart';
import 'package:private_nurse_for_client/models/service/service_filter_model.dart';
import 'package:private_nurse_for_client/models/service/service_list_response_model.dart';
import 'package:private_nurse_for_client/resource/service_resource.dart';
import 'package:private_nurse_for_client/services/web_services.dart';

class ServiceBloc {
   // Get list of Service
  Future<ServiceListResponseModel> getListService(
      {ServiceFilterModel? categoryFilterModel}) async {
    return await WebService.get(ServiceResource.getServiceList(
        categoryFilterModel ?? ServiceFilterModel()));
  }

  // Get list of schedule
  Future<ScheduleListResponseModel> getListSchedule(
      {ServiceFilterModel? categoryFilterModel}) async {
    return await WebService.get(ServiceResource.getServiceList(
        categoryFilterModel ?? ServiceFilterModel()));
  }
}