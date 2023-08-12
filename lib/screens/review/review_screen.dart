import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/store_review_form_bloc.dart';
import 'package:private_nurse_for_client/models/feedback/feedback_model.dart';
import 'package:private_nurse_for_client/models/feedback/feedback_response_model.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/job/job_response_model.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/input_decoration%20copy.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_app_bar.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/screens/review/components/file_uploader_edit_profile.dart';

class ReviewScreen extends StatefulWidget {
  final JobModel jobModel;
  final Function() callbackGetJobModelData;
  const ReviewScreen(
      {super.key,
      required this.jobModel,
      required this.callbackGetJobModelData});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  bool _isLoading = false;
  FeedbackModel feedbackModel = FeedbackModel();
  XFile? selectedProfilePic;
  int delayAnimationDuration = 200;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreReviewFormBloc(widget.jobModel),
      child: Builder(builder: (context) {
        final StoreReviewFormBloc storeReviewFormBloc =
            BlocProvider.of<StoreReviewFormBloc>(
          context,
        );

        return FormBlocListener<StoreReviewFormBloc, JobModel,
            JobResponseModel>(
          // On submitting
          onSubmitting: (context, state) {
            // Remove focus from input field
            print("Submitting");
            FocusScope.of(context).unfocus();
            // Set loading true
            setState(() {
              _isLoading = true;
            });
          },
          // On Success
          onSuccess: (context, state) {
            // navigator.setPageIndex(0, "Success");
            print("Submitted");
            ThemeSnackBar.showSnackBar(
              context,
              "Success",
            );
            // Set loading false
            setState(() {
              _isLoading = false;
            });
            // Navigate to profile screen
            Navigator.of(context).pop();
            widget.callbackGetJobModelData();
          },
          //On submission failed
          onSubmissionFailed: (context, state) {
            print("Submit failed");
            // Set loading false
            setState(() {
              _isLoading = false;
            });
          },
          onFailure: (context, state) {
            // Set loading to false
            print("Failed");
            setState(() {
              _isLoading = false;
            });
            ThemeSnackBar.showSnackBar(
              context,
              "Falied",
            );
          },
          child: Scaffold(
            appBar: ThemeAppBar("Comment and Review"),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Give Your Comments",
                        style: TextStyle(
                            fontFamily: "Poppins", fontWeight: FontWeight.bold),
                      ),
                      Space(5),
                      Text(
                        "Give rating and comment for this job based on the nurse’s performance",
                        style: TextStyle(color: kGrey),
                      ),
                      Space(10),
                      Row(
                        children: [
                          Text(
                            "Rating: ",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold),
                          ),
                          RatingBar.builder(
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemSize: 20.0,
                            glowRadius: 1,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: kPrimaryColor,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                print(rating);
                                storeReviewFormBloc.newRating
                                    .updateValue(rating.toString());
                              });
                            },
                          )
                        ],
                      ),
                      Space(10),
                      Text(
                        "Comments: ",
                        style: TextStyle(
                            fontFamily: "Poppins", fontWeight: FontWeight.bold),
                      ),
                      Space(5),
                      DelayedDisplay(
                        delay: Duration(milliseconds: delayAnimationDuration),
                        child: TextFieldBlocBuilder(
                          textFieldBloc: storeReviewFormBloc.newComment,
                          cursorColor: kPrimaryColor,
                          maxLines: 5,
                          decoration: textFieldInputDecoration(
                            "",
                          ),
                        ),
                      ),
                      Space(10.0),
                      Text(
                        "Upload image: ",
                        style: TextStyle(
                            fontFamily: "Poppins", fontWeight: FontWeight.bold),
                      ),
                      Space(10),
                      ImageUploader(
                        heroTag: 'commentpicture',
                        feedbackModel: feedbackModel,
                        formBloc: storeReviewFormBloc,
                        onImageSelected: (XFile selectedImage) {
                          setState(() {
                            selectedProfilePic = selectedImage;
                            storeReviewFormBloc.newFormalPhoto1 = selectedImage;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ButtonPrimary(
                "Submit",
                onPressed: storeReviewFormBloc.newRating.value == ""
                    ? () {
                        ThemeSnackBar.showSnackBar(
                            context, "Please give at least 1 star");
                      }
                    : () {
                        storeReviewFormBloc.submit();
                      },
                loadingText: "Submitting...",
                isLoading: _isLoading,
              ),
            ),
          ),
        );
      }),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Text(
        "Comment",
        style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.bold,
          color: kBlack,
        ),
      ),
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
