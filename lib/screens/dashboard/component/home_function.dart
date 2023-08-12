import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';

Widget badgeStatus({required int statusId, required String status
    // required Color bgColor,
    // required Color textColor
    }) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 5,
      vertical: 1,
    ),
    decoration: BoxDecoration(
      color: getBgColorStatus(statusId),
      //  border: Border.all(color: textColor),
      borderRadius: BorderRadius.circular(7),
    ),
    child: Text(
      status,
      style: TextStyle(
        color: getTextColorStatus(statusId),
        fontSize: 11,
      ),
    ),
  );
}

Color getBgColorStatus(int statusId) {
  if (statusId == ONGOING) {
    return kOnGoingBg;
  } else if (statusId == WAITING_CLIENT_REVIEWS) {
    return kReviewBg;
  } else if (statusId == WAITING_NURSE_APPROVAL) {
    return kLightGrey.withOpacity(0.3);
  } else if (statusId == COMPLETED) {
    return kCompletedBg;
  } else if (statusId == CANCELLED) {
    return kBgDanger;
  } else if (statusId == WAITING_CLIENT_PAYMENT) {
    return kNurseApprovalText;
  } else {
    return kBgSuccess;
  }
}

Color getTextColorStatus(int statusId) {
  if (statusId == ONGOING) {
    return kOnGoingText;
  } else if (statusId == WAITING_CLIENT_REVIEWS) {
    return kReviewText;
  } else if (statusId == WAITING_NURSE_APPROVAL) {
    return kNurseApprovalBg;
  } else if (statusId == COMPLETED) {
    return kCompletedText;
  } else if (statusId == CANCELLED) {
    return kTextDanger;
  } else if (statusId == WAITING_CLIENT_PAYMENT) {
    return kNurseApprovalBg;
  } else {
    return kTextSuccess;
  }
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
