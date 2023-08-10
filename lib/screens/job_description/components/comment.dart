import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/screens/dashboard/component/home_function.dart';
import 'package:private_nurse_for_client/screens/job_description/components/schedule_list.dart';
import 'package:private_nurse_for_client/theme.dart';

class Comment extends StatefulWidget {
  final JobModel jobModel;

  Comment({Key? key, required this.jobModel}) : super(key: key);

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
            "Your Comment",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
          widget.jobModel.feedbacks!.length == 0 ?
          Padding(
                padding: const EdgeInsets.all(15),
                child: Text("No comment yet.", style: TextStyle(fontFamily: "Poppins", color: kGrey),),
              ) : SizedBox(),
          //Comment
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.jobModel.feedbacks!.length,
            itemBuilder: (context, index) {
              return Padding(
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
                                  const CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
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
                            Space(7),
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
                              widget.jobModel.feedbacks![index].comment!,
                              style: TextStyle(
                                  color: kDarkGrey, fontFamily: "Poppins"),
                            ),
                            Space(10),
                            //Comment's Image
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: CachedNetworkImage(
                                imageUrl: widget.jobModel.feedbacks![index]
                                    .feedbackPhotoUrl!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
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
                );
            },
          ),
        ],
      ),
    );
  }
}
