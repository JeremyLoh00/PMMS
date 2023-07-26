import 'dart:io';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/store_job_form_bloc.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/image_uploader_job.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/multi_select.dart';
import 'package:image_picker/image_picker.dart';
import 'package:private_nurse_for_client/theme.dart';

class CreatePatientInfo extends StatefulWidget {
  StoreJobFormBloc storeJobFormBloc;
  CreatePatientInfo({
    super.key,
    required this.storeJobFormBloc,
  });

  @override
  State<CreatePatientInfo> createState() => _CreatePatientInfoState();
}

List<String> listGender = ['Male', 'Female'];

List<String> listRace = ['Malay', 'Chinese', 'Indian', 'Others'];

List<bool> value = [
  true,
  false,
  true,
  false,
  true,
  false,
];

final List<ValueItem> patientList = [
  ValueItem(label: 'Diabetic', value: '1'),
  ValueItem(label: 'Hipertensi', value: '2'),
  ValueItem(label: 'Heart Failure', value: '3'),
  ValueItem(label: 'Kidney Disease', value: '4'),
  ValueItem(label: 'Dyalisis', value: '5'),
  ValueItem(label: 'Asthma', value: '6'),
  ValueItem(label: 'Skin Problem', value: '7'),
  ValueItem(label: 'Blindness', value: '8'),
  ValueItem(label: 'Dementia', value: '9'),
  ValueItem(label: 'Alzheimer', value: '10'),
  ValueItem(label: 'Stroke', value: '11'),
  ValueItem(label: 'Other', value: '12'),
];

final List<ValueItem> medicalList = [
  ValueItem(label: 'Diabetic', value: '1'),
  ValueItem(label: 'Hipertensi', value: '2'),
  ValueItem(label: 'Heart Failure', value: '3'),
  ValueItem(label: 'Kidney Disease', value: '4'),
  ValueItem(label: 'Dyalisis', value: '5'),
  ValueItem(label: 'Asthma', value: '6'),
  ValueItem(label: 'Skin Problem', value: '7'),
  ValueItem(label: 'Blindness', value: '8'),
  ValueItem(label: 'Dementia', value: '9'),
  ValueItem(label: 'Alzheimer', value: '10'),
  ValueItem(label: 'Stroke', value: '11'),
  ValueItem(label: 'Other', value: '12'),
];

final List<ValueItem> conditionList = [
  ValueItem(label: 'Wheelchair Bound', value: '1'),
  ValueItem(label: 'Bed Bound', value: '2'),
  ValueItem(label: 'Can Ambulate', value: '3'),
  ValueItem(label: 'Can Talk and Walk', value: '4'),
  ValueItem(label: 'Cannot Talk', value: '5'),
  ValueItem(label: 'Cooperative', value: '6'),
  ValueItem(label: 'Not Cooperative', value: '7'),
];

class _CreatePatientInfoState extends State<CreatePatientInfo> {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController patient = TextEditingController();
  TextEditingController medical = TextEditingController();
  TextEditingController condition = TextEditingController();
  TextEditingController nameEmergency = TextEditingController();
  TextEditingController phoneNum = TextEditingController();
  TextEditingController relationship = TextEditingController();
  TextEditingController needs = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController idCard = TextEditingController();
  final MultiSelectController _controllerPatientDiagnosis =
      MultiSelectController();
  final MultiSelectController _controllerMedicalHistory =
      MultiSelectController();
  final MultiSelectController _controllerPatientCondition =
      MultiSelectController();
  String genderOption = listGender[0];
  String raceOption = listRace[0];

  List<String> _selectPatient = [];
  List<String> _selectMedical = [];
  List<String> _selectCondition = [];

  XFile? _selectedFormalImage1;
  File? image1;
  File? image2;
  File? image3;

  bool valuePhoneNum = false;
  bool valueAddress = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Patient Information
        _patientInfo(),
        //address
        _address(),
        //Identification card
        _idInfo(),
        //multiple select
        _multipleSelectInput(),
        //Gender And Race
        _genderAndRace(),
        //Photo Patient
        _photoPatient(),
      ],
    );
  }

  _photoPatient() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "2 Photos of Patient",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        DelayedDisplay(
          delay: Duration(milliseconds: delayAnimationDuration),
          child: InputFormalPhoto2(
            formBloc: widget.storeJobFormBloc,
            onImageFormalSelected: (XFile selectedImage) {
              setState(() {
                _selectedFormalImage1 = selectedImage;
                widget.storeJobFormBloc.newFormalPhoto1 = selectedImage;
              });
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        DelayedDisplay(
          delay: Duration(milliseconds: delayAnimationDuration),
          child: InputFormalPhoto3(
            formBloc: widget.storeJobFormBloc,
            onImageFormalSelected: (XFile selectedImage) {
              setState(() {
                _selectedFormalImage1 = selectedImage;
                widget.storeJobFormBloc.newFormalPhoto1 = selectedImage;
              });
            },
          ),
        ),
      ],
    );
  }

  _genderAndRace() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Gender",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  RadioListTile(
                    title: Text("Male"),
                    value: listGender[0],
                    groupValue: genderOption,
                    onChanged: (value) {
                      setState(() {
                        genderOption = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("Female"),
                    value: listGender[1],
                    groupValue: genderOption,
                    onChanged: (value) {
                      setState(() {
                        genderOption = value.toString();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Race",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  children: [
                    RadioListTile(
                      title: Text("Malay"),
                      value: listRace[0],
                      groupValue: raceOption,
                      onChanged: (value) {
                        setState(() {
                          raceOption = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("Chinese"),
                      value: listRace[1],
                      groupValue: raceOption,
                      onChanged: (value) {
                        setState(() {
                          raceOption = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("Indian"),
                      value: listRace[2],
                      groupValue: raceOption,
                      onChanged: (value) {
                        setState(() {
                          raceOption = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("Others"),
                      value: listRace[3],
                      groupValue: raceOption,
                      onChanged: (value) {
                        setState(() {
                          raceOption = value.toString();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _patientInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Name",
          style: textStyleNormal(
            fontWeight: FontWeight.bold,
            fontsize: 16.0,
          ),
        ),
        Space(10.0),
        TextFormField(
          controller: name,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            prefixIcon: Icon(Icons.person_outline_rounded),
            enabled: true,
            hintText: 'Name',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        Space(15.0),
        Text(
          "Age",
          style: textStyleNormal(
            fontWeight: FontWeight.bold,
            fontsize: 16.0,
          ),
        ),
        Space(10.0),
        TextFormField(
          controller: age,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            suffixText: "years old",
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            enabled: true,
            hintText: 'Age',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        Space(15.0),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Height",
                    style: textStyleNormal(
                      fontWeight: FontWeight.bold,
                      fontsize: 16.0,
                    ),
                  ),
                  Space(10.0),
                  TextFormField(
                    controller: height,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixText: "cm",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      enabled: true,
                      hintText: 'Height',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Weight",
                    style: textStyleNormal(
                      fontWeight: FontWeight.bold,
                      fontsize: 16.0,
                    ),
                  ),
                  Space(10.0),
                  TextFormField(
                    controller: weight,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixText: "kg",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      enabled: true,
                      hintText: 'Weight',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Space(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Phone No.",
              style: textStyleNormal(
                fontWeight: FontWeight.bold,
                fontsize: 16.0,
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: this.valuePhoneNum,
                  onChanged: (bool? value) {
                    setState(() {
                      this.valuePhoneNum = value!;
                    });
                  },
                ),
                Text(
                  "Copy from my details",
                  style: textStyleNormal(
                    color: kGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
        Space(10.0),
        TextFormField(
          controller: phoneNum,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.phone_outlined),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            enabled: true,
            hintText: 'Phone No.',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        Space(15),
      ],
    );
  }

  _address() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Address",
              style: textStyleNormal(
                fontWeight: FontWeight.bold,
                fontsize: 16.0,
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: this.valueAddress,
                  onChanged: (bool? value) {
                    setState(() {
                      this.valueAddress = value!;
                    });
                  },
                ),
                Text(
                  "Copy from my details",
                  style: textStyleNormal(
                    color: kGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
        Space(10.0),
        TextFormField(
          controller: address,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            enabled: true,
            hintText: 'Address',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        Space(10.0),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: city,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  enabled: true,
                  hintText: 'City',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: TextFormField(
                controller: state,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  enabled: true,
                  hintText: 'State',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        Space(15.0),
      ],
    );
  }

  _multipleSelectInput() {
    return Column(
      children: [
        DelayedDisplay(
          delay: Duration(milliseconds: delayAnimationDuration),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Patient Diagnosis',
                style: textStyleNormal(
                  fontWeight: FontWeight.bold,
                  fontsize: 16.0,
                ),
              ),
              Space(10.0),
              MultiSelectDropDown(
                borderRadius: 10.0,
                borderWidth: 1.0,
                hint: 'Patient Diagnosis',
                hintStyle: textStyleNormal(
                  fontsize: 16.0,
                  color: Colors.grey,
                ),
                borderColor: Colors.grey,
                showClearIcon: true,
                controller: _controllerPatientDiagnosis,
                onOptionSelected: (options) {
                  debugPrint(options.toString());
                },
                options: patientList,
                maxItems: 12,
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(
                    wrapType: WrapType.wrap,
                    backgroundColor: kPrimary100Color,
                    labelColor: kPrimaryColor),
                dropdownHeight: 300,
                optionTextStyle: const TextStyle(fontSize: 16),
                selectedOptionIcon: const Icon(
                  Icons.checklist,
                  color: kPrimaryColor,
                ),
                selectedOptionTextColor: kPrimaryColor,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        DelayedDisplay(
          delay: Duration(milliseconds: delayAnimationDuration),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Medical History',
                style: textStyleNormal(
                  fontWeight: FontWeight.bold,
                  fontsize: 16.0,
                ),
              ),
              Space(10.0),
              MultiSelectDropDown(
                borderRadius: 10.0,
                borderWidth: 1.0,
                hint: 'Medical History',
                hintStyle: textStyleNormal(
                  fontsize: 16.0,
                  color: Colors.grey,
                ),
                borderColor: Colors.grey,
                showClearIcon: true,
                controller: _controllerMedicalHistory,
                onOptionSelected: (options) {
                  debugPrint(options.toString());
                },
                options: medicalList,
                maxItems: 12,
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(
                    wrapType: WrapType.wrap,
                    backgroundColor: kPrimary100Color,
                    labelColor: kPrimaryColor),
                dropdownHeight: 300,
                optionTextStyle: const TextStyle(fontSize: 16),
                selectedOptionIcon: const Icon(
                  Icons.checklist,
                  color: kPrimaryColor,
                ),
                selectedOptionTextColor: kPrimaryColor,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        DelayedDisplay(
          delay: Duration(milliseconds: delayAnimationDuration),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Patient Condition',
                style: textStyleNormal(
                  fontWeight: FontWeight.bold,
                  fontsize: 16.0,
                ),
              ),
              Space(10.0),
              MultiSelectDropDown(
                borderRadius: 10.0,
                borderWidth: 1.0,
                hint: 'Patient Condition',
                hintStyle: textStyleNormal(
                  fontsize: 16.0,
                  color: Colors.grey,
                ),
                borderColor: Colors.grey,
                showClearIcon: true,
                controller: _controllerPatientCondition,
                onOptionSelected: (options) {
                  debugPrint(options.toString());
                },
                options: conditionList,
                maxItems: 7,
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(
                    wrapType: WrapType.wrap,
                    backgroundColor: kPrimary100Color,
                    labelColor: kPrimaryColor),
                dropdownHeight: 300,
                optionTextStyle: const TextStyle(fontSize: 16),
                selectedOptionIcon: const Icon(
                  Icons.checklist,
                  color: kPrimaryColor,
                ),
                selectedOptionTextColor: kPrimaryColor,
              ),
            ],
          ),
        ),
        Space(15.0),
      ],
    );
  }

  int delayAnimationDuration = 200;

  _idInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "NRIC No. / Passport No.",
          style: textStyleNormal(
            fontWeight: FontWeight.bold,
            fontsize: 16.0,
          ),
        ),
        Space(10.0),
        TextFormField(
          controller: idCard,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.credit_card),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            enabled: true,
            hintText: 'NRIC No.',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        Space(10.0),
        DelayedDisplay(
          delay: Duration(milliseconds: delayAnimationDuration),
          child: InputFormalPhoto1(
            formBloc: widget.storeJobFormBloc,
            onImageFormalSelected: (XFile selectedImage) {
              setState(() {
                _selectedFormalImage1 = selectedImage;
                widget.storeJobFormBloc.newFormalPhoto1 = selectedImage;
              });
            },
          ),
        ),
        Space(15.0),
      ],
    );
  }
}
