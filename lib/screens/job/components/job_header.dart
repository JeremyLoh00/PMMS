import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';

class JobHeader extends StatelessWidget {
  JobHeader({
    Key? key,
    required this.title,
    required this.name,
    required this.phoneNum,
    required this.location,
    required this.date,
    required this.time,
  }) : super(key: key);

  final String title;
  final String name;
  final String phoneNum;
  final String location;
  final String date;
  final String time;

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

            // Badge
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 2.0,
                horizontal: 10.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color.fromARGB(255, 255, 152, 152),
              ),
              height: 20.0,
              alignment: Alignment.center,
              child: const Text(
                "Cancelled",
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
        SizedBox(
          height: 10,
        ),

        //Detail Information
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
          phoneNum,
          style: const TextStyle(
            color: kGrey,
            fontSize: 12.0,
          ),
        ),
        SizedBox(
          height: 20,
        ),

        //Job Detail Information
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.location_on,
              color: kPrimaryColor,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              location,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              color: kPrimaryColor,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              date,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Icon(
              Icons.access_time,
              color: kPrimaryColor,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              time,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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
