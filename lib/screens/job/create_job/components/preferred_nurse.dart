import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/public_components/space.dart';

class PreferredNurse extends StatefulWidget {
  const PreferredNurse({super.key});

  @override
  State<PreferredNurse> createState() => _PreferredNurseState();
}

List<String> listGender = ['Male', 'Female'];

List<String> listRace = ['Malay', 'Chinese', 'Indian', 'Others'];

class _PreferredNurseState extends State<PreferredNurse> {
  String genderOption = listGender[0];
  String raceOption = listRace[0];
  int delayAnimationDuration = 200;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DelayedDisplay(
          delay: Duration(milliseconds: delayAnimationDuration),
          child: const Text(
            "Preferred Nurse",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Space(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 10,
            ),
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
                padding: const EdgeInsets.only(right: 10.0),
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
        ),
      ],
    );
  }
}
