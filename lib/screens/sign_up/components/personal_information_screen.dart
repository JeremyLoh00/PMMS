import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:get_it/get_it.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:private_nurse_for_client/bloc/city_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/register_client_form_bloc.dart';
import 'package:private_nurse_for_client/models/bank/bank_model.dart';
import 'package:private_nurse_for_client/models/city/city_model.dart';
import 'package:private_nurse_for_client/models/city/city_response_model.dart';
import 'package:private_nurse_for_client/models/division/division_model.dart';
import 'package:private_nurse_for_client/models/gender/gender_model.dart';
import 'package:private_nurse_for_client/public_components/custom_dialog.dart';
import 'package:private_nurse_for_client/public_components/styled_dropdown.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';
import 'package:private_nurse_for_client/screens/edit_profile/edit_profile_screen.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/input_decoration.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/screens/sign_up/components/body.dart';
import 'package:private_nurse_for_client/screens/sign_up/components/email_verification_screen.dart';
import 'package:private_nurse_for_client/screens/sign_up/components/image_uploader_register.dart';
import 'package:private_nurse_for_client/theme.dart';

class PersonalInformationScreen extends StatefulWidget {
  final RegisterClientFormBloc formBloc;

  PersonalInformationScreen({
    super.key,
    required this.formBloc,
  });

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  SingingCharacter? _character = SingingCharacter.male;
  late DivisionModel selectedDivision;
  CityModel? selectedCity;
  late RegisterClientFormBloc _nurseFormBloc;
  List<CityModel>? listCities = GetIt.instance.get<List<CityModel>>();
  List<DivisionModel>? listDivision = GetIt.instance.get<List<DivisionModel>>();
  XFile? _selectedProfileImage;
  String? _selectedProfileImagePath;

  String? selectedValue;
  String src =
      "https://c4.wallpaperflare.com/wallpaper/246/739/689/digital-digital-art-artwork-illustration-abstract-hd-wallpaper-preview.jpg";
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

  @override
  void initState() {
    super.initState();

    //get the first item in the GetIt
    selectedDivision = listDivision!.firstWhere((division) => true);

// check if the division null or not
    if (widget.formBloc.division.value == "") {
      widget.formBloc.division.updateValue(selectedDivision.id!.toString());
    } else {
      print("obj2");
    }

    print("divisionValue ${widget.formBloc.division.value}");
    // print("cityValue ${widget.formBloc.cityModel.value}");
    print(_selectedProfileImage);

    if (listDivision!.isNotEmpty) selectedDivision = listDivision![0];
    if (listCities![0].id != -1) {
      listCities!.insert(0, CityModel(id: -1, name: "Select Cities"));
    }
    selectedCity = listCities![0];

    if (widget.formBloc.cityModel.value == "") {
      widget.formBloc.cityModel.updateValue(selectedCity!.id!.toString());
    } else {
      print("obj2");
    }
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

  int delayAnimationDuration = 200;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: CircleImageUploader(
              formBloc: widget.formBloc,
              onImageSelected: (XFile selectedImage) {
                setState(() {
                  _selectedProfileImage = selectedImage;
                  widget.formBloc.newProfilePhoto = selectedImage;
                  _selectedProfileImagePath = selectedImage.path;
                });
              },
            ),
          ),
          Space(20),
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: const Text(
              "Personal Information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Space(10),
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: TextFieldBlocBuilder(
              textFieldBloc: widget.formBloc.name,
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
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: TextFieldBlocBuilder(
              scrollPadding: EdgeInsets.only(bottom: 20),
              textFieldBloc: widget.formBloc.email,
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
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: TextFieldBlocBuilder(
              suffixButton: SuffixButton.obscureText,
              //jange letak obscureText: true, nnt icon mata dok tubik
              obscureTextFalseIcon: const Icon(
                Iconsax.eye,
                color: kGrey,
              ),
              obscureTextTrueIcon: const Icon(
                Iconsax.eye_slash,
                color: kGrey,
              ),
              textFieldBloc: widget.formBloc.password,
              cursorColor: kPrimaryColor,
              decoration: textFieldInputDecoration(
                "Password",
                hintText: "Enter your new password",
                prefixIcon: const Icon(
                  Iconsax.lock,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: TextFieldBlocBuilder(
              scrollPadding: EdgeInsets.only(bottom: 20),
              textFieldBloc: widget.formBloc.icNo,
              keyboardType: TextInputType.number,
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
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: TextFieldBlocBuilder(
              textFieldBloc: widget.formBloc.phoneNo,
              keyboardType: TextInputType.number,
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
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: const Text(
              "Gender",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Space(10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: RadioButtonGroupFieldBlocBuilder<GenderModel>(
                  selectFieldBloc: widget.formBloc.gender,
                  fillColor:
                      MaterialStateColor.resolveWith((states) => kPrimaryColor),
                  decoration: radioFieldInputDecoration(
                    "",
                  ),
                  groupStyle: const ListGroupStyle(
                    scrollDirection: Axis.horizontal,
                    height: 40,
                    width: double.infinity,
                  ),
                  itemBuilder: (context, item) => FieldItem(
                    child: Text(item.name!),
                  ),
                ),
              ),
            ],
          ),
          Space(10),
          const Text(
            "Address",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Space(10),
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: TextFieldBlocBuilder(
              textFieldBloc: widget.formBloc.address,
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
                  child: StyledDropdown<DivisionModel>(
                    items: listDivision!.map<DropdownMenuItem<DivisionModel>>(
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
                        widget.formBloc.division
                            .updateValue(selectedDivision.id!.toString());

                        widget.formBloc.cityModel.updateValue("-1");

                        onChangeDivision();
                      });
                      // updateListJobs();
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 3,
                child: ScaleTap(
                  onPressed: () {},
                  child: StyledDropdown<CityModel>(
                    items: listCities!
                        .map<DropdownMenuItem<CityModel>>((CityModel model) {
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
                        selectedCity = listCities!
                            .firstWhere((model) => model.id == value.id);
                        widget.formBloc.cityModel
                            .updateValue(selectedCity!.id!.toString());
                        print(selectedDivision.id);
                        print(selectedCity!.id);
                      });
                      // updateListJobs();
                    },
                  ),
                ),
              ),
            ],
          ),
          Space(20),
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: const Text(
              "Bank Information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Space(10),
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: DropdownFieldBlocBuilder<BankModel>(
              showEmptyItem: false,
              selectFieldBloc: widget.formBloc.bank,
              itemBuilder: (context, itemData) => FieldItem(
                child: DropdownMenuItem(
                  value: itemData.name,
                  child: Text(itemData.name!),
                ),
              ),
              decoration: textFieldInputDecoration(
                "Bank",
                prefixIcon: Icon(
                  Iconsax.bank,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: TextFieldBlocBuilder(
              textFieldBloc: widget.formBloc.accountNo,
              keyboardType: TextInputType.number,
              cursorColor: kPrimaryColor,
              decoration: textFieldInputDecoration(
                "Account No",
                hintText: "ex: 12345678",
                prefixIcon: Icon(
                  Iconsax.bank,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
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
