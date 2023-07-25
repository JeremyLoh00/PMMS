import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/store_job_form_bloc.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/create_job_header.dart';
import 'package:private_nurse_for_client/screens/job/create_job/job_history/components/history_job_body.dart';

class HistoryJob extends StatefulWidget {
  const HistoryJob({super.key});

  @override
  State<HistoryJob> createState() => _HistoryJobState();
}

class _HistoryJobState extends State<HistoryJob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Create Job",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            color: kBlack,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: HistoryJobBody(),
          ),
        ],
      ),
    );
  }
}
