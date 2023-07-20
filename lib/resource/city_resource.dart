import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:private_nurse_for_client/models/city/city_model.dart';
import 'package:private_nurse_for_client/models/city/city_response_model.dart';
import 'package:private_nurse_for_client/models/division/division_model.dart';

import 'package:private_nurse_for_client/services/resource.dart';

class CityResource {
  static Resource getCityResource(DivisionModel divisionModel) {
    return Resource(
      url: 'cities/${divisionModel!.id!}',
      parse: (response) {
        try {
          return CityResponseModel(json.decode(response.body));
        } catch (error) {
          return error;
        }
      },
    );
  }

  static setGetIt(List<CityModel> listCityModel) {
    if (!GetIt.instance.isRegistered<List<CityModel>>()) {
      GetIt.instance.registerSingleton<List<CityModel>>(listCityModel);
    } else {
      GetIt.instance.unregister<List<CityModel>>();
      GetIt.instance.registerSingleton<List<CityModel>>(listCityModel);
    }
  }

   static registerGetIt(List<CityModel> list) {
    GetIt.I.registerSingleton<List<CityModel>>(list);
  }
}
