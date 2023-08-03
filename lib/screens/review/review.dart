import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/store_review_form_bloc.dart';
import 'package:private_nurse_for_client/models/feedback/feedback_model.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/screens/review/components/file_uploader_edit_profile.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  bool _isLoading = false;
  FeedbackModel feedbackModel = new FeedbackModel();
  XFile? selectedProfilePic;
  TextEditingController comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreReviewFormBloc(),
      child: Builder(builder: (context) {
        final StoreReviewFormBloc storeReviewFormBloc =
            BlocProvider.of<StoreReviewFormBloc>(context);

        return FormBlocListener<StoreReviewFormBloc, String, String>(
          // On submitting
          onSubmitting: (context, state) {
            // Remove focus from input field
            FocusScope.of(context).unfocus();
            // Set loading true
            setState(() {
              _isLoading = true;
            });
          },
          // On Success
          onSuccess: (context, state) {
            // navigator.setPageIndex(0, "Success");

            ThemeSnackBar.showSnackBar(
              context,
              "success",
            );
            // Set loading false
            setState(() {
              _isLoading = false;
            });
            // Navigate to profile screen
            Navigator.of(context).pop();
          },
          //On submission failed
          onSubmissionFailed: (context, state) {
            // Set loading false
            setState(() {
              _isLoading = false;
            });
          },
          onFailure: (context, state) {
            // Set loading to false
            setState(() {
              _isLoading = false;
            });
            ThemeSnackBar.showSnackBar(
              context,
              "Falied",
            );
          },
          child: 
          Scaffold(
            appBar: _buildAppBar(context),
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
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20.0,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: kPrimaryColor,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
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
                      Container(
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(),
                          child: TextFormField(
                            controller: comment,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            expands: true,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              enabled: true,
                              hintText: 'Comments here....',
                              labelText: 'Comments',
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
                      ),
                      Space(10.0),
                      // InputFormalPhoto(
                      //   formBloc: widget.storeReviewFormBloc,
                      //   onImageFormalSelected: (XFile selectedImage) {
                      //     setState(() {
                      //       _selectedFormalImage1 = selectedImage;
                      //       // widget.storeJobFormBloc.newFormalPhoto = selectedImage;
                      //     });
                      //   },
                      // ),
                      Text(
                        "Upload image: ",
                        style: TextStyle(
                            fontFamily: "Poppins", fontWeight: FontWeight.bold),
                      ),
                      Space(10),
                      ImageUploader(
                        heroTag: 'editprofile',
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
              padding: const EdgeInsets.all(30.0),
              child: ButtonPrimary(
                "Submit",
                onPressed: storeReviewFormBloc.submit,
                loadingText: "Updating...",
                isLoading: _isLoading,
                rounded: false,
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
