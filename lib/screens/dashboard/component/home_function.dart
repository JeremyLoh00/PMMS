import 'package:flutter/material.dart';

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
      color: bgColor,
      //  border: Border.all(color: textColor),
      borderRadius: BorderRadius.circular(7),
    ),
    child: Text(
      status,
      style: TextStyle(
        color: textColor,
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
