import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:private_nurse_for_client/models/division/division_model.dart';
import 'package:private_nurse_for_client/models/division/division_response_model.dart';
import 'package:private_nurse_for_client/services/resource.dart';

class DivisionResource {
  static Resource getDivisionList() {
    return Resource(
      url: 'divisions',
      parse: (response) {
        try {
          return DivisionResponseModel(json.decode(response.body));
        } catch (error) {
          return error;
        }
      },
    );
  }

  static setGetIt(List<DivisionModel> listDivisionModel) {
    if (!GetIt.instance.isRegistered<List<DivisionModel>>()) {
      GetIt.instance.registerSingleton<List<DivisionModel>>(listDivisionModel);
    } else {
      GetIt.instance.unregister<List<DivisionModel>>();
      GetIt.instance.registerSingleton<List<DivisionModel>>(listDivisionModel);
    }
  }



  static registerGetIt(List<DivisionModel> list) {
    GetIt.I.registerSingleton<List<DivisionModel>>(list);
  }
}
