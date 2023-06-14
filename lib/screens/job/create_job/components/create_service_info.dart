import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/edit_profile/edit_profile_screen.dart';

class CreateServiceInfo extends StatefulWidget {
  const CreateServiceInfo({super.key});

  @override
  State<CreateServiceInfo> createState() => _CreateServiceInfoState();
}

List<String> listGender = ['Male', 'Female'];

List<String> listRace = ['Malay', 'Chinese', 'Indian', 'Others'];

class _CreateServiceInfoState extends State<CreateServiceInfo> {
  String? nurseDropdown;
  String genderOption = listGender[0];
  String raceOption = listRace[0];

  final nurseList = [
    'Ali',
    'Ahmad',
    'Abu',
    'Ah Meng',
    'Puva',
  ];

  List<bool> value = [
    true,
    false,
    true,
    false,
    true,
    false,
  ];

  List<String> checkboxText = [
    'Wound Dressing',
    'Daycare Service',
    'Live-in service',
    'Feeding Tube Insertion/Removal/Exchange',
    'Urinal tube insertion/Removal/Exchange',
    'Physiotheraphy',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Service",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: checkboxText.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: value[index],
                          onChanged: (bool? newValue) {
                            setState(() {
                              value[index] = newValue!;
                            });
                          },
                        ),
                        Text(checkboxText[index]),
                      ],
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Prefered Nurse",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              child: DropdownButtonFormField(
                hint: Text("Preferred Days"),
                value: nurseDropdown,
                onChanged: (String? newValue) {
                  setState(() {
                    nurseDropdown = newValue ?? "";
                  });
                },
                items: _nurse(),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_4_outlined,
                  ),
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
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Column(
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
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _nurse() {
    return nurseList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}
