import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/theme.dart';

class PatientProfileDescription extends StatefulWidget {
  final JobModel jobModel;
  const PatientProfileDescription({
    Key? key,
    required this.jobModel,
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
    Icons.person_outline,
    Icons.line_axis_outlined,
    Icons.list_alt_rounded,
    Icons.personal_injury_outlined,
    Icons.emergency_outlined,
  ];

  List<String> title = [
    'Personal Info',
    'Diagnosis',
    'Medical History',
    'Patient Condition',
    'Emergency Contact',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Personal Info
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
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 18.0, left: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Space(15.0),
                                  Text(
                                    "Phone No.",
                                    style: textStyleNormal(
                                      color: kGrey,
                                      fontWeight: FontWeight.bold,
                                      fontsize: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 35.0,
                                      top: 10.0,
                                      left: 10.0,
                                      bottom: 10.0,
                                    ),
                                    child: Text(
                                      widget.jobModel.phoneNo!,
                                      style: textStyleNormal(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontsize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Space(15.0),
                                  Text(
                                    "Race",
                                    style: textStyleNormal(
                                      color: kGrey,
                                      fontWeight: FontWeight.bold,
                                      fontsize: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      widget.jobModel.patient!.gender!,
                                      style: textStyleNormal(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontsize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Space(15.0),
                              Text(
                                "Address",
                                style: textStyleNormal(
                                  color: kGrey,
                                  fontWeight: FontWeight.bold,
                                  fontsize: 12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  widget.jobModel.address!,
                                  style: textStyleNormal(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontsize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        //Diagnosis
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
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 40.0, left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Space(10.0),
                              GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 130,
                                  mainAxisExtent: 30,
                                ),
                                shrinkWrap: true,
                                itemCount: widget.jobModel.diagnoses!.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5.0),
                                          child: Container(
                                            height: 30,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: kPrimary100Color,
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            child: Center(
                                              child: Text(
                                                widget.jobModel
                                                    .diagnoses![index].name!,
                                                style: textStyleNormal(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              Space(10.0),
                            ],
                          ),
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
        //Medical History
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
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 40.0, left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Space(10.0),
                              GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150,
                                  mainAxisSpacing: 10,
                                  mainAxisExtent: 30,
                                ),
                                shrinkWrap: true,
                                itemCount:
                                    widget.jobModel.medicalHistories!.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5.0),
                                          child: Container(
                                            height: 30,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: kPrimary100Color,
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            child: Center(
                                              child: Text(
                                                widget
                                                    .jobModel
                                                    .medicalHistories![index]
                                                    .name!,
                                                style: textStyleNormal(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              Space(10.0),
                            ],
                          ),
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
        //Patient Condition
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
                                icon[3],
                                color: kPrimaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                title[3],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 40.0, left: 20.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Space(10.0),
                                  GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 150,
                                      mainAxisSpacing: 10,
                                      mainAxisExtent: 30,
                                    ),
                                    shrinkWrap: true,
                                    itemCount:
                                        widget.jobModel.conditions!.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5.0),
                                              child: Container(
                                                height: 30,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: kPrimary100Color,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    widget
                                                        .jobModel
                                                        .conditions![index]
                                                        .name!,
                                                    style: textStyleNormal(
                                                      color: kPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  Space(10.0),
                                ]),
                          )
                        ]),
                  )
                ],
              ),
            ),
          ),
        ),
        //Emergency Contact
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
                              icon[4],
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              title[4],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Space(15.0),
                              Text(
                                "Name",
                                style: textStyleNormal(
                                  color: kGrey,
                                  fontWeight: FontWeight.bold,
                                  fontsize: 12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  widget
                                      .jobModel.patientEmergencyContact!.name!,
                                  style: textStyleNormal(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontsize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 18.0, left: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Space(15.0),
                                  Text(
                                    "Phone No.",
                                    style: textStyleNormal(
                                      color: kGrey,
                                      fontWeight: FontWeight.bold,
                                      fontsize: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 35.0,
                                      top: 10.0,
                                      left: 10.0,
                                      bottom: 10.0,
                                    ),
                                    child: Text(
                                      widget.jobModel.patientEmergencyContact!
                                          .phoneNo!,
                                      style: textStyleNormal(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontsize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Space(15.0),
                                  Text(
                                    "Relationship",
                                    style: textStyleNormal(
                                      color: kGrey,
                                      fontWeight: FontWeight.bold,
                                      fontsize: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      widget.jobModel.patientEmergencyContact!
                                          .relationship!,
                                      style: textStyleNormal(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontsize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
