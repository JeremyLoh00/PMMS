import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/bloc/job_bloc.dart';
import 'package:private_nurse_for_client/bloc/nurse_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/helpers/http_response.dart';
import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/button_secondary.dart';
import 'package:private_nurse_for_client/public_components/custom_dialog.dart';
import 'package:private_nurse_for_client/public_components/theme_app_bar.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';
import 'package:private_nurse_for_client/screens/nurse_profile/components/nurse_profile_header.dart';
import 'package:private_nurse_for_client/screens/nurse_profile/components/nurse_profile_review.dart';
import 'package:private_nurse_for_client/screens/nurse_profile/components/nurse_review.dart';
import 'package:private_nurse_for_client/screens/nurse_profile/components/reject_reason.dart';
import 'package:private_nurse_for_client/screens/payment/payment.dart';
import 'package:private_nurse_for_client/screens/subscription/subscription_screen.dart';
import 'package:private_nurse_for_client/theme.dart';

class NurseProfile extends StatefulWidget {
  final UserModel listOfAppliedNurseModel;
  final Function() callbackData;
  final Function(JobModel) callbackJobModel;
  final JobModel jobModel;
  const NurseProfile(
      {super.key,
      required this.listOfAppliedNurseModel,
      required this.jobModel,
      required this.callbackData,
      required this.callbackJobModel});

  @override
  State<NurseProfile> createState() => _NurseProfileState();
}

bool block = false;
String rejectLoadingText = "";

class _NurseProfileState extends State<NurseProfile> {
  bool _isLoadingAccept = false;
  bool _isLoadingReject = false;
  bool _isLoading = false;
  JobModel _jobModel = JobModel();
  JobsBloc jobsBloc = JobsBloc();
  NurseBloc nurseBloc = NurseBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _jobModel = widget.jobModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      drawerEnableOpenDragGesture: true,
      appBar: ThemeAppBar("Nurse Profile"),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: widget.listOfAppliedNurseModel.profilePhoto!,
                    errorWidget: (context, url, error) {
                      return Icon(Icons.error);
                    },
                    placeholder: (context, url) {
                      return ThemeSpinner.spinner();
                    },
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                NurseProfileHeader(
                  title: widget.listOfAppliedNurseModel.name!,
                  totalReview:
                      widget.listOfAppliedNurseModel.nurseModel!.averageRating!,
                  phoneNum: widget.listOfAppliedNurseModel.phoneNo!,
                  education: widget
                      .listOfAppliedNurseModel.nurseModel!.educationLevel!,
                  location:
                      widget.listOfAppliedNurseModel.nurseModel!.collegeName!,
                  experience: widget
                      .listOfAppliedNurseModel.nurseModel!.workExperience!,
                  nurseId: widget.listOfAppliedNurseModel.nurseModel!.id!,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: getBottomNavigation(
          widget.jobModel.jobStatusId!,
          widget.listOfAppliedNurseModel.nurseModel!.applyJobStatusId!,
          widget.listOfAppliedNurseModel.nurseModel!.id!),
    );
  }

  Widget getBottomNavigation(int jobStatusId, int nurseStatus, int nurseId) {
    if (jobStatusId == OPEN) {
      if (nurseStatus == NurseJobStatus.WAITING_FOR_APPROVAL) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ButtonSecondary(
                  "Reject",
                  loadingText: rejectLoadingText,
                  isLoading: _isLoading,
                  onPressed: () {
                    navigateTo(
                      context,
                      RejectReasonScreen(
                        jobModel: widget.jobModel,
                        callBackJobModel: widget.callbackJobModel,
                        nurseModel: widget.listOfAppliedNurseModel.nurseModel!,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: ButtonPrimary(
                  "Hire Me",
                  onPressed: () async {
                    CustomDialog.show(
                      context,
                      title: "Hire Confirmation",
                      description:
                          "Are you sure to hire this nurse for this job? This action cannot be undone",
                      btnCancelText: "Cancel",
                      btnOkText: "Hire",
                      btnCancelOnPress: () => Navigator.of(context).pop(),
                      btnOkOnPress: () async {
                        Navigator.pop(context);
                        await hireNurse(
                            widget.listOfAppliedNurseModel.nurseModel!.id!);
                      },
                      icon: Iconsax.info_circle,
                      dialogType: DialogType.warning,
                    );
                  },
                  isLoading: _isLoading,
                  loadingText: "Accepting...",
                ),
              ),
            ],
          ),
        );
      } else {
        return SizedBox();
      }
    } else {
      return SizedBox();
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Nurse Profile",
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              color: kBlack,
            ),
          ),
          ScaleTap(
            onPressed: () => showBlockNursePopup(context),
            child: Text(
              "Block Nurse",
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: kDanger,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  } // Popup if user want to hire nurse

  Future<void> hireNurse(int nurseId) async {
    setState(() {
      _isLoading = true;
    });
    DefaultResponseModel responseModel =
        await jobsBloc.acceptNurse(widget.jobModel.id!, nurseId);

    setState(() {
      _isLoading = false;
    });
    if (responseModel.isSuccess) {
      if (mounted) {
        print(responseModel.message);
        ThemeSnackBar.showSnackBar(context, responseModel.message);
        Navigator.pop(context);
        widget.callbackData();
      }
    } else {
      if (responseModel.statusCode == HttpResponse.HTTP_PAYMENT_REQUIRED) {
        if (mounted) {
          CustomDialog.show(
            context,
            isDissmissable: true,
            icon: Icons.warning,
            dialogType: DialogType.success,
            title: responseModel.message,
            description:
                "Subscription is not complete yet, please subscribe before accepting any nurse.",
            btnCancelText: "Cancel",
            btnCancelOnPress: () {
              Navigator.pop(context);
            },
            btnOkText: "View Plan",
            btnOkOnPress: () async {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SubscriptionScreen(fromCustomerDialog: 1);
                  },
                ),
              );
            },
          );
        }
      } else {
        if (mounted) {
          ThemeSnackBar.showSnackBar(context, responseModel.message);
        }
      }
    }
  }

  // Popup if user want to block nurse
  Future<bool> showBlockNursePopup(BuildContext context) async {
    // If cant pop then show this dialog
    // Unfocus from input field
    FocusScope.of(context).unfocus();
    // Show dialog
    return await CustomDialog.show(
          context,
          title: "Block Nurse",
          description:
              "Are you sure to block this nurse? You can unblock the nurse at the “Blocked Nurse” list. ",
          btnCancelText: "Cancel",
          btnOkText: "Block",
          btnCancelOnPress: () => Navigator.of(context).pop(),
          btnOkOnPress: () {
            blockNurse();
            Navigator.of(context).pop(true);
          },
          icon: Iconsax.info_circle,
          // dialogType: DialogType.warning,
        ) ??
        // If show dialog return null, return false
        false;
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
            Navigator.of(context).pop();
          },
          icon: Iconsax.info_circle,
          // dialogType: DialogType.warning,
        ) ??
        // If show dialog return null, return false
        false;
  }

  Future<void> blockNurse() async {
    setState(() {
      _isLoading = true;
    });
    DefaultResponseModel responseModel = await nurseBloc
        .blockNurse(widget.listOfAppliedNurseModel.nurseModel!.id!);

    setState(() {
      _isLoading = false;
    });
    if (responseModel.isSuccess) {
      if (mounted) {
        ThemeSnackBar.showSnackBar(context, responseModel.message);
        Navigator.of(context).pop();
      }
    } else {
      if (mounted) {
        ThemeSnackBar.showSnackBar(context, responseModel.message);
      }
    }
  }
}
