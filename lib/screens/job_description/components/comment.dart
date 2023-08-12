import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';
import 'package:private_nurse_for_client/screens/dashboard/component/home_function.dart';
import 'package:private_nurse_for_client/screens/job_description/components/schedule_list.dart';
import 'package:private_nurse_for_client/screens/view_full_image/view_full_image_screen.dart';
import 'package:private_nurse_for_client/theme.dart';

class Comment extends StatefulWidget {
  final JobModel jobModel;

  const Comment({Key? key, required this.jobModel}) : super(key: key);

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  IconData? _selectedIcon;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Feedbacks",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
          widget.jobModel.feedbacks!.length == 0
              ? Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "No feedbacks yet.",
                    style: TextStyle(fontFamily: "Poppins", color: kGrey),
                  ),
                )
              : SizedBox(),
          //Comment
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.jobModel.feedbacks!.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // image
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: CachedNetworkImage(
                                imageUrl: widget.jobModel.feedbacks![index]
                                    .profilePicUserFrom!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    ThemeSpinner.spinnerInput(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.jobModel.feedbacks![index].nameUserFrom!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Space(5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RatingBarIndicator(
                                    itemBuilder: (context, index) => Icon(
                                      _selectedIcon ?? Icons.star,
                                      color: kPrimaryColor,
                                    ),
                                    rating: double.parse(widget
                                        .jobModel.feedbacks![index].rating!
                                        .toString()),
                                    itemCount: 5,
                                    itemSize: 15.0,
                                    unratedColor:
                                        Color.fromRGBO(4, 99, 128, 0.39),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.jobModel.feedbacks![index].rating!
                                        .toString(),
                                    style: TextStyle(
                                      color: kGrey,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Space(5),
                              //Comment
                              Text(
                                widget.jobModel.feedbacks![index].comment ??
                                    "No Comment",
                                style: TextStyle(
                                    color: kDarkGrey, fontFamily: "Poppins"),
                              ),
                              Space(10),
                              //Comment's Image

                              widget.jobModel.feedbacks![index]
                                          .feedbackPhotoUrl !=
                                      null
                                  ? ScaleTap(
                                      onPressed: () {
                                        navigateTo(
                                          context,
                                          ViewFullImageScreen(
                                            imageUrl: widget
                                                .jobModel
                                                .feedbacks![index]
                                                .feedbackPhotoUrl!,
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        width: 80,
                                        height: 80,
                                        child: CachedNetworkImage(
                                          imageUrl: widget
                                              .jobModel
                                              .feedbacks![index]
                                              .feedbackPhotoUrl!,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              ThemeSpinner.spinnerInput(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              Space(10),
                              //Date and time of comment
                              Row(
                                children: [
                                  Text(
                                    widget.jobModel.feedbacks![index].date!,
                                    style: TextStyle(
                                      color: kGrey,
                                      fontFamily: "Poppins",
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    " | ",
                                    style: TextStyle(
                                      color: kGrey,
                                      fontFamily: "Poppins",
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    widget.jobModel.feedbacks![index].time!,
                                    style: TextStyle(
                                      color: kGrey,
                                      fontFamily: "Poppins",
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Space(10),
                  Divider(
                    thickness: 0.5,
                    color: kGrey,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
