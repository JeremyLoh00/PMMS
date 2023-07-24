import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/store_job_form_bloc.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
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
  String genderOption = listGender[0];
  String raceOption = listRace[0];

  List<String> _selectPatient = [];
  List<String> _selectMedical = [];
  List<String> _selectCondition = [];

  File? image1;
  File? image2;

  bool value = false;

  void _showMultiSelectPatient() async {
    final List<String> patientList = [
      'Diabetic',
      'Hipertensi',
      'Heart Failure',
      'Kidney Disease',
      'Dyalisis',
      'Asthma',
      'Skin Problem',
      'Blindness',
      'Dementia',
      'Alzheimer',
      'Stroke',
      'Other',
    ];

    final List<String>? resultsPatient = await showDialog(
      context: context,
      builder: (context) {
        return MultiSelectPatient(
          patientList: patientList,
        );
      },
    );

    //Update UI
    if (resultsPatient != null) {
      setState(() {
        _selectPatient = resultsPatient;
        for (var i = 0; i < _selectPatient.length; i++) {
          patient.text = _selectPatient[i].toString();
        }
      });
    }
  }

  void _showMultiSelectMedical() async {
    final List<String> medicalList = [
      'Diabetic',
      'Hipertensi',
      'Heart Failure',
      'Kidney Disease',
      'Dyalisis',
      'Asthma',
      'Skin Problem',
      'Blindness',
      'Dementia',
      'Alzheimer',
      'Stroke',
      'Other',
    ];

    final List<String>? resultsMedical = await showDialog(
      context: context,
      builder: (context) {
        return MultiSelectMedical(
          medicalList: medicalList,
        );
      },
    );

    //Update UI
    if (resultsMedical != null) {
      setState(() {
        _selectMedical = resultsMedical;
        for (var i = 0; i < _selectMedical.length; i++) {
          medical.text = _selectMedical[i].toString();
        }
      });
    }
  }

  void _showMultiSelectCondition() async {
    final List<String> conditionList = [
      'Wheelchair Bound',
      'Bed Bound',
      'Can Ambulate',
      'Can Talk and Walk',
      'Cannot Talk',
      'Cooperative',
      'Not Cooperative',
    ];

    final List<String>? resultsCondition = await showDialog(
      context: context,
      builder: (context) {
        return MultiSelectCondition(
          conditionList: conditionList,
        );
      },
    );

    //Update UI
    if (resultsCondition != null) {
      setState(() {
        _selectCondition = resultsCondition;
        for (var i = 0; i < _selectCondition.length; i++) {
          condition.text = _selectCondition[i].toString();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Patient Information
        _patientInfo(),
        //address
        _address(),
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  enabled: true,
                  hintText: 'Photo 1',
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
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.upload),
                  label: Text(
                    "Upload".toUpperCase(),
                    style: TextStyle(fontSize: 14),
                  ),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(kSecondaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: kSecondaryColor)),
                    ),
                  ),
                  onPressed: () => {getGalleryImage1()},
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  enabled: true,
                  hintText: 'Photo 2',
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
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.upload),
                  label: Text(
                    "Upload".toUpperCase(),
                    style: TextStyle(fontSize: 14),
                  ),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(kSecondaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: kSecondaryColor)),
                    ),
                  ),
                  onPressed: () => {getGalleryImage2()},
                ),
              ],
            ),
          ],
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
                  value: this.value,
                  onChanged: (bool? value) {
                    setState(() {
                      this.value = value!;
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

  Future getGalleryImage1() async {
    //access gallery and get selected image path
    try {
      final image1 = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image1 == null) return;

      final imageTemporary = File(image1.path);
      setState(() {
        this.image1 = imageTemporary;
      });
    } on PlatformException {
      if (kDebugMode) {
        print("Failed to pick image");
      }
    }
  }

  Future getGalleryImage2() async {
    //access gallery and get selected image path
    try {
      final image2 = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image2 == null) return;

      final imageTemporary = File(image2.path);
      setState(() {
        this.image2 = imageTemporary;
      });
    } on PlatformException {
      if (kDebugMode) {
        print("Failed to pick image");
      }
    }
  }

  _address() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Address",
          style: textStyleNormal(
            fontWeight: FontWeight.bold,
            fontsize: 16.0,
          ),
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
                controller: address,
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
                controller: address,
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
        TextFormField(
          readOnly: true,
          controller: patient,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            suffixIcon: Icon(Icons.arrow_drop_down_outlined),
            enabled: true,
            hintText: 'Patient Diagnosis',
            labelText: 'Patient Diagnosis',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onTap: _showMultiSelectPatient,
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          readOnly: true,
          controller: medical,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            suffixIcon: Icon(Icons.arrow_drop_down_outlined),
            enabled: true,
            hintText: 'Medical History',
            labelText: 'Medical History',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onTap: _showMultiSelectMedical,
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          readOnly: true,
          controller: condition,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            suffixIcon: Icon(Icons.arrow_drop_down_outlined),
            enabled: true,
            hintText: 'Patient Condition',
            labelText: 'Patient Condition',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onTap: _showMultiSelectCondition,
        ),
        Space(15.0),
      ],
    );
  }
}
