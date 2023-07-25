import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/summary.dart';
import 'package:private_nurse_for_client/theme.dart';

class JobAndServiceInfoSummary extends StatefulWidget {
  List<String> nameCard;
  List<IconData> cardIcon;
  List<int> numDay;
  List<String> date;
  List<String> timeBefore;
  List<String> timeAfter;
  JobAndServiceInfoSummary({
    super.key,
    required this.nameCard,
    required this.cardIcon,
    required this.numDay,
    required this.date,
    required this.timeBefore,
    required this.timeAfter,
  });

  @override
  State<JobAndServiceInfoSummary> createState() =>
      _JobAndServiceInfoSummaryState();
}

class _JobAndServiceInfoSummaryState extends State<JobAndServiceInfoSummary> {
  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onPressed: null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: EdgeInsets.only(top: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              profileShadow(
                kGrey.withOpacity(0.2),
              ),
            ],
          ),
          child: Row(
            // row for 2 column: image and column
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Space(20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(widget.cardIcon[0]),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          widget.nameCard[0],
                          style: textStyleH1(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 80.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Space(15.0),
                              Text(
                                "Service",
                                style: textStyleNormal(
                                  color: kGrey,
                                  fontWeight: FontWeight.bold,
                                  fontsize: 12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Wound Dressing',
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
                                "Rate",
                                style: textStyleNormal(
                                  color: kGrey,
                                  fontWeight: FontWeight.bold,
                                  fontsize: 12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: RichText(
                                  text: TextSpan(
                                    style: textStyleNormal(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontsize: 16,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "RM ",
                                        style: textStyleNormal(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontsize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "19/",
                                        style: textStyleNormal(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontsize: 16,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "hr",
                                        style: textStyleNormal(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontsize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Date & Time",
                      style: textStyleNormal(
                        color: kGrey,
                        fontWeight: FontWeight.bold,
                        fontsize: 12,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "2 days",
                        style: textStyleNormal(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontsize: 16,
                        ),
                      ),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.numDay.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Column(
                            children: [
                              Space(5.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.numDay[index].toString() + ".",
                                        style: textStyleNormal(
                                          fontWeight: FontWeight.bold,
                                          fontsize: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        widget.date[index],
                                        style: textStyleNormal(
                                          fontWeight: FontWeight.bold,
                                          fontsize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 70.0),
                                    child: Text(
                                      widget.timeBefore[index] +
                                          " to " +
                                          widget.timeAfter[index],
                                      style: textStyleNormal(
                                        color: kGrey,
                                        fontWeight: FontWeight.bold,
                                        fontsize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Space(10.0),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PrefferedNurseCard extends StatefulWidget {
  List<String> nameCard;
  List<IconData> cardIcon;
  PrefferedNurseCard({
    super.key,
    required this.cardIcon,
    required this.nameCard,
  });

  @override
  State<PrefferedNurseCard> createState() => _PrefferedNurseCardState();
}

class _PrefferedNurseCardState extends State<PrefferedNurseCard> {
  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onPressed: null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: EdgeInsets.only(top: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              profileShadow(
                kGrey.withOpacity(0.2),
              ),
            ],
          ),
          child: Row(
            // row for 2 column: image and column
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Space(20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(widget.cardIcon[1]),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          widget.nameCard[1],
                          style: textStyleH1(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 80.0, left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Space(15.0),
                              Text(
                                "Gender",
                                style: textStyleNormal(
                                  color: kGrey,
                                  fontWeight: FontWeight.bold,
                                  fontsize: 12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Female',
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
                                "Rate",
                                style: textStyleNormal(
                                  color: kGrey,
                                  fontWeight: FontWeight.bold,
                                  fontsize: 12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Malay',
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
                    Space(10.0),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PatientInfoCard extends StatefulWidget {
  List<String> nameCard;
  List<IconData> cardIcon;
  List<String> patientDiagnosisList;
  List<String> patientConditionList;
  List<String> imageList;
  PatientInfoCard({
    super.key,
    required this.cardIcon,
    required this.nameCard,
    required this.patientDiagnosisList,
    required this.patientConditionList,
    required this.imageList,
  });

  @override
  State<PatientInfoCard> createState() => _PatientInfoCardState();
}

class _PatientInfoCardState extends State<PatientInfoCard> {
  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onPressed: null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: EdgeInsets.only(top: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              profileShadow(
                kGrey.withOpacity(0.2),
              ),
            ],
          ),
          child: Row(
            // row for 2 column: image and column
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Space(20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(widget.cardIcon[2]),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          widget.nameCard[2],
                          style: textStyleH1(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 80.0, left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
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
                                  'Ms. John',
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
                                "Age",
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
                                  '57',
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
                      padding: const EdgeInsets.only(right: 80.0, left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Space(15.0),
                              Text(
                                "Height",
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
                                  '160 cm',
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
                                "Weight",
                                style: textStyleNormal(
                                  color: kGrey,
                                  fontWeight: FontWeight.bold,
                                  fontsize: 12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 15.0,
                                  top: 10.0,
                                  left: 10.0,
                                  bottom: 10.0,
                                ),
                                child: Text(
                                  '60 kg',
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
                      padding: const EdgeInsets.only(right: 80.0, left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Space(15.0),
                              Text(
                                "Gender",
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
                                  'Female',
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
                                  'Malay',
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
                      padding: const EdgeInsets.only(right: 18.0, left: 20.0),
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
                                  '012-3456789',
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
                                "NRIC",
                                style: textStyleNormal(
                                  color: kGrey,
                                  fontWeight: FontWeight.bold,
                                  fontsize: 12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 10.0,
                                  top: 10.0,
                                  left: 10.0,
                                  bottom: 10.0,
                                ),
                                child: Text(
                                  '691012-10-4828',
                                  style: textStyleNormal(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontsize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 80.0, left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
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
                                  '1, Jalan XXX, Taman YYY,\n26600 Pekan, Pahang.',
                                  style: textStyleNormal(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontsize: 14,
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
                                  'Malay',
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
                      padding: const EdgeInsets.only(right: 40.0, left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Space(15.0),
                          Text(
                            "Patient Diagnosis",
                            style: textStyleNormal(
                              color: kGrey,
                              fontWeight: FontWeight.bold,
                              fontsize: 12,
                            ),
                          ),
                          Space(10.0),
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 130,
                              mainAxisExtent: 30,
                            ),
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: kPrimary100Color,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        patientDiagnosisList[index],
                                        style: textStyleNormal(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          Space(20.0),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0, left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Medical History",
                            style: textStyleNormal(
                              color: kGrey,
                              fontWeight: FontWeight.bold,
                              fontsize: 12,
                            ),
                          ),
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
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: kPrimary100Color,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        patientDiagnosisList[index],
                                        style: textStyleNormal(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          Space(20.0),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Patient Condition",
                            style: textStyleNormal(
                              color: kGrey,
                              fontWeight: FontWeight.bold,
                              fontsize: 12,
                            ),
                          ),
                          Space(10.0),
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 250,
                              mainAxisExtent: 30,
                            ),
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: kPrimary100Color,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        patientConditionList[index],
                                        style: textStyleNormal(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          Space(20.0),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Patient Photo",
                            style: textStyleNormal(
                              color: kGrey,
                              fontWeight: FontWeight.bold,
                              fontsize: 12,
                            ),
                          ),
                          Space(10.0),
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 150,
                              mainAxisExtent: 80,
                            ),
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 130,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: kPrimary100Color,
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          imageList[index],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          Space(20.0),
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
    );
  }
}

class EmergencyContactCard extends StatefulWidget {
  const EmergencyContactCard({super.key});

  @override
  State<EmergencyContactCard> createState() => _EmergencyContactCardState();
}

class _EmergencyContactCardState extends State<EmergencyContactCard> {
  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onPressed: null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: EdgeInsets.only(top: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              profileShadow(
                kGrey.withOpacity(0.2),
              ),
            ],
          ),
          child: Row(
            // row for 2 column: image and column
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Space(20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(cardIcon[3]),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          cardName[3],
                          style: textStyleH1(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 80.0, left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
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
                                  'Mr. John Doe',
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
                                  'Son',
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
                      padding: const EdgeInsets.only(right: 80.0, left: 20.0),
                      child: Column(
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
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '012-3456789',
                              style: textStyleNormal(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontsize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Space(10.0),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
