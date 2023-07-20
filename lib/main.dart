import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:private_nurse_for_client/app.dart';
import 'package:private_nurse_for_client/bloc/city_bloc.dart';
import 'package:private_nurse_for_client/bloc/division_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/secure_storage_api.dart';
import 'package:private_nurse_for_client/models/city/city_model.dart';
import 'package:private_nurse_for_client/models/city/city_response_model.dart';
import 'package:private_nurse_for_client/models/division/division_model.dart';
import 'package:private_nurse_for_client/models/division/division_response_model.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/resource/city_resource.dart';
import 'package:private_nurse_for_client/resource/division_resource.dart';
import 'package:private_nurse_for_client/resource/user_resource.dart';
import 'package:private_nurse_for_client/screens/navigation/navigation.dart';

import 'screens/sign_in/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.instance.registerSingleton<UserModel>(UserModel());

  UserModel user = UserModel();
  DivisionModel divisionModel = DivisionModel();

  Map<String, dynamic>? userJson = await SecureStorageApi.readObject("user");

  if (userJson != null) {
    user = UserModel.fromJson(userJson);
  }

  // handle list of division data
  List<dynamic>? divisionJson =
      await SecureStorageApi.readObject("list_division");

  if (divisionJson != null) {
    List<DivisionModel>? data = [];
    divisionJson.forEach((v) {
      data.add(DivisionModel.fromJson(v));
    });
    DivisionResource.registerGetIt(data);
  } else {
    //Call API
    DivisionBloc divisionBloc = DivisionBloc();
    final DivisionResponseModel response = await divisionBloc.getDivisionList();
    print("sdsdivision${response.toJson()}");

    if (response.isSuccess) {
      await SecureStorageApi.saveObject('list_division', response.data);
      DivisionResource.registerGetIt(response.data!);
    }
  }

  // handle list of city data
  List<dynamic>? listDivision =
      await SecureStorageApi.readObject("list_division");

  divisionModel.id = listDivision?[0]["id"] ?? 0;
  divisionModel.name = listDivision?[0]["name"] ?? "N/A";

  List<dynamic>? cityJson = await SecureStorageApi.readObject("list_city");

  if (cityJson != null) {
    List<CityModel>? data = [];
    cityJson.forEach((v) {
      data.add(CityModel.fromJson(v));
    });
    CityResource.registerGetIt(data);
  } else {
    //Call API
    CityBloc cityBloc = CityBloc();
    final CityResponseModel response =
        await cityBloc.getCityList(divisionModel: divisionModel);
    print("sds${response.toJson()}");
    if (response.isSuccess) {
      print(response.isSuccess);
      await SecureStorageApi.saveObject('list_city', response.data);
      CityResource.registerGetIt(response.data!);
    }
  }

  //save in GetIt
  UserResource.setGetIt(user);

  bool isAuthenticated = false;
  String token = await SecureStorageApi.read(key: "access_token");
  // If access token != ""
  if (token != "") {
    // Already login
    isAuthenticated = true;
  }

  Future<Widget> checkAuth() async {
    // Initial route
    Widget routeName = SignInScreen();
    if (!isAuthenticated) {
      // Not login yet
      routeName = SignInScreen();
    } else {
      // Already login
      routeName = Navigation();
    }
    return routeName;
  }

  Widget initialRoute = await checkAuth();

  runApp(MyApp(
    initialRoute: initialRoute,
  ));
}
