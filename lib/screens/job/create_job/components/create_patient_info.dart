import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/multi_select.dart';

class CreatePatientInfo extends StatefulWidget {
  const CreatePatientInfo({super.key});

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
  TextEditingController idNum = TextEditingController();
  TextEditingController patient = TextEditingController();
  TextEditingController medical = TextEditingController();
  TextEditingController condition = TextEditingController();
  TextEditingController nameEmergency = TextEditingController();
  TextEditingController phoneNum = TextEditingController();
  TextEditingController relationship = TextEditingController();
  TextEditingController needs = TextEditingController();
  String genderOption = listGender[0];
  String raceOption = listRace[0];

  List<String> _selectPatient = [];
  List<String> _selectMedical = [];
  List<String> _selectCondition = [];

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
        SizedBox(
          height: 15,
        ),
        //Gender And Race
        _genderAndRace(),
        //Photo Patient
        _photoPatient(),
        SizedBox(
          height: 10,
        ),
        //Emergency Contact Information
        _emergencyContact(),
        SizedBox(
          height: 10,
        ),
        //Special Needs
        _specialNeeds()
      ],
    );
  }

  @override
  _emergencyContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Emergency Contact",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: nameEmergency,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person_outline),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            enabled: true,
            hintText: 'Name',
            label: Text('Name'),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: phoneNum,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.phone_outlined),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            enabled: true,
            hintText: 'Phone No.',
            label: Text('Phone No.'),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: relationship,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.group_outlined),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            enabled: true,
            hintText: 'Relationship',
            label: Text('Relationship'),
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
                  icon: Icon(Icons.download),
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
                  onPressed: () {},
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
                  icon: Icon(Icons.download),
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
                  onPressed: () {},
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
              Container(
                height: 200,
                width: 180,
                child: Column(
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
                Container(
                  height: 250,
                  width: 200,
                  child: Column(
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
      children: [
        TextFormField(
          controller: name,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            prefixIcon: Icon(Icons.person_outline_rounded),
            enabled: true,
            hintText: 'Name',
            labelText: 'Name',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          controller: idNum,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            prefixIcon: Icon(Icons.perm_contact_calendar_sharp),
            enabled: true,
            hintText: 'NRIC No.',
            labelText: 'NRIC No./Password No.',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
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
      ],
    );
  }

  _specialNeeds() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Special Needs",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: needs,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            prefixIcon: Icon(Icons.chat_outlined),
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
        ),
      ],
    );
  }
}
