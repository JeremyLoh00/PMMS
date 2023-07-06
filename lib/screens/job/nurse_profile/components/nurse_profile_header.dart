import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:private_nurse_for_client/constant.dart';

class NurseProfileHeader extends StatelessWidget {
  NurseProfileHeader({
    Key? key,
    required this.title,
    required this.totalReview,
    required this.phoneNum,
    required this.education,
    required this.location,
    required this.experience,
    required this.time,
  }) : super(key: key);

  final String title;
  final String totalReview;
  final String phoneNum;
  final String education;
  final String location;
  final String experience;
  final String time;
  final double _profileRating = 4.0;
  IconData? _selectedIcon;

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

        //Detail Information
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RatingBarIndicator(
              itemBuilder: (context, index) => Icon(
                _selectedIcon ?? Icons.star,
                color: kPrimaryColor,
              ),
              rating: _profileRating,
              itemCount: 5,
              itemSize: 25.0,
              unratedColor: Color.fromRGBO(4, 99, 128, 0.39),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              totalReview,
              style: TextStyle(
                color: kGrey,
                fontFamily: "Poppins",
                fontSize: 16,
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

        //Nurse Detail Information
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.school_outlined,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Educations",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        education,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        location,
                        style: TextStyle(
                          color: kGrey,
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.work_outline,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Working Experience",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        experience,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          color: kGrey,
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
