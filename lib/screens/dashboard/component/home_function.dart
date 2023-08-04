import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';

Widget badgeStatus(
    {required int statusId,
    required String status
    // required Color bgColor,
    // required Color textColor
    }) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 5,
      vertical: 1,
    ),
    decoration: BoxDecoration(
      color: statusId == ONGOING
          ? kOnGoingBg
          : status == WAITING_CLIENT_REVIEWS
              ? kReviewBg
              : status == WAITING_NURSE_APPROVAL || status == WAITING_CLIENT_PAYMENT
                  ? kNurseApprovalBg
                  : status == COMPLETED
                      ? kCompletedBg
                      : status == CANCELLED
                          ? kBgDanger
                          : kBgSuccess,
      //  border: Border.all(color: textColor),
      borderRadius: BorderRadius.circular(7),
    ),
    child: Text(
      status,
      style: TextStyle(
        color: statusId == ONGOING
            ? kOnGoingText
            : status == WAITING_CLIENT_REVIEWS
                ? kReviewText
                : status == WAITING_NURSE_APPROVAL || status == WAITING_CLIENT_PAYMENT
                    ? kNurseApprovalText
                    : status == COMPLETED
                        ? kCompletedText
                        : status == CANCELLED
                            ? kTextDanger
                            : kTextSuccess,
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
