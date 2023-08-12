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
import 'package:private_nurse_for_client/models/job/job_response_model.dart';
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
import 'package:private_nurse_for_client/screens/review/review_screen.dart';

class JobDescription extends StatefulWidget {
  final JobModel? jobModel;
  final int? jobId;
  const JobDescription({super.key, this.jobModel, this.jobId});

  @override
  State<JobDescription> createState() => _JobDescriptionState();
}

class _JobDescriptionState extends State<JobDescription> {
  bool _isLoading = false;
  bool _isLoadingCancel = false;
  JobsBloc jobsBloc = JobsBloc();
  Future<JobModel> futureData = Future.value(JobModel());

  @override
  void initState() {
    super.initState();
    getJobData();
  }

  void callBackGetJobModelData() {
    getJobData();
  }

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
      body: FutureBuilder<JobModel?>(
          future: futureData,
          builder: (context, builder) {
            if (builder.hasData && builder.data!.id != null) {
              JobModel jobModel = builder.data!;
              return BodyContent(
                body: Body(
                  callbackData: callBackGetJobModelData,
                  callbackJobModel: (data) {
                    setState(() {
                      futureData = Future.value(data);
                    });
                  },
                  jobModel: jobModel,
                ),
                //Bottom button with condition
                footer: getBottomButton(jobModel),
              );
            }

            return Center(
              child: ThemeSpinner.spinner(),
            );
          }),
    );
  }

  Future<void> getJobData() async {
    if (widget.jobModel == null) {
      JobsBloc jobsBloc = JobsBloc();

      JobResponseModel responseModel =
          await jobsBloc.showJob(widget.jobId.toString());

      if (responseModel.isSuccess) {
        setState(() {
          futureData = Future.value(responseModel.data);
        });
      }
    } else {
      setState(() {
        futureData = Future.value(widget.jobModel);
      });

      // load data balik bile dah tekan button > back > masuk balik

      JobsBloc jobsBloc = JobsBloc();

      JobResponseModel responseModel =
          await jobsBloc.showJob(widget.jobModel!.id!.toString());

      if (responseModel.isSuccess) {
        setState(() {
          futureData = Future.value(responseModel.data);
        });
      }
    }
  }

  Widget getBottomButton(JobModel jobModel) {
    if (jobModel.jobStatusId! == WAITING_CLIENT_PAYMENT) {
      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ButtonSecondary(
                "Cancel Job",
                onPressed: () {
                  showCancelPopup(context, jobModel);
                },
                isLoading: _isLoadingCancel,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: ButtonPrimary(
                "Pay For This Job",
                onPressed: () async {
                  await generateBillPayment(context, jobModel);
                },
                isLoading: _isLoading,
                loadingText: "Accepting...",
              ),
            ),
          ],
        ),
      );
    } else if (jobModel.jobStatusId! == WAITING_CLIENT_REVIEWS) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: ButtonPrimary(
          "Review",
          onPressed: () => navigateTo(
            context,
            ReviewScreen(
              jobModel: widget.jobModel!,
              callbackGetJobModelData: callBackGetJobModelData,
            ),
          ),
          loadingText: "Updating...",
        ),
      );
    } else if (jobModel.jobStatusId! == OPEN ||
        jobModel.jobStatusId! == WAITING_NURSE_APPROVAL) {
      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: ButtonPrimary(
          "Cancel Job",
          isLoading: _isLoadingCancel,
          onPressed: () {
            showCancelPopup(context, jobModel);
          },
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Future<bool> showCancelPopup(BuildContext context, JobModel jobModel) async {
    FocusScope.of(context).unfocus();
    // Show dialog
    return await CustomDialog.show(
          context,
          title: "Job Cancellation",
          description: "Are you sure to cancel the job?",
          btnCancelText: "Cancel",
          btnOkText: "Confirm",
          btnCancelOnPress: () => Navigator.of(context).pop(),
          btnOkOnPress: () async {
            Navigator.pop(context);
            await cancelJob(jobModel);
          },
          icon: Iconsax.info_circle,
          // dialogType: DialogType.warning,
        ) ??
        // If show dialog return null, return false
        false;
  }

  Future<void> cancelJob(JobModel jobModel) async {
    setState(() {
      _isLoadingCancel = true;
    });
    JobResponseModel responseModel = await jobsBloc.cancelJob(jobModel.id!);

    setState(() {
      _isLoadingCancel = false;
    });
    if (responseModel.isSuccess) {
      if (mounted) {
        ThemeSnackBar.showSnackBar(context, responseModel.message);
        setState(() {
          futureData = Future.value(responseModel.data);
        });
      }
    } else {
      if (mounted) {
        ThemeSnackBar.showSnackBar(context, responseModel.message);
      }
    }
  }

  Future<void> generateBillPayment(
      BuildContext context, JobModel jobModel) async {
    CustomDialog.show(context,
        isDissmissable: false,
        title: "Generating Bill Payment...",
        center: ThemeSpinner.spinner());

    DefaultResponseModel responseModel =
        await jobsBloc.generateBillPayment(jobModel.id!);

    Navigator.pop(context);

    if (responseModel.isSuccess) {
      print("code: ${responseModel.data}");
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PaymentGatewayScreen(
                jobModel: widget.jobModel!,
                billId: responseModel.data,
                callbackGetJobData: getJobData,
              );
            },
          ),
        );
      }
      // setState(() {
      //   futureData = Future.value(responseModel.data);
      // });
    } else {
      print(responseModel.message);
      ThemeSnackBar.showSnackBar(context, responseModel.message);
    }
  }
}
