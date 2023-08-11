import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/bloc/job_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/helpers/http_response.dart';
import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/button_secondary.dart';
import 'package:private_nurse_for_client/public_components/content.dart';
import 'package:private_nurse_for_client/public_components/custom_dialog.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';
import 'package:private_nurse_for_client/screens/job_description/components/body.dart';
import 'package:private_nurse_for_client/screens/nurse_profile/components/reject_reason.dart';
import 'package:private_nurse_for_client/screens/payment/payment.dart';
import 'package:private_nurse_for_client/screens/payment_gateway/payment_gateway_screen.dart';
import 'package:private_nurse_for_client/screens/review/review.dart';

class JobDescription extends StatefulWidget {
  final JobModel jobModel;
  const JobDescription({super.key, required this.jobModel});

  @override
  State<JobDescription> createState() => _JobDescriptionState();
}

class _JobDescriptionState extends State<JobDescription> {
  bool _isLoading = false;
  JobsBloc jobsBloc = JobsBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //Back button on appbar
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: kWhite.withOpacity(0.3), shape: BoxShape.circle),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: kBlack),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Content(
          body: Body(
            jobModel: widget.jobModel,
          ),
          //Bottom button with condition
          footer: widget.jobModel.jobStatusId! ==
                  WAITING_CLIENT_PAYMENT //Waiting payment
              ? Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ButtonSecondary(
                          paddingVertical: 17,
                          onPressed: () {},
                          text: "Cancel",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: ButtonPrimary(
                          "Pay",
                          onPressed: () async {
                            await generateBillPayment(context);
                          },
                          isLoading: _isLoading,
                          loadingText: "Accepting...",
                        ),
                      ),
                    ],
                  ),
                )
              : widget.jobModel.jobStatusId! ==
                      WAITING_CLIENT_REVIEWS //Waiting payment
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ButtonPrimary(
                        "Review",
                        onPressed: () => navigateTo(
                            context,
                            Review(
                              jobModel: widget.jobModel,
                            )),
                        loadingText: "Updating...",
                      ),
                    )
                  : widget.jobModel.jobStatusId! == OPEN
                      ? Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Expanded(
                            flex: 1,
                            child: ButtonSecondary(
                              paddingVertical: 17,
                              onPressed: () {
                                showCancelPopup(context);
                              },
                              text: "Cancel",
                            ),
                          ),
                        )
                      : widget.jobModel.jobStatusId! == WAITING_NURSE_APPROVAL
                          ? Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Expanded(
                                flex: 1,
                                child: ButtonSecondary(
                                  paddingVertical: 17,
                                  onPressed: () {
                                    showCancelPopup(context);
                                  },
                                  text: "Cancel",
                                ),
                              ),
                            )
                          : SizedBox()),
    );
  }

  Future<bool> showCancelPopup(BuildContext context) async {
    FocusScope.of(context).unfocus();
    // Show dialog
    return await CustomDialog.show(
          context,
          title: "Job Cancellation",
          description: "Are you sure to cancel the job?",
          btnCancelText: "Cancel",
          btnOkText: "Confirm",
          btnCancelOnPress: () => Navigator.of(context).pop(),
          btnOkOnPress: () => {cancelJob(), Navigator.of(context).pop(true)},
          icon: Iconsax.info_circle,
          // dialogType: DialogType.warning,
        ) ??
        // If show dialog return null, return false
        false;
  }

  Future<void> cancelJob() async {
    setState(() {
      _isLoading = true;
    });
    DefaultResponseModel responseModel =
        await jobsBloc.cancelJob(widget.jobModel.id!);

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

  Future<void> generateBillPayment(BuildContext context) async {
    CustomDialog.show(context,
        isDissmissable: false,
        title: "Generating Bill Payment...",
        center: ThemeSpinner.spinner());

    DefaultResponseModel responseModel =
        await jobsBloc.generateBillPayment(widget.jobModel.id!);

    Navigator.pop(context);

    if (responseModel.isSuccess) {
      print("code: ${responseModel.data}");
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PaymentGatewayScreen(
                jobModel: widget.jobModel,
                billId: responseModel.data,
              );
            },
          ),
        );
      }
    } else {
      print(responseModel.message);
    }
  }
}
