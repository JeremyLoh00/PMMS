import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/content.dart';
import 'package:private_nurse_for_client/public_components/theme_app_bar.dart';
import 'package:private_nurse_for_client/screens/job_description/components/body.dart';

class JobDescription extends StatefulWidget {
  const JobDescription({super.key});

  @override
  State<JobDescription> createState() => _JobDescriptionState();
}

class _JobDescriptionState extends State<JobDescription> {
  String src = "https://c4.wallpaperflare.com/wallpaper/246/739/689/digital-digital-art-artwork-illustration-abstract-hd-wallpaper-preview.jpg";
  String title = "Physiotherapy";
  double price = 10.0;
  String status = "On-going";
  String name = "Mr. John Doe";
  String phoneNum = "012-3456789";
  String city = "Pekan, Pahang";
  String address = "1, Jalan XXX, Taman YYY";
  String startDate = "12 Jul 2023, Wed";
  String startTime = "8.00 - 13.00";
  String endDate = "13 Jul 2023, Thu";
  String endTime = "9.00 - 14.00";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(
        "Job Description",
      ),
      body: Content(
        body: Body(
            title: title,
            price: price,
            src: src,
            status: status,
            name: name,
            phoneNum: phoneNum,
            city: city,
            address: address,
            startDate: startDate,
            startTime: startTime,
            endDate: endDate,
            endTime: endTime),
            
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
