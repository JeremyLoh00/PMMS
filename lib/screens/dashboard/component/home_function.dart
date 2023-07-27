import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';

Widget badgeStatus(
    {required String status,
    required Color bgColor,
    required Color textColor}) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 5,
      vertical: 1,
    ),
    decoration: BoxDecoration(
      color: status == "Ongoing" ? kOnGoingBg : status == "Waiting Client Reviews" ? kReviewBg : kBgColor,
      
      // bgColor,
      //  border: Border.all(color: textColor),
      borderRadius: BorderRadius.circular(7),
    ),
    child: Text(
      status,
      style: TextStyle(
        color: status == "Ongoing" ? kOnGoingText : status == "Awaiting Client Reviews" ? kReviewText : textColor,
        fontSize: 11,
      ),
    ),
  );
}

String getDate(String date) {
  // date need three words
  //int currentYear = DateTime.now().year;
  List<String> dateParts = date.split(" ");

  return "${dateParts[0]} ${dateParts[1]}";
}

String getTime(String time) {
  List<String> dateParts = time.split(" ");

  return dateParts[2];
}
