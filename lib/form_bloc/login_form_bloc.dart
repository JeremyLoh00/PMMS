import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:private_nurse_for_client/bloc/city_bloc.dart';
import 'package:private_nurse_for_client/bloc/division_bloc.dart';
import 'package:private_nurse_for_client/bloc/user_bloc.dart';
import 'package:private_nurse_for_client/helpers/secure_storage_api.dart';
import 'package:private_nurse_for_client/models/city/city_model.dart';
import 'package:private_nurse_for_client/models/city/city_response_model.dart';
import 'package:private_nurse_for_client/models/division/division_model.dart';
import 'package:private_nurse_for_client/models/division/division_response_model.dart';
import 'package:private_nurse_for_client/models/login/login_request_model.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/models/user/user_response_model.dart';
import 'package:private_nurse_for_client/resource/city_resource.dart';
import 'package:private_nurse_for_client/resource/division_resource.dart';

class LoginFormBloc extends FormBloc<UserModel, UserResponseModel> {
  // Initialize Bloc
  final UserBloc userBloc = UserBloc();
  DivisionModel divisionModel = DivisionModel();

  // For email field
  final email = TextFieldBloc(
    initialValue: "client@gmail.com",
    validators: [
      FieldBlocValidators.required,
    ],
  );

  // For password field
  final password = TextFieldBloc(
    initialValue: "password",
    validators: [
      FieldBlocValidators.required,
    ],
  );

  // Constructor, to add the field variable to the form
  LoginFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        email,
        password,
      ],
    );
  }

  // Handle what happen on submit
  @override
  void onSubmitting() async {
    try {
      // Call API to Login
      UserResponseModel responseModel = await userBloc.login(
          LoginRequestModel(email: email.value, password: password.value));

      // print(await userBloc.login(
      //     LoginRequestModel(email: email.value, password: password.value)));
      // print(responseModel.toJson());
      // Handle API response
      if (responseModel.isSuccess && responseModel.data!.accessToken != null) {
        print("response model success");
        print(responseModel.data.toString());

        // handle list of division data
        List<dynamic>? divisionJson =
            await SecureStorageApi.readObject("list_division");

        if (divisionJson != null) {
          List<DivisionModel>? data = [];
          divisionJson.forEach((v) {
            data.add(DivisionModel.fromJson(v));
          });
          DivisionResource.setGetIt(data);
        } else {
          //Call API
          DivisionBloc divisionBloc = DivisionBloc();
          final DivisionResponseModel response =
              await divisionBloc.getDivisionList();
          print(response.toJson());

          if (response.isSuccess) {
            await SecureStorageApi.saveObject('list_division', response.data);
            DivisionResource.setGetIt(response.data!);
          }
        }

        // handle list of city data
        List<dynamic>? listDivision =
            await SecureStorageApi.readObject("list_division");
        print(listDivision![0]["id"]);
        divisionModel.id = listDivision[0]["id"];
        divisionModel.name = listDivision[0]["name"];

        List<dynamic>? cityJson =
            await SecureStorageApi.readObject("list_city");

        if (cityJson != null) {
          List<CityModel>? data = [];
          cityJson.forEach((v) {
            data.add(CityModel.fromJson(v));
          });
          CityResource.setGetIt(data);
        } else {
          //Call API
          CityBloc cityBloc = CityBloc();
          final CityResponseModel response =
              await cityBloc.getCityList(divisionModel: divisionModel);

          if (response.isSuccess) {
            await SecureStorageApi.saveObject('list_city', response.data);
            CityResource.setGetIt(response.data!);
          }
        }

        emitSuccess(successResponse: responseModel.data!);
      } else {
        // Trigger fail event
        emitFailure(failureResponse: responseModel);
        print(responseModel.message);
        //print(responseModel.data);
      }
    } catch (e) {
      // Trigger fail event
      print(e);
      emitFailure();
    }
  }
}
