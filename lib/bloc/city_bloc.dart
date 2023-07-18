
import 'package:private_nurse_for_client/models/city/city_response_model.dart';
import 'package:private_nurse_for_client/models/division/division_model.dart';
import 'package:private_nurse_for_client/resource/city_resource.dart';
import 'package:private_nurse_for_client/services/web_services.dart';

class CityBloc {
  Future<CityResponseModel> getCityList({DivisionModel? divisionModel}) async {
    return await WebService.get(
      CityResource.getCityResource(divisionModel!),
    );
  }
}
