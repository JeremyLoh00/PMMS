import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
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
  HttpOverrides.global = MyHttpOverrides();
  Stripe.publishableKey =
      'pk_test_51NVTKRFfsjmBEM78bAzoEV8SdPbmNhLLqkjPjyRnGWgdNXdM9BCBaEnuufHITCR1osydRhfA0EPheV7qvNg6FA3S00XiJBLSZE';
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
    data.add(DivisionModel(id: -1, name: "All State"));
    divisionJson.forEach((v) {
      data.add(DivisionModel.fromJson(v));
    });
    DivisionResource.setGetIt(data);
  } else {
    //Call API
    DivisionBloc divisionBloc = DivisionBloc();
    final DivisionResponseModel response = await divisionBloc.getDivisionList();
    print(response.toJson());

    if (response.isSuccess) {
      await SecureStorageApi.saveObject('list_division', response.data);
      DivisionResource.setGetIt(response.data!);
    }
  }
  CityResource.setGetIt([CityModel(id: -1, name: "All Cities")]);

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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
