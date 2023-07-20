import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/bloc/city_bloc.dart';
import 'package:private_nurse_for_client/bloc/division_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/login_form_bloc.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/helpers/http_response.dart';
import 'package:private_nurse_for_client/helpers/secure_storage_api.dart';
import 'package:private_nurse_for_client/helpers/user_data_notifier.dart';
import 'package:private_nurse_for_client/models/city/city_model.dart';
import 'package:private_nurse_for_client/models/city/city_response_model.dart';
import 'package:private_nurse_for_client/models/division/division_model.dart';
import 'package:private_nurse_for_client/models/division/division_response_model.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/models/user/user_response_model.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/input_decoration%20copy.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/resource/city_resource.dart';
import 'package:private_nurse_for_client/resource/division_resource.dart';
import 'package:private_nurse_for_client/screens/forgot_password/forgot_password_screen.dart';
import 'package:private_nurse_for_client/screens/navigation/navigation.dart';
import 'package:private_nurse_for_client/screens/sign_up/sign_up_screen.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/sign-in-screen';
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  DivisionModel divisionModel = DivisionModel();

  Future<void> fetchDivisionAndModel() async {
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
        print(response.data);
        await SecureStorageApi.saveObject('list_division', response.data);
        DivisionResource.setGetIt(response.data!);
      }
    }

    // handle list of city data
    List<dynamic>? listDivision =
        await SecureStorageApi.readObject("list_division");

    divisionModel.id = listDivision?[0]["id"] ?? 0;
    divisionModel.name = listDivision?[0]["name"] ?? "N/A";

    List<dynamic>? cityJson = await SecureStorageApi.readObject("list_city");

    if (cityJson != null) {
      List<CityModel> data = [];
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo.png'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Why Pay Agent Fee? Get Your Nurse in 5 Minutes!",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: loginForm(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  loginForm(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginFormBloc(),
      child: Builder(
        builder: (context) {
          final LoginFormBloc formBloc =
              BlocProvider.of<LoginFormBloc>(context);

          return FormBlocListener<LoginFormBloc, UserModel, UserResponseModel>(
            // On submit
            onSubmitting: (context, state) {
              // Remove focus from input field
              FocusScope.of(context).unfocus();
              // Set loading true
              setState(() {
                _isLoading = true;
              });
            },
            onSuccess: (context, state) {
              // Set loading false
              setState(() {
                _isLoading = false;
              });

              // Declare notifier
              final UserDataNotifier userDataNotifier =
                  Provider.of<UserDataNotifier>(context, listen: false);
              // Set to the notifier
              userDataNotifier.setUserData(state.successResponse!);
              // Navigate to home page screen
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Navigation()),
                  (Route<dynamic> route) => false);
            },
            // Validation failed
            onSubmissionFailed: (context, state) {
              // Set loading false
              setState(() {
                _isLoading = false;
              });
            },
            onFailure: (context, state) {
              // Set loading to false
              setState(() {
                _isLoading = false;
              });
              // If failed not null
              if (state.failureResponse != null) {
                if (state.failureResponse!.statusCode !=
                    HttpResponse.HTTP_UNAUTHORIZED) {
                  //Set data
                  UserModel userModel = new UserModel();
                  userModel.email = formBloc.email.value;
                  // Hide current snackbar
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();

                  // Email is not verified yet
                  if (state.failureResponse!.statusCode ==
                      HttpResponse.HTTP_FORBIDDEN) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            state.failureResponse?.message ?? "Server error"),
                        behavior: SnackBarBehavior.floating,
                        action: SnackBarAction(
                          label: "Verify Now",
                          textColor: kPrimary100Color,
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            navigateTo(
                                context,
                                SignUpScreen(
                                  activeStepper: 4,
                                  userModel: userModel,
                                ));
                          },
                        ),
                      ),
                    );

                    return;
                  }
                }
              }

              ThemeSnackBar.showSnackBar(
                  context, state.failureResponse?.message ?? "Server Errors");
              return;
            },
            child: Column(
              children: [
                TextFieldBlocBuilder(
                  textFieldBloc: formBloc.email,
                  cursorColor: kPrimaryColor,
                  textCapitalization: TextCapitalization.none,
                  inputFormatters: [
                    LowerCaseTextFormatter(),
                  ],
                  decoration: textFieldInputDecoration(
                    "Email",
                    hintText: "ex: example@aufmbz.com",
                    prefixIcon: const Icon(
                      Iconsax.sms,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //Password
                TextFieldBlocBuilder(
                  textFieldBloc: formBloc.password,
                  suffixButton: SuffixButton.obscureText,
                  cursorColor: kPrimaryColor,
                  obscureTextTrueIcon: const Icon(
                    Iconsax.eye_slash,
                    color: kPrimary100Color,
                  ),
                  obscureTextFalseIcon: const Icon(
                    Iconsax.eye,
                    color: kPrimaryColor,
                  ),
                  textCapitalization: TextCapitalization.none,
                  inputFormatters: [
                    LowerCaseTextFormatter(),
                  ],
                  decoration: textFieldInputDecoration(
                    "Password",
                    hintText: "Enter your password",
                    prefixIcon: const Icon(
                      Iconsax.unlock,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ScaleTap(
                  onPressed: () {
                    navigateTo(context, const ForgotPasswordScreen());
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password?",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                //Button Login
                // ButtonPrimary(
                //   "Login",
                //   onPressed: formBloc.submit,
                //   isLoading: _isLoading,
                //   loadingText: "Signing you in...",
                // ),

                ButtonPrimary(
                  "Login",
                  onPressed: formBloc.submit,
                  isLoading: _isLoading,
                  loadingText: "Signing you in...",
                ),

                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    // Navigator.push(context, route)
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      const SizedBox(width: 0),
                      GestureDetector(
                          onTap: () {
                            navigateTo(context, SignUpScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 20, top: 20, bottom: 20),
                            child: RichText(
                              text: const TextSpan(
                                text: "Sign Up",
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
