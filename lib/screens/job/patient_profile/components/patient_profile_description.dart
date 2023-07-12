import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/theme.dart';

class PatientProfileDescription extends StatefulWidget {
  const PatientProfileDescription({
    Key? key,
  }) : super(key: key);

  @override
  State<PatientProfileDescription> createState() =>
      _PatientProfileDescriptionState();
}

class _PatientProfileDescriptionState extends State<PatientProfileDescription> {
  final int charactersLimit = 150;
  late String initialText;
  late String extendedText;

  bool hide = true;

  List<IconData> icon = [
    Icons.line_axis_outlined,
    Icons.list_alt_rounded,
    Icons.personal_injury_outlined,
  ];

  List<String> title = [
    'Diagnosis',
    'Medical History',
    'Patient Condition',
  ];

  List<String> text1 = [
    'Hypertension',
    'Skin Problem',
  ];

  List<String> text2 = [
    'Diabetics',
    'Hypertension',
    'Skin Problem',
  ];

  List<String> text3 = [
    'Bed Bound',
    'Not Cooperative',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScaleTap(
          onPressed: null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  profileShadow(
                    kGrey.withOpacity(0.3),
                  ),
                ],
              ),
              child: Row(
                // row for 2 column: image and column
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Space(7),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              icon[0],
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              title[0],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: text1.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        color: kBlack,
                                        fontSize: 12.0,
                                        letterSpacing: 0.5,
                                        height: 1.5,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "\u2022 ",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        TextSpan(
                                          text: text1[index],
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ScaleTap(
          onPressed: null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  profileShadow(
                    kGrey.withOpacity(0.3),
                  ),
                ],
              ),
              child: Row(
                // row for 2 column: image and column
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Space(7),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              icon[1],
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              title[1],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: text2.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        color: kBlack,
                                        fontSize: 12.0,
                                        letterSpacing: 0.5,
                                        height: 1.5,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "\u2022 ",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        TextSpan(
                                          text: text2[index],
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ScaleTap(
          onPressed: null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  profileShadow(
                    kGrey.withOpacity(0.3),
                  ),
                ],
              ),
              child: Row(
                // row for 2 column: image and column
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Space(7),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              icon[2],
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              title[2],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: text3.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        color: kBlack,
                                        fontSize: 12.0,
                                        letterSpacing: 0.5,
                                        height: 1.5,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "\u2022 ",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        TextSpan(
                                          text: text3[index],
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
