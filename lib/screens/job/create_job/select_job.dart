import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/screens/job/create_job/job_history/history_job.dart';
import 'package:private_nurse_for_client/screens/job/create_job/create_job.dart';
import 'package:private_nurse_for_client/theme.dart';

class SelectJob extends StatefulWidget {
  const SelectJob({super.key});

  @override
  State<SelectJob> createState() => _SelectJobState();
}

List<String> jobTypeTitle = [
  'Create New Job',
  'Copy from history',
];

List<Widget> jobTypeIcon = [
  Stack(
    children: [
      Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
          border: Border.all(
            color: kPrimaryColor,
            width: 4.0,
          ),
        ),
        child: const Icon(
          Icons.done,
          color: kPrimaryColor,
          size: 30,
        ),
      ),
      const Positioned(
        top: 40,
        child: Icon(
          Icons.calendar_today_outlined,
          size: 55,
          color: Color.fromRGBO(4, 99, 128, 0.253),
        ),
      ),
      const Positioned(
        top: 65,
        left: 10,
        child: Icon(
          Icons.add,
          size: 26,
          color: Color.fromRGBO(4, 99, 128, 0.253),
        ),
      )
    ],
  ),
  Stack(
    children: [
      Positioned(
        top: 25,
        left: 60,
        child: const Icon(
          Icons.calendar_month_outlined,
          color: kPrimaryColor,
          size: 55,
        ),
      ),
      Positioned(
        top: 60,
        left: 95,
        child: Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            border: Border.all(
              color: kWhite,
              width: 1.2,
            ),
          ),
          child: const Icon(
            Icons.search,
            color: kPrimaryColor,
            size: 28,
          ),
        ),
      ),
    ],
  ),
];

class _SelectJobState extends State<SelectJob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Space(30),
          Center(
            child: Text(
              "Select Job Creation Type",
              style: textStyleNormal(
                color: kGrey,
                fontWeight: FontWeight.bold,
                fontsize: 16,
              ),
            ),
          ),
          Space(30),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              mainAxisSpacing: 10,
            ),
            shrinkWrap: true,
            itemCount: jobTypeTitle.length,
            itemBuilder: (context, index) {
              return ScaleTap(
                onPressed: () {
                  setState(() {
                    if (jobTypeTitle[index] == 'Create New Job') {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return const CreateJob();
                          },
                          transitionDuration: const Duration(milliseconds: 100),
                          reverseTransitionDuration:
                              const Duration(milliseconds: 100),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    } else {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return const HistoryJob();
                          },
                          transitionDuration: const Duration(milliseconds: 100),
                          reverseTransitionDuration:
                              const Duration(milliseconds: 100),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: const EdgeInsets.only(top: 10),
                    width: double.infinity,
                    decoration: jobTypeTitle[index] == 'Create New Job'
                        ? BoxDecoration(
                            color: kPrimary100Color,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: kPrimaryColor,
                              width: 2.0,
                            ),
                          )
                        : BoxDecoration(
                            border: Border.all(
                              color: kPrimaryColor,
                              width: 2.0,
                            ),
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              profileShadow(
                                kGrey.withOpacity(0.3),
                              ),
                            ],
                          ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Space(30),
                        Expanded(
                          flex: 1,
                          child: Text(
                            jobTypeTitle[index],
                            style: const TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: jobTypeIcon[index],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 378.0, right: 34.0, bottom: 35.0),
        child: ElevatedButton(
          child:
              Text("Next".toUpperCase(), style: const TextStyle(fontSize: 14)),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: kPrimaryColor),
              ),
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const CreateJob();
                },
                transitionDuration: const Duration(milliseconds: 100),
                reverseTransitionDuration: const Duration(milliseconds: 100),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  AppBar _AppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        "Create Job",
        style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.bold,
          color: kBlack,
        ),
      ),
    );
  }
}
