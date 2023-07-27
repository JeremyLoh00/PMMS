import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/content.dart';
import 'package:private_nurse_for_client/public_components/theme_app_bar.dart';
import 'package:private_nurse_for_client/screens/job_description/components/body.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Content(
        body: Body(
          jobModel: widget.jobModel,
        ),

        //Add button here if needed

        // footer: Padding(
        //   padding: const EdgeInsets.all(15.0),
        //   child: ButtonPrimary(
        //     "Pay", onPressed: () => (),
        //     loadingText: "Updating...",
        //   ),
        // ),
      ),
    );
  }
}
