import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';

class NurseProfileHeader extends StatelessWidget {
  NurseProfileHeader({
    Key? key,
    required this.title,
    required this.name,
    required this.phoneNum,
    required this.sufname,
  }) : super(key: key);

  final String title;
  final String name;
  final String phoneNum;
  final String sufname;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Contest Name
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: kBlack,
                  fontSize: 28.0,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),

        //Detail Information
        Row(
          children: [
            Text(
              name,
              style: TextStyle(
                color: kPrimaryColor,
                fontFamily: "Poppins",
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              sufname,
              style: TextStyle(
                color: kGrey,
                fontFamily: "Poppins",
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Text(
          phoneNum,
          style: const TextStyle(
            color: kGrey,
            fontSize: 12.0,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  // String getDueDate() {
  //   String dueDateText = DateFormat("d MMMM y").format(dueDate);
  //   String duration = TimeDifference.inDays(dueDate);
  //   return "Due $dueDateText. End in $duration";
  // }
}
