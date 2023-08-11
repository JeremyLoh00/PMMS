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
import 'package:private_nurse_for_client/models/list_of_applied_nurse/list_of_applied_nurse_model.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/button_secondary.dart';
import 'package:private_nurse_for_client/public_components/custom_dialog.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/screens/nurse_profile/components/nurse_profile_header.dart';
import 'package:private_nurse_for_client/screens/nurse_profile/components/nurse_profile_review.dart';
import 'package:private_nurse_for_client/screens/nurse_profile/components/nurse_review.dart';
import 'package:private_nurse_for_client/screens/nurse_profile/components/reject_reason.dart';
import 'package:private_nurse_for_client/screens/payment/payment.dart';
import 'package:private_nurse_for_client/screens/subscription/subscription_screen.dart';
import 'package:private_nurse_for_client/theme.dart';

class NurseProfileScreen extends StatefulWidget {

  final UserModel userModel;
  const NurseProfileScreen(
      {super.key,
      required this.userModel,
});

  @override
  State<NurseProfileScreen> createState() => _NurseProfileScreenState();
}

final String commentPic =
    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg";
final int subCode = 200;
bool block = false;

class _NurseProfileScreenState extends State<NurseProfileScreen> {
  bool _isLoadingAccept = false;
  bool _isLoadingReject = false;
  bool _isLoading = false;
  JobModel _jobModel = JobModel();
  JobsBloc jobsBloc = JobsBloc();
  NurseBloc nurseBloc = NurseBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      drawerEnableOpenDragGesture: true,
      appBar: _buildAppBar(),
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
                  child: Hero(
                    tag: "contest-banner",
                    // child: Text("data"),
                    child: Container(
                      child: CachedNetworkImage(
                        imageUrl: widget.userModel.profilePhoto!,
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
                  height: 20,
                ),
                NurseProfileHeader(
                  title: widget.userModel.name!,
                  totalReview:
                      widget.userModel.nurseModel!.averageRating!,
                  phoneNum: widget.userModel.phoneNo!,
                  education:
                      widget.userModel.nurseModel!.educationLevel!,
                  location: widget.userModel.nurseModel!.collegeName!,
                  experience:
                      widget.userModel.nurseModel!.workExperience!,
                  nurseId: widget.userModel.nurseModel!.id!,
                ),
                SizedBox(
                  height: 10,
                ),
                // Divider(
                //   thickness: 0.5,
                //   color: kGrey,
                // ),
                SizedBox(
                  height: 10,
                ),
                // NurseProfileReview(),
                SizedBox(
                  height: 10,
                ),

              ],
            ),
          ),
        ),
      ),
      
    );
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
            onPressed: () => (showBlockNursePopup(context)),
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

}
