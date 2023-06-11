import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';

class JobHeader extends StatelessWidget {
  JobHeader({
    Key? key,
    required this.name,
    required this.dateTime,
  }) : super(key: key);

  final String name;
  final String dateTime;

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
                name,
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 24.0,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Green Badge
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 2.0,
                horizontal: 10.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color.fromRGBO(152, 255, 200, 1),
              ),
              height: 20.0,
              alignment: Alignment.center,
              child: const Text(
                "dfdfdf",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kDarkGrey,
                  fontSize: 8.0,
                  fontFamily: "Poppins",
                  // height: 20/8,
                ),
              ),
            )
          ],
        ),

        //Contest due
        Text(
          dateTime,
          style: const TextStyle(
            color: kGrey,
            fontSize: 12.0,
          ),
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
