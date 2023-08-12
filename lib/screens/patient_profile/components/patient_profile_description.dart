import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Personal Info
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          margin: EdgeInsets.only(top: 15, right: 15, left: 15),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.person_outline,
                    color: kPrimaryColor,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Personal Info',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
              Divider(
                color: kGrey,
                thickness: 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Age",
                          style: textStyleNormal(
                            color: kGrey,
                            fontWeight: FontWeight.bold,
                            fontsize: 14,
                          ),
                        ),
                        Space(5),
                        Text(
                          widget.jobModel.patient!.age!,
                          style: textStyleNormal(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontsize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Race",
                          style: textStyleNormal(
                            color: kGrey,
                            fontWeight: FontWeight.bold,
                            fontsize: 14,
                          ),
                        ),
                        Space(5),
                        Text(
                          widget.jobModel.patient!.race!,
                          style: textStyleNormal(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontsize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nationality",
                          style: textStyleNormal(
                            color: kGrey,
                            fontWeight: FontWeight.bold,
                            fontsize: 14,
                          ),
                        ),
                        Space(5),
                        Text(
                          widget.jobModel.patient!.nationality!,
                          style: textStyleNormal(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontsize: 12,
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

        //Diagnosis
        patientInfoItemDetails(
          icon: Icons.line_axis_outlined,
          title: 'Diagnosis',
          list: widget.jobModel.diagnoses!,
        ),
        //Medical History
        patientInfoItemDetails(
          icon: Icons.list_alt_rounded,
          title: 'Medical History',
          list: widget.jobModel.medicalHistories!,
        ),
        //Patient Condition
        patientInfoItemDetails(
          icon: Icons.personal_injury_outlined,
          title: 'Patient Condition',
          list: widget.jobModel.conditions!,
        ),

        //patientInfoItem(), //Emergency Contact
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          margin: EdgeInsets.only(top: 15, right: 15, left: 15),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.emergency_outlined,
                    color: kPrimaryColor,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Emergency Contact',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
              Divider(
                color: kGrey,
                thickness: 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: textStyleNormal(
                          color: kGrey,
                          fontWeight: FontWeight.bold,
                          fontsize: 14,
                        ),
                      ),
                      Space(5),
                      Text(
                        widget.jobModel.patientEmergencyContact!.name!,
                        style: textStyleNormal(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontsize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Space(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Phone No",
                          style: textStyleNormal(
                            color: kGrey,
                            fontWeight: FontWeight.bold,
                            fontsize: 14,
                          ),
                        ),
                        Space(5),
                        Text(
                          widget.jobModel.patientEmergencyContact!.phoneNo!,
                          style: textStyleNormal(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontsize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Relationship",
                          style: textStyleNormal(
                            color: kGrey,
                            fontWeight: FontWeight.bold,
                            fontsize: 14,
                          ),
                        ),
                        Space(5),
                        Text(
                          widget
                              .jobModel.patientEmergencyContact!.relationship!,
                          style: textStyleNormal(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontsize: 14,
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
      ],
    );
  }

  Widget patientInfoItemDetails({
    required IconData icon,
    required String title,
    required List<dynamic> list,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      margin: EdgeInsets.only(top: 15, right: 15, left: 15),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: kPrimaryColor,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
          Space(10),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 10,
              mainAxisExtent: 25,
              crossAxisSpacing: 25,
            ),
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: kPrimary100Color,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  list[index].name!,
                  style: textStyleNormal(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontsize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget patientInfoItem() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade300,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Patient Condition",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
