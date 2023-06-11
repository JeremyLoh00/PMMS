import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/public_components/h1.dart';
import 'package:private_nurse_for_client/screens/job/components/job_description.dart';
import 'package:private_nurse_for_client/screens/job/components/job_header.dart';
import 'package:private_nurse_for_client/screens/job/components/job_application_list.dart';
import 'package:private_nurse_for_client/screens/job/components/your_progress.dart';

class JobDetail extends StatefulWidget {
  const JobDetail({super.key});

  @override
  State<JobDetail> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        // title: H1(title: "Contest Details"),
        centerTitle: true,
        backgroundColor: kWhite,
        foregroundColor: kBlack,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: double.infinity,
                      child: Hero(
                        tag: "contest-banner",
                        child: Text("data"),
                        // child: Container(
                        //   decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //       image: NetworkImage(
                        //       ),
                        //       fit: BoxFit.fill,
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    JobHeader(
                      name: "Nafiz",
                      dateTime: "Due ",
                    ),
                    const SizedBox(height: 15.0),

                    JobDescription(
                        description:
                            "widget.contestListModel.contestDescription!"),
                    const SizedBox(height: 15.0),

                    // //user contest progress
                    // YourProgress(percentageValue: 2),
                    // const SizedBox(height: 15.0),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "Winners",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
              // //contest winner list
              // ContestWinnerList(),
            ],
          ),
        ),
      ),
    );
  }
}
