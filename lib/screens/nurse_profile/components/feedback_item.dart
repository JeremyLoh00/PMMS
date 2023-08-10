import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/models/feedback/feedback_model.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';
import 'package:private_nurse_for_client/screens/view_full_image/view_full_image_screen.dart';

class FeedBackItem extends StatelessWidget {
  final FeedbackModel feedbackModel;
  const FeedBackItem({
    super.key,
    required this.feedbackModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: EdgeInsets.only(top: 10),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(0.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: CachedNetworkImage(
                  imageUrl: feedbackModel.profilePicUserFrom!,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feedbackModel.nameUserFrom!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Space(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            feedbackModel.serviceName!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: kGrey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          "#${feedbackModel.jobId!}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Space(10),
                    RatingBarIndicator(
                      rating: feedbackModel.rating!.toDouble(),
                      itemCount: 5,
                      itemSize: 20.0,
                      unratedColor: kPrimary100Color,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: kPrimaryColor,
                      ),
                    ),
                    Space(5),
                    Text(
                      feedbackModel.comment!,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Space(10),
                    feedbackModel.feedbackPhotoUrl != null
                        ? ScaleTap(
                            onPressed: () {
                              navigateTo(
                                context,
                                ViewFullImageScreen(
                                    imageUrl: feedbackModel.feedbackPhotoUrl!),
                              );
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              padding: const EdgeInsets.all(0.5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: feedbackModel.feedbackPhotoUrl!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
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
                        : Space(0),
                    Space(10),
                    Text(
                      "${feedbackModel.date!} | ${feedbackModel.time}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: kGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Space(10),
          Divider(
            thickness: 0.5,
            color: kGrey,
          ),
        ],
      ),
    );
  }
}
