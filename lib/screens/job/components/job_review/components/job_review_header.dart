import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';

class JobReviewHeader extends StatelessWidget {
  JobReviewHeader({
    Key? key,
    required this.title,
    required this.name,
    required this.phoneNum,
  }) : super(key: key);

  final String title;
  final String name;
  final String phoneNum;

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
                color: Color.fromRGBO(209, 250, 229, 10),
              ),
              height: 20.0,
              alignment: Alignment.center,
              child: const Text(
                "Completed",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(6, 95, 70, 1),
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
          height: 10,
        ),
      ],
    );
  }
}
