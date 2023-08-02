import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/content.dart';
import 'package:private_nurse_for_client/screens/job_description/components/body.dart';
import 'package:private_nurse_for_client/screens/payment/payment.dart';
import 'package:private_nurse_for_client/screens/review/review.dart';

class JobDescription extends StatefulWidget {
  final JobModel jobModel;
  const JobDescription({super.key, required this.jobModel});

  @override
  State<JobDescription> createState() => _JobDescriptionState();
}

class _JobDescriptionState extends State<JobDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //Back button on appbar
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: kWhite.withOpacity(0.3), shape: BoxShape.circle),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: kBlack),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Content(
          body: Body(
            jobModel: widget.jobModel,
          ),
          //Bottom button with condition
          footer: widget.jobModel.status! == "Waiting Payment" //Waiting payment
              ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ButtonPrimary(
                    "Pay",
                    onPressed: () => navigateTo(
                    context,
                    Payment(
                   
                    ),
                  ),
                    loadingText: "Updating...",
                  ),
                )
              : widget.jobModel.status! == "Waiting Client Reviews" //Waiting payment
              ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ButtonPrimary(
                    "Review",
                    onPressed: () => navigateTo(
                    context,
                   Review()
                  ),
                    loadingText: "Updating...",
                  ),
                ): SizedBox()),
    );
  }
}
