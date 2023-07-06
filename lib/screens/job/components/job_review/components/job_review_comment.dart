import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/store_review_form_bloc.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/screens/job/components/job_review/job_review.dart';

class JobReviewComment extends StatefulWidget {
  StoreReviewFormBloc storeReviewFormBloc;
  JobReviewComment({
    super.key,
    required this.storeReviewFormBloc,
  });

  @override
  State<JobReviewComment> createState() => _JobReviewCommentState();
}

class _JobReviewCommentState extends State<JobReviewComment> {
  TextEditingController comment = TextEditingController();
  late final _ratingController;
  late double _rating;
  final double _commentRating = 1;
  IconData? _selectedIcon;
  bool _isVertical = false;
  double _initialRating = 2.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Your Comment",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
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
                  SizedBox(
                    width: 25,
                  ),
                  RatingBar.builder(
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                    updateOnDrag: true,
                    minRating: 1,
                    itemBuilder: (context, index) => Icon(
                      _selectedIcon ?? Icons.star,
                      color: kPrimaryColor,
                    ),
                    initialRating: _commentRating,
                    itemCount: 5,
                    allowHalfRating: true,
                    itemSize: 20.0,
                    unratedColor: Color.fromRGBO(4, 99, 128, 0.39),
                    direction: _isVertical ? Axis.vertical : Axis.horizontal,
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
                  Expanded(
                    child: TextFormField(
                      controller: comment,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        enabled: true,
                        hintText: 'Give your comment here... ',
                        labelText: 'Comment',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
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
