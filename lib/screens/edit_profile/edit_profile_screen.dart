import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:private_nurse_for_client/bloc/city_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/edit_profile_form_bloc.dart';
import 'package:private_nurse_for_client/helpers/user_data_notifier.dart';
import 'package:private_nurse_for_client/models/city/city_model.dart';
import 'package:private_nurse_for_client/models/city/city_response_model.dart';
import 'package:private_nurse_for_client/models/division/division_model.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/models/user/user_response_model.dart';
import 'package:private_nurse_for_client/public_components/custom_dialog.dart';
import 'package:private_nurse_for_client/public_components/styled_dropdown.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';
import 'package:private_nurse_for_client/screens/edit_profile/components/change_password_screen.dart';
import 'package:private_nurse_for_client/screens/edit_profile/components/file_uploader_edit_profile.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/input_decoration%20copy.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_app_bar.dart';
import 'package:private_nurse_for_client/theme.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel userModel;
  final Function() callBackRefresh;
  const EditProfileScreen(
      {super.key, required this.userModel, required this.callBackRefresh});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

enum SingingCharacter { male, female }

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? selectedValue;
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  SingingCharacter? _character = SingingCharacter.male;
  String src =
      "https://c4.wallpaperflare.com/wallpaper/246/739/689/digital-digital-art-artwork-illustration-abstract-hd-wallpaper-preview.jpg";
  @override
  bool _isLoading = false;
  XFile? selectedProfilePic;
  int delayAnimationDuration = 200;

  late EditProfileFormBloc _editProfileFormBloc;
  late DivisionModel selectedDivision;
  CityModel? selectedCity;
  List<CityModel>? listCities = GetIt.instance.get<List<CityModel>>();
  List<DivisionModel>? listDivision = GetIt.instance.get<List<DivisionModel>>();
  @override
  void initState() {
    super.initState();
    _editProfileFormBloc = EditProfileFormBloc(widget.userModel);
    selectedDivision = listDivision!.firstWhere(
        (division) => division.id == widget.userModel.worldDivisionId,
        orElse: () => DivisionModel());

    print("init selectedDivision s${selectedDivision.id}s");
    //   print("init selected city s${selectedCity!.id}s");
    print("divisionValue s${_editProfileFormBloc.division.value}s");
// check if the division null or not
    if (_editProfileFormBloc.division.value == "") {
      _editProfileFormBloc.division
          .updateValue(widget.userModel.worldDivisionId.toString());
    } else {
      print("obj2");
    }

    print("divisionValue ${_editProfileFormBloc.division.value}");
    print("Updated divisionValue ${widget.userModel.worldDivisionId}");
    // print("cityValue ${widget.formBloc.cityModel.value}");
    print(selectedProfilePic);

    if (listDivision!.isNotEmpty) {
      selectedDivision.id = widget.userModel.worldDivisionId;
    }
    print("selected division id ${selectedDivision.id}");
    // if (listCities![0].id != -1) {
    //   listCities!.insert(0, CityModel(id: -1, name: "Select Cities"));
    // }

    // if (selectedCity == null) {
    //   selectedCity?.id = widget.userModel.worldCityId;
    // }
    selectedCity?.id = widget.userModel.worldCityId;
    print("CityValue ${_editProfileFormBloc.cityModel.value}");
    if (_editProfileFormBloc.cityModel.value == "") {
      _editProfileFormBloc.cityModel
          .updateValue(widget.userModel.worldCityId.toString());
    } else {
      print("obj2");
    }

    print("CityValue ${_editProfileFormBloc.cityModel.value}");
    print("Updated CityValue ${widget.userModel.worldCityId}");
  }

  Future onChangeDivision() async {
    CustomDialog.show(context,
        isDissmissable: false,
        title: "Fetching cities from ${selectedDivision.name}",
        center: ThemeSpinner.spinner());
    final CityBloc cityBloc = CityBloc();
    CityResponseModel responseModel =
        await cityBloc.getCityList(divisionModel: selectedDivision);
    if (responseModel.isSuccess) {
      List<CityModel> fetchedCities = responseModel.data ?? [];
      setState(() {
        listCities = fetchedCities;
        listCities!.insert(0, CityModel(id: -1, name: "Select Cities"));
        selectedCity = listCities![0];
      });
      if (mounted) {
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        ThemeSnackBar.showSnackBar(context, responseModel.message);
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: ThemeAppBar(
        "Edit Profile",
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocProvider(
            create: (context) => EditProfileFormBloc(widget.userModel),
            child: Builder(builder: (context) {
              final EditProfileFormBloc formBloc =
                  BlocProvider.of<EditProfileFormBloc>(context);
              return FormBlocListener<EditProfileFormBloc, UserModel,
                  UserResponseModel>(
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

                  // Navigate to profile screen
                  Navigator.of(context).pop();
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
                  ThemeSnackBar.showSnackBar(context,
                      state.failureResponse?.message ?? "Server error");
                  return;
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ScaleTap(
                            onPressed: () {
                              navigateTo(
                                  context,
                                  ChangePasswordScreen(
                                    callbackRefresh: widget.callBackRefresh,
                                  ));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Change Password",
                                    style: TextStyle(
                                      color: kWhite,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      DelayedDisplay(
                        delay: Duration(milliseconds: delayAnimationDuration),
                        child: ImageUploader(
                          heroTag: 'editprofile',
                          userModel: widget.userModel,
                          formBloc: formBloc,
                          onImageSelected: (XFile selectedImage) {
                            setState(() {
                              selectedProfilePic = selectedImage;
                              formBloc.newProfilePhoto = selectedImage;
                            });
                          },
                        ),
                      ),
                      Space(20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Personal Information",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      Space(10),
                      DelayedDisplay(
                        delay: Duration(milliseconds: delayAnimationDuration),
                        child: TextFieldBlocBuilder(
                          textFieldBloc: formBloc.newName,
                          keyboardType: TextInputType.name,
                          cursorColor: kPrimaryColor,
                          decoration: textFieldInputDecoration(
                            "Name",
                            hintText: "ex: Rolex Dilly",
                            prefixIcon: Icon(
                              Iconsax.profile_circle,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      DelayedDisplay(
                        delay: Duration(milliseconds: delayAnimationDuration),
                        child: TextFieldBlocBuilder(
                          textFieldBloc: formBloc.newEmail,
                          keyboardType: TextInputType.name,
                          cursorColor: kPrimaryColor,
                          decoration: textFieldInputDecoration(
                            "Email",
                            hintText: "ex: something@nurse.com",
                            prefixIcon: const Icon(
                              Iconsax.sms,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      DelayedDisplay(
                        delay: Duration(milliseconds: delayAnimationDuration),
                        child: TextFieldBlocBuilder(
                          textFieldBloc: formBloc.newIC,
                          keyboardType: TextInputType.name,
                          cursorColor: kPrimaryColor,
                          decoration: textFieldInputDecoration(
                            "IC / Passport Number",
                            hintText: "ex:0000000000",
                            prefixIcon: const Icon(
                              Iconsax.personalcard,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      DelayedDisplay(
                        delay: Duration(milliseconds: delayAnimationDuration),
                        child: TextFieldBlocBuilder(
                          textFieldBloc: formBloc.phoneNo,
                          keyboardType: TextInputType.name,
                          cursorColor: kPrimaryColor,
                          decoration: textFieldInputDecoration(
                            "Phone Number",
                            hintText: "ex:0123456789",
                            prefixIcon: const Icon(
                              Iconsax.call,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                      Space(20),
                      Text(
                        "Gender",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Space(10),
                      RadioButtonGroupFieldBlocBuilder<String>(
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return kPrimaryColor;
                        }),
                        selectFieldBloc: formBloc.gender,
                        itemBuilder: (context, dynamic value) => FieldItem(
                          child: Text(value),
                        ),
                        decoration: const InputDecoration(
                          prefixIcon: SizedBox(),
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     Expanded(
                      //       child: ListTile(
                      //         title: const Text('Male'),
                      //         leading: Radio<SingingCharacter>(
                      //           value: SingingCharacter.male,
                      //           groupValue: _character,
                      //           onChanged: (SingingCharacter? value) {
                      //             setState(() {
                      //               _character = value;
                      //             });
                      //           },
                      //         ),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: ListTile(
                      //         title: const Text('Female'),
                      //         leading: Radio<SingingCharacter>(
                      //           value: SingingCharacter.female,
                      //           groupValue: _character,
                      //           onChanged: (SingingCharacter? value) {
                      //             setState(() {
                      //               _character = value;
                      //             });
                      //           },
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Space(20),
                      Text(
                        "Address",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Space(10),
                      DelayedDisplay(
                        delay: Duration(milliseconds: delayAnimationDuration),
                        child: TextFieldBlocBuilder(
                          textFieldBloc: formBloc.newAddress,
                          keyboardType: TextInputType.name,
                          cursorColor: kPrimaryColor,
                          decoration: textFieldInputDecoration(
                            "Address",
                            hintText: "Address",
                            prefixIcon: Icon(
                              Iconsax.home,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: ScaleTap(
                              onPressed: () {},
                              child: StyledDropdown<CityModel>(
                                items: listCities!
                                    .map<DropdownMenuItem<CityModel>>(
                                        (CityModel model) {
                                  return DropdownMenuItem<CityModel>(
                                    value: model,
                                    child: Text(
                                      model.name.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                selected: selectedCity,
                                list: listCities!,
                                setDropdownValue: (value) {
                                  setState(() {
                                    selectedCity = listCities!.firstWhere(
                                        (model) => model.id == value.id);
                                    formBloc.cityModel.updateValue(
                                        selectedCity!.id!.toString());
                                    // print(selectedDivision.id);
                                    print(selectedCity!.id);
                                  });
                                  // updateListJobs();
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          // Expanded(
                          //   flex: 3,
                          //   child: ScaleTap(
                          //     onPressed: () {},
                          //     child: DropdownButtonFormField2<String>(
                          //       decoration: textFieldInputDecoration2(),
                          //       isExpanded: true,
                          //       enableFeedback: true,
                          //       hint: Row(
                          //         children: const [
                          //           Expanded(
                          //             child: Text(
                          //               'State',
                          //               style: TextStyle(
                          //                 fontSize: 14,
                          //                 fontWeight: FontWeight.bold,
                          //                 color: Colors.black,
                          //               ),
                          //               overflow: TextOverflow.ellipsis,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       dropdownStyleData: DropdownStyleData(
                          //         maxHeight: 200,
                          //         //swidth: double.infinity,
                          //         padding: null,
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(14),
                          //           boxShadow: [
                          //             profileShadow(kGrey.withOpacity(0.3))
                          //           ],
                          //           color: kWhite,
                          //         ),
                          //         elevation: 0,
                          //         offset: const Offset(0, 0),
                          //         scrollbarTheme: ScrollbarThemeData(
                          //           radius: const Radius.circular(2),
                          //           thickness:
                          //               MaterialStateProperty.all<double>(6),
                          //           thumbVisibility:
                          //               MaterialStateProperty.all<bool>(true),
                          //         ),
                          //       ),
                          //       items: items
                          //           .map((item) => DropdownMenuItem<String>(
                          //                 value: item,
                          //                 child: Text(
                          //                   item,
                          //                   style: const TextStyle(
                          //                     fontSize: 14,
                          //                     fontWeight: FontWeight.bold,
                          //                     color: Colors.black,
                          //                   ),
                          //                   overflow: TextOverflow.ellipsis,
                          //                 ),
                          //               ))
                          //           .toList(),
                          //       value: selectedValue,
                          //       onChanged: (value) {
                          //         setState(() {
                          //           selectedValue = value as String;
                          //         });
                          //       },
                          //     ),
                          //   ),
                          // ),
                          Expanded(
                            flex: 3,
                            child: ScaleTap(
                              onPressed: () {},
                              child: StyledDropdown<DivisionModel>(
                                items: listDivision!
                                    .map<DropdownMenuItem<DivisionModel>>(
                                  (DivisionModel model) {
                                    return DropdownMenuItem<DivisionModel>(
                                      value: model, // Set the value to the ID
                                      child: Text(
                                        model.name.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                                selected: selectedDivision,
                                list: listDivision!,
                                setDropdownValue: (value) {
                                  setState(() {
                                    selectedDivision = listDivision!.firstWhere(
                                      (model) => model.id == value.id,
                                    ); // Find the model based on the ID
                                    print(selectedDivision.id);
                                    formBloc.division.updateValue(
                                        selectedDivision.id!.toString());

                                    formBloc.cityModel.updateValue("-1");

                                    onChangeDivision();
                                  });
                                  // updateListJobs();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Space(20),
                      Text(
                        "Bank Information",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Space(10),
                      DelayedDisplay(
                        delay: Duration(milliseconds: delayAnimationDuration),
                        child: TextFieldBlocBuilder(
                          textFieldBloc: formBloc.newBank,
                          keyboardType: TextInputType.name,
                          cursorColor: kPrimaryColor,
                          decoration: textFieldInputDecoration(
                            "Bank",
                            hintText: "Public Bank",
                            prefixIcon: Icon(
                              Iconsax.bank,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      DelayedDisplay(
                        delay: Duration(milliseconds: delayAnimationDuration),
                        child: TextFieldBlocBuilder(
                          textFieldBloc: formBloc.newAccount,
                          keyboardType: TextInputType.name,
                          cursorColor: kPrimaryColor,
                          decoration: textFieldInputDecoration(
                            "Account",
                            hintText: "631520200",
                            prefixIcon: Icon(
                              Iconsax.card,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                      Space(20),
                      Row(
                        children: [
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width / 2.5,
                          // ),
                          Expanded(
                            flex: 1,
                            child: ButtonPrimary(
                              "Update",
                              onPressed: formBloc.cityModel.value == "-1"
                                  ? () {
                                      ThemeSnackBar.showSnackBar(
                                          context, "Please select your City");
                                    }
                                  : () {
                                      formBloc.submit();
                                    },
                              loadingText: "Updating...",
                              isLoading: _isLoading,
                            ),
                          ),
                        ],
                      ),
                    ]),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget profileInformation(
      {required String title,
      required IconData icon,
      required String sub,
      String? relation,
      String? description}) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          color: kPrimary100Color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            profileShadow(kPrimary100Color),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Space(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 5),
              Icon(
                icon,
                size: 20,
                color: kPrimaryColor,
              ),
              SizedBox(width: 15),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      relation != null ? "$sub ($relation)" : sub,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    Space(3),
                    description != null
                        ? Text(
                            description,
                            style: TextStyle(
                              color: kGrey,
                              fontSize: 12,
                            ),
                          )
                        : Space(0),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget profilePic() {
    return Hero(
      tag: 'editprofile',
      child: Container(
        width: 100,
        height: 100,
        padding: EdgeInsets.all(0.5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: kPrimaryColor),
        ),
        child: CachedNetworkImage(
          imageUrl: src,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => const CircularProgressIndicator(
            color: kPrimaryColor,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
