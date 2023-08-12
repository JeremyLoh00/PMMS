 
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/models/notification/notification_model.dart';
import 'package:private_nurse_for_client/public_components/custom_dialog.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/screens/job_description/job_description_screen.dart';
 

class NotificationContainer extends StatelessWidget {
  final NotificationModel notificationModel;
  const NotificationContainer({
    super.key,
    required this.notificationModel,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onPressed: notificationModel.routeName != null
          ? () async {
              // example routeName jobs/10
              // for check the route name have word "jobs"
              if (notificationModel.routeName!.contains("jobs")) {
                // to get the job id after slash "10"
                List<String> parts = notificationModel.routeName!.split('/');
                if (parts.length > 1) {
                  String jobId = parts[1];

                  navigateTo(
                      context,
                      JobDescriptionScreen(
                        jobId: int.parse(jobId),
                      ));
                } else {
                  CustomDialog.show(
                    context,
                    isDissmissable: true,
                    icon: Icons.warning,
                    dialogType: DialogType.success,
                    title: "URL not found",
                    btnOkText: "OK",
                    btnOkOnPress: () async {
                      Navigator.pop(context);
                    },
                  );
                }
              }
            }
          : () {
              CustomDialog.show(
                context,
                isDissmissable: true,
                icon: Icons.warning,
                dialogType: DialogType.success,
                title: "URL not found",
                btnOkText: "OK",
                btnOkOnPress: () async {
                  Navigator.pop(context);
                },
              );
            },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Container(
                        width: 25,
                        height: 25,
                        padding: const EdgeInsets.all(0.5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          getIcon(notificationModel.icon!),
                          size: 40,
                          color: Color(int.parse(notificationModel.iconColor!)),
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notificationModel.title!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Space(10),
                        Text(
                          notificationModel.body!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Space(10),
                        Text(
                          notificationModel.createdAt!,
                          style: TextStyle(
                              color: kTextGray,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: kPrimary100Color,
            ),
          ],
        ),
      ),
    );
  }

  IconData getIcon(String icon) {
    if (icon == "fas fa-briefcase") {
      return Iconsax.briefcase;
    } else if (icon == "fas fa-play") {
      return Iconsax.play;
    } else if (icon == "fas fa-user-plus") {
      return Iconsax.user_add;
    } else if (icon == "fas fa-star") {
      return Iconsax.star;
    } else if (icon == "fas fa-check-circle") {
      return Iconsax.tick_circle;
    } else if (icon == "fas fa-times-circle") {
      return Iconsax.close_circle;
    } else if (icon == "fas fa-credit-card") {
      return Iconsax.card;
    } else if (icon == "fas fa-info-circle") {
      return Icons.info;
    } else {
      return Icons.error;
    }
  }

  // Color getIconColor(String iconColor) {
  //   if (iconColor == "primary") {
  //     return kPrimaryColor;}
  //    else if (){}
  //    else if (){}
  //    else if (){}
  //    else if (){} else {}
  // }
}
