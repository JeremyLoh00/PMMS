import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/screens/profile/profile_screen.dart';

class NurseProfileReview extends StatefulWidget {
  const NurseProfileReview({
    Key? key,
    required this.description,
    required this.src,
    required this.name,
    required this.comment,
    required this.commentPic,
    required this.date,
  }) : super(key: key);

  final String description;
  final String src;
  final String commentPic;
  final String name;
  final String comment;
  final String date;

  @override
  State<NurseProfileReview> createState() => _NurseProfileReviewState();
}

class _NurseProfileReviewState extends State<NurseProfileReview> {
  final int charactersLimit = 150;
  late String initialText;
  late String extendedText;

  List<String> text1 = [
    'Diabetics',
    'Hypertension',
    'Skin Problem',
  ];

  List<String> text2 = [
    'Bed Bound',
    'Not Cooperative',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Text(
            "Reviews",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 10,
            ),
            ScaleTap(
              onPressed: () {
                navigateTo(context, ProfileScreen());
              },
              child: Padding(
                padding: EdgeInsets.only(right: 15),
                child: Container(
                  width: 35,
                  height: 35,
                  padding: const EdgeInsets.all(0.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.src,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w800),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 30,
                      width: 63,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Icon(
                            Icons.star,
                            color: kPrimaryColor,
                            size: 16,
                          );
                        },
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: Color.fromRGBO(148, 0, 0, 0.411),
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 60.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.comment,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Hero(
                  tag: "contest-banner",
                  // child: Text("data"),
                  child: Container(
                    child: CachedNetworkImage(
                      imageUrl: widget.commentPic,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.date,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                  color: kGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
