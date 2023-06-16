import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/screens/sign_up/components/email_verification_screen.dart';
import 'package:private_nurse_for_client/screens/sign_up/components/personal_information_screen.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Body extends StatefulWidget {
  int activeStepper;
  Body({
    super.key,
    required this.activeStepper
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  
  int totalStepperCount = 2;
  int delayAnimationDuration = 200;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Step 1 of $totalStepperCount",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: "Poppins"),
                  ),
                ],
              ),
              Space(10),
              StepProgressIndicator(
                totalSteps: totalStepperCount,
                size: 6.0,
                currentStep: widget.activeStepper,
                selectedColor: kPrimaryColor,
                unselectedColor: kGrey.shade300,
                roundedEdges: const Radius.circular(20),
              ),
              Space(30),
            ],
          ),
        ],
      ),
    );
  }
}
