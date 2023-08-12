import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/bloc/nurse_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/nurse/nurse_model.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/public_components/custom_dialog.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';
import 'package:private_nurse_for_client/theme.dart';

class NurseBlockedItem extends StatefulWidget {
  final UserModel userModel;
  final Function() callbackRefresh;
  const NurseBlockedItem({
    Key? key,
    required this.userModel,
    required this.callbackRefresh,
  }) : super(key: key);

  @override
  State<NurseBlockedItem> createState() => _NurseBlockedItemState();
}

class _NurseBlockedItemState extends State<NurseBlockedItem> {
  bool _isLoading = false;
  NurseBloc nurseBloc = NurseBloc();
  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            profileShadow(
              kGrey.withOpacity(0.2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CachedNetworkImage(
                    imageUrl: widget.userModel.profilePhoto == null
                        ? ""
                        : widget.userModel.profilePhoto!,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => ThemeSpinner.spinner(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ],
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Space(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.monetization_on_outlined,
                                size: 16,
                                color: kPrimaryColor,
                              ),
                            ),
                            TextSpan(
                                text: widget.userModel.nurseModel!.points!
                                    .toString(),
                                //recognizer: onTapRecognizer,
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w500,
                                )),
                            TextSpan(
                                text: " points",
                                //recognizer: onTapRecognizer,
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 11,
                                ))
                          ]),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.userModel.name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.userModel.phoneNo!,
                    style: TextStyle(color: kSecondaryColor, fontSize: 10),
                  ),
                  Text(
                    widget.userModel.nurseModel!.workExperience!,
                    style: TextStyle(fontSize: 10, color: kLightGrey),
                    textAlign: TextAlign.justify,
                  ),
                  Space(5),
                  Row(
                    children: [
                      Expanded(
                        child: RatingBarIndicator(
                          rating: double.parse(
                              widget.userModel.nurseModel!.averageRating!),
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: kPrimaryColor,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                      ),
                      ScaleTap(
                        onPressed: () {
                          showUnblockNursePopup(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              profileShadow(
                                kPrimaryColor.withOpacity(0.3),
                              ),
                            ],
                          ),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.block_flipped,
                                    size: 16,
                                    color: kWhite,
                                  ),
                                ),
                                TextSpan(
                                  text: " Unblock",
                                  //recognizer: onTapRecognizer,
                                  style: TextStyle(
                                    color: kWhite,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Space(5),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.userModel.nurseModel!.totalFeedback!
                              .toString(),
                          //recognizer: onTapRecognizer,
                          style: const TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const TextSpan(
                          text: " Reviews",
                          //recognizer: onTapRecognizer,
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  Space(5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Popup if user want to unblock nurse
  Future<bool> showUnblockNursePopup(BuildContext context) async {
    // If cant pop then show this dialog
    // Unfocus from input field
    FocusScope.of(context).unfocus();
    // Show dialog
    return await CustomDialog.show(
          context,
          title: "Unblock Nurse",
          description: "Are you sure to unblock the nurse?",
          btnCancelText: "Cancel",
          btnOkText: "Unblock",
          btnCancelOnPress: () => Navigator.of(context).pop(),
          btnOkOnPress: () {
            Navigator.pop(context);
            unBlockNurse();
          },
          icon: Iconsax.info_circle,
          // dialogType: DialogType.warning,
        ) ??
        // If show dialog return null, return false
        false;
  }

  Future<void> unBlockNurse() async {
    CustomDialog.show(
      context,
      isDissmissable: false,
      title: "Unblocking Nurse",
      center: ThemeSpinner.spinner(),
    );
    DefaultResponseModel responseModel =
        await nurseBloc.blockNurse(widget.userModel.nurseModel!.id!);

    Navigator.pop(context);
    if (responseModel.isSuccess) {
      if (mounted) {
        ThemeSnackBar.showSnackBar(context, responseModel.message);

        widget.callbackRefresh();
      }
    } else {
      if (mounted) {
        ThemeSnackBar.showSnackBar(context, responseModel.message);
      }
    }
  }
}
