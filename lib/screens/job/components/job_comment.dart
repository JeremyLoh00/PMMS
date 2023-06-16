import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/screens/job/components/job_review/job_review.dart';

class JobComment extends StatefulWidget {
  final bool hasReview;
  final String comment;
  const JobComment({
    super.key,
    required this.hasReview,
    required this.comment,
  });

  @override
  State<JobComment> createState() => _JobCommentState();
}

class _JobCommentState extends State<JobComment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Your Comment",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
            GestureDetector(
              child: Text(
                "Review",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () {
                navigateTo(context, JobReview());
              },
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: widget.hasReview == false
              ? Text(
                  "No Review Yet.",
                  style: TextStyle(
                    color: kGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Rating: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
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
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Comment: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.comment,
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
