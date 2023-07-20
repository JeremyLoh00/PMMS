import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/store_review_form_bloc.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/screens/job/components/job_review/components/job_review_comment.dart';
import 'package:private_nurse_for_client/screens/job/components/job_review/components/job_review_header.dart';
import 'package:private_nurse_for_client/screens/job/components/job_review/components/job_review_nurse_application.dart';
import 'package:private_nurse_for_client/screens/job/job_detail.dart';

class JobReview extends StatefulWidget {
  const JobReview({super.key});

  @override
  State<JobReview> createState() => _JobReviewState();
}

class _JobReviewState extends State<JobReview> {
  String src =
      "https://c1.wallpaperflare.com/preview/547/839/590/accident-bleed-bleeding-bleeding-finger.jpg";

  @override
  Widget build(BuildContext context) {
    // final MyNavigator navigator = context.watch<MyNavigator>();
    return BlocProvider(
      create: (context) => StoreReviewFormBloc(),
      child: Builder(
        builder: (context) {
          final storeReviewFormBloc =
              BlocProvider.of<StoreReviewFormBloc>(context);

          return FormBlocListener<StoreReviewFormBloc, String, String>(
            // On submitting
            onSubmitting: ((context, state) {
              FocusScope.of(context).unfocus();
              CircularProgressIndicator();
            }),
            // On Success
            onSuccess: (context, state) {
              // navigator.setPageIndex(0, "Success");

              ThemeSnackBar.showSnackBar(
                context,
                "success",
              );
            },
            //On submission failed
            onSubmissionFailed: (context, state) {},
            // padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 70),
            // constraints: BoxConstraints(
            //   minHeight: _scrHeight,
            // ),
            child: Scaffold(
              backgroundColor: kWhite,
              appBar: _buildAppBar(),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: CustomScrollView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: double.infinity,
                              child: Hero(
                                tag: "contest-banner",
                                // child: Text("data"),
                                child: Container(
                                  child: CachedNetworkImage(
                                    imageUrl: src,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
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
                            const SizedBox(height: 15.0),
                            JobReviewHeader(
                              title: "Wound Dressing",
                              name: "Mr. John Doe",
                              phoneNum: "012-3456789",
                            ),

                            const SizedBox(height: 15.0),
                            //Nurse Application List
                            JobReviewNurseApplication(
                              src: src,
                            ),
                            const SizedBox(height: 15.0),
                            Divider(
                              color: kGrey,
                              thickness: 0.5,
                            ),
                            const SizedBox(height: 15.0),
                            //User Review
                            JobReviewComment(
                              storeReviewFormBloc: storeReviewFormBloc,
                            ),
                            const SizedBox(height: 15.0),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ElevatedButton(
                                  child: Text("Submit".toUpperCase(),
                                      style: TextStyle(fontSize: 14)),
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            kPrimaryColor),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: BorderSide(color: kPrimaryColor),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    navigateTo(
                                      context,
                                      JobDetail(
                                        hasComment: true,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
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
  }
}
