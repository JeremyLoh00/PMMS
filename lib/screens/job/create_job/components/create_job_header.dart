import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/store_job_form_bloc.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/public_components/loading_dialog.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/screens/dashboard/home_screen.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/ceate_job_info.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/create_patient_info.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/create_service_info.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/emergency_contact.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/preferred_nurse.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/summary.dart';
import 'package:private_nurse_for_client/screens/job/payment/payment.dart';
import 'package:private_nurse_for_client/screens/navigation/navigation.dart';
import 'package:private_nurse_for_client/theme.dart';
import 'package:table_calendar/table_calendar.dart';

class CreateJobHeader extends StatefulWidget {
  StoreJobFormBloc storeJobFormBloc;
  Function()? onPressed;
  CreateJobHeader({
    super.key,
    required this.storeJobFormBloc,
  });

  @override
  State<CreateJobHeader> createState() => _CreateJobHeaderState();
}

class _CreateJobHeaderState extends State<CreateJobHeader> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreJobFormBloc(),
      child: Builder(
        builder: (context) {
          final storeJobForm = BlocProvider.of<StoreJobFormBloc>(context);

          return FormBlocListener<StoreJobFormBloc, String, String>(
            // On submitting
            onSubmitting: ((context, state) {
              FocusScope.of(context).unfocus();
              LoadingDialog.show(context);
            }),
            //On Submission Failed
            onSubmissionFailed: (context, state) {
              LoadingDialog.hide(context);
            },
            // On Success
            onSuccess: (context, state) {
              LoadingDialog.hide(context);
            },
            // On failure
            onFailure: (context, state) {
              LoadingDialog.hide(context);
              ThemeSnackBar.showSnackBar(
                  context, state.failureResponse ?? "Error");
            },
            // Design
            child: Stepper(
              elevation: 0,
              physics: BouncingScrollPhysics(),
              type: StepperType.horizontal,
              // steps: [],
              steps: getSteps(),
              currentStep: currentStep,
              onStepContinue: () {
                final isLastStep = currentStep == getSteps().length - 1;

                if (isLastStep) {
                  Navigator.pop(context);

                  //send the data to the server
                } else {
                  setState(() {
                    currentStep += 1;
                  });
                }
              },
              onStepCancel: currentStep == 0
                  ? null
                  : () {
                      setState(() {
                        currentStep -= 1;
                      });
                    },
              controlsBuilder: (context, details) {
                return Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          child: Text("Back".toUpperCase(),
                              style: TextStyle(fontSize: 14)),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(kPrimaryColor),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kWhite),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: kPrimaryColor),
                              ),
                            ),
                          ),
                          onPressed: currentStep == 0
                              ? () {
                                  Navigator.pop(context);
                                }
                              : details.onStepCancel,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          child: Text(
                              currentStep == 5
                                  ? "Post Job"
                                  : "Next".toUpperCase(),
                              style: TextStyle(fontSize: 14)),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kPrimaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: kPrimaryColor),
                              ),
                            ),
                          ),
                          onPressed: currentStep == 5
                              ? () {
                                  Navigator.pop(context);
                                }
                              : details.onStepContinue,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  // List<Step> getSteps() => [Step(title: Text(""), content: Text("data"))];
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          label: Text(
            "Job Info",
            style: textStyleNormal(
              fontsize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          title: SizedBox(),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.625,
            child: CreateJobInfo(
              storeJobFormBloc: widget.storeJobFormBloc,
              selectedDays: _selectedDays,
            ),
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          label: Text(
            "Service Info",
            style: textStyleNormal(
              fontsize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          title: SizedBox(),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.625,
            child: CreateServiceInfo(
              widget.storeJobFormBloc,
              selectedDays: _selectedDays,
            ),
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          label: Container(
            width: 55,
            child: Column(
              children: [
                Text(
                  "Preferred",
                  style: textStyleNormal(
                    fontsize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Nurse",
                  style: textStyleNormal(
                    fontsize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          title: SizedBox(),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.625,
            child: PreferredNurse(),
          ),
        ),
        Step(
          isActive: currentStep >= 3,
          label: Text(
            "Patient Info",
            style: textStyleNormal(
              fontsize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          title: SizedBox(),
          content: CreatePatientInfo(
            storeJobFormBloc: widget.storeJobFormBloc,
          ),
        ),
        Step(
          isActive: currentStep >= 4,
          label: Container(
            width: 55,
            child: Column(
              children: [
                Text(
                  "Emergency",
                  style: textStyleNormal(
                    fontsize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Contact",
                  style: textStyleNormal(
                    fontsize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          title: SizedBox(),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.625,
            child: EmergencyContact(),
          ),
        ),
        Step(
          isActive: currentStep >= 5,
          label: Text(
            "Summary",
            maxLines: 1,
            style: textStyleNormal(
              fontsize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          title: SizedBox(),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.625,
            child: Summary(),
          ),
        ),
      ];
}
