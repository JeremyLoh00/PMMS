import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';

class PatientProfileHeader extends StatelessWidget {
  PatientProfileHeader({
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
            Text(
              title,
              style: const TextStyle(
                color: kBlack,
                fontSize: 28.0,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const CircleAvatar(
              radius: 15.0,
              backgroundColor: Color.fromRGBO(255, 227, 246, 1),
              child: Icon(
                Icons.female_outlined,
                color: Color.fromRGBO(212, 81, 168, 1),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),

        //Detail Information
        Row(
          children: [
            Text(
              name,
              style: const TextStyle(
                color: kPrimaryColor,
                fontFamily: "Poppins",
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              sufname,
              style: const TextStyle(
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
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  
}
