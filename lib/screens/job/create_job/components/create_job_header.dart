import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/ceate_job_info.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/create_patient_info.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/create_service_info.dart';
import 'package:private_nurse_for_client/screens/job/payment/payment.dart';

class CreateJobHeader extends StatefulWidget {
  const CreateJobHeader({super.key});

  @override
  State<CreateJobHeader> createState() => _CreateJobHeaderState();
}

class _CreateJobHeaderState extends State<CreateJobHeader> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stepper(
        physics: BouncingScrollPhysics(),
        type: StepperType.horizontal,
        steps: getSteps(),
        currentStep: currentStep,
        onStepContinue: () {
          final isLastStep = currentStep == getSteps().length - 1;

          if (isLastStep) {
            navigateTo(context, Payment());

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
              child: ElevatedButton(
                child:
                    Text("Next".toUpperCase(), style: TextStyle(fontSize: 14)),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kPrimaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                ),
                onPressed: details.onStepContinue,
              ),
            ),
          );
        },
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          label: Text("Job Info"),
          title: SizedBox(),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.625,
            child: CreateJobInfo(),
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          label: Text("Service Info"),
          title: SizedBox(),
          content: CreateServiceInfo(),
        ),
        Step(
          isActive: currentStep >= 2,
          label: Text("Patient Info"),
          title: SizedBox(),
          content: Container(
            child: CreatePatientInfo(),
          ),
        ),
      ];
}
