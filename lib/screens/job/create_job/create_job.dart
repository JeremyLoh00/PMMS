import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/create_job_header.dart';

class CreateJob extends StatefulWidget {
  const CreateJob({super.key});

  @override
  State<CreateJob> createState() => _CreateJobState();
}

class _CreateJobState extends State<CreateJob> {
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
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            CreateJobHeader(),
          ],
        ),
      ),
    );
  }
}
