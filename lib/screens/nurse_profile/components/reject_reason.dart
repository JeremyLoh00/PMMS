import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/bloc/job_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/job/job_response_model.dart';
import 'package:private_nurse_for_client/models/reject_reason/list_reject_reason_model.dart';
import 'package:private_nurse_for_client/models/reject_reason/list_reject_reason_response_model.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/custom_dialog.dart';
import 'package:private_nurse_for_client/public_components/theme_app_bar.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';

class RejectReasonScreen extends StatefulWidget {
  final Function(JobModel) callBackJobModel;
  final JobModel jobModel;

  const RejectReasonScreen({
    super.key,
    required this.callBackJobModel,
    required this.jobModel,
  });
  @override
  _RejectReasonScreenState createState() => _RejectReasonScreenState();
}

class _RejectReasonScreenState extends State<RejectReasonScreen> {
  Map<Map<int, String>, bool> reasons = {};

  List<int> selectedReasonIds = [];

  bool _isLoadingReject = false;
  JobsBloc jobsBloc = JobsBloc();
  bool _isScreenLoading = false;

  @override
  void initState() {
    super.initState();

    getListReason();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar("Reject Reason"),
      body: _isScreenLoading
          ? Center(
              child: ThemeSpinner.spinner(),
            )
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Text(
                    "Select reasons below for candidate rejection, multiple reasons can be selected.",
                    style: TextStyle(
                      color: kGrey,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: reasons.length,
                    itemBuilder: (context, index) {
                      var reasonEntry = reasons.entries.elementAt(index);
                      var reasonMap = reasonEntry.key;
                      var reasonId = reasonMap.keys.first;
                      var reasonText = reasonMap.values.first;
                      return ScaleTap(
                        onPressed: () {
                          setState(() {
                            reasons[reasonMap] = !reasons[reasonMap]!;
                          });

                          print(reasonMap);
                        },
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 10, right: 15, left: 15),
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: kTransparent,
                          ),
                          child: Row(
                            children: [
                              ScaleTap(
                                onPressed: () {
                                  setState(() {
                                    reasons[reasonMap] = !reasons[reasonMap]!;
                                  });

                                  print(reasonMap);
                                },
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    border: Border.all(color: kPrimaryColor),
                                    color: kPrimaryLight,
                                  ),
                                  child: Center(
                                    child: reasons[reasonMap]!
                                        ? Icon(
                                            Icons.check,
                                            size: 16.0,
                                            color: kPrimaryColor,
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(reasonText),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // ButtonSecondary("sd", onPressed: () {
                //   print(convertIntListToStringList(
                //       getIntListFromReasons(reasons)));
                // })
              ],
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ButtonPrimary(
          "Submit",
          onPressed: () {
            CustomDialog.show(
              context,
              isDissmissable: true,
              icon: Icons.warning,
              dialogType: DialogType.success,
              title: "Reject Job",
              description:
                  "Are you sure to really reject this job and submit the reasons?",
              btnCancelText: "Cancel",
              btnCancelOnPress: () {
                Navigator.pop(context);
              },
              btnOkText: "Yes, Reject",
              btnOkOnPress: () async {
                Navigator.pop(context);
                await rejectJob(
                  convertIntListToStringList(
                    getIntListFromReasons(reasons),
                  ),
                );
              },
            );
          },
          isLoading: _isLoadingReject,
          isDisabled: !isAnyCheckboxChecked(),
          loadingText: "Submitting...",
        ),
      ),
    );
  }

  void populateReasonsFromData(List<ListRejectReasonModel> data) {
    for (ListRejectReasonModel item in data) {
      reasons[{item.id!: item.name!}] = false;
    }
  }

  bool isAnyCheckboxChecked() {
    for (bool value in reasons.values) {
      if (value) {
        return true;
      }
    }
    return false;
  }

  List<Map<int, String>> getCheckedReasons() {
    List<Map<int, String>> checkedReasons = [];

    for (var reasonMap in reasons.keys) {
      if (reasons[reasonMap]!) {
        checkedReasons.add(reasonMap);
      }
    }

    return checkedReasons;
  }

  List<int> getIntListFromReasons(Map<Map<int, String>, bool> reasons) {
    List<int> intList = [];

    reasons.forEach((innerMap, isSelected) {
      if (isSelected) {
        int key = innerMap.keys.first;
        intList.add(key);
      }
    });

    return intList;
  }

  List<String> convertIntListToStringList(List<int> intList) {
    List<String> stringList = [];

    for (int intValue in intList) {
      stringList.add(intValue.toString());
    }

    return stringList;
  }

  Future<void> rejectJob(List<String> reasonList) async {
    print(reasonList);
    setState(() {
      _isLoadingReject = true;
    });
    JobResponseModel responseModel =
        await jobsBloc.rejectJob(widget.jobModel.id!, reasonList);

    setState(() {
      _isLoadingReject = false;
    });
    if (responseModel.isSuccess) {
      if (mounted) {
        ThemeSnackBar.showSnackBar(context, responseModel.message);
        Navigator.pop(context);

        widget.callBackJobModel(responseModel.data!);
      }
    } else {
      if (mounted) {
        ThemeSnackBar.showSnackBar(context, responseModel.message);
      }
    }
  }

  Future<void> getListReason() async {
    setState(() {
      _isScreenLoading = true;
    });

    ListRejectReasonResponseModel responseModel =
        await jobsBloc.getListRejectReason();

    setState(() {
      _isScreenLoading = false;
    });

    if (responseModel.isSuccess) {
      setState(() {
        populateReasonsFromData(responseModel.data!);
      });
    } else {
      if (mounted) {
        ThemeSnackBar.showSnackBar(context, responseModel.message);
      }
    }
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_form_bloc/flutter_form_bloc.dart';
// import 'package:private_nurse_for_client/bloc/reject_reason_bloc.dart';
// import 'package:private_nurse_for_client/constant.dart';
// import 'package:private_nurse_for_client/form_bloc/reject_reason_form_bloc.dart';
// import 'package:private_nurse_for_client/helpers/http_response.dart';
// import 'package:private_nurse_for_client/models/default_response_model.dart';
// import 'package:private_nurse_for_client/models/job/job_model.dart';
// import 'package:private_nurse_for_client/models/reject_reason/list_reject_reason_model.dart';
// import 'package:private_nurse_for_client/models/reject_reason/reject_reason_list_response_model.dart';
// import 'package:private_nurse_for_client/public_components/button_primary.dart';
// import 'package:private_nurse_for_client/public_components/space.dart';
// import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';

// class RejectReason extends StatefulWidget {
//   final JobModel jobModel;
//   const RejectReason({super.key, required this.jobModel});

//   @override
//   State<RejectReason> createState() => _RejectReasonState();
// }

// List<String> listReason = [
//   'Inexperienced candidate',
//   'Skills needed not match',
//   'Better candidates exist',
//   'Others',
// ];

// class _RejectReasonState extends State<RejectReason> {
//   late Future<List<ListRejectReasonModel>> rejectReasonModel;

//   RejectReasonBloc rejectReasonBloc = RejectReasonBloc();
//   void initState() {
//     rejectReasonModel = getRejectReason();
//     super.initState();
//   }

//   Future<List<ListRejectReasonModel>> getRejectReason() async {
//     RejectReasonListResponseModel rejectReasonListResponseModel =
//         await rejectReasonBloc.getListRejectReason();
//     return rejectReasonListResponseModel.data!;
//   }

//   String raasonOption = listReason[0];
//   TextEditingController comment = TextEditingController();

//   final List<String> _selectedItems = [];

// // This function is triggered when a checkbox is checked or unchecked
//   void _itemChange(String itemValue, bool isSelected) {
//     setState(() {
//       if (isSelected) {
//         _selectedItems.add(itemValue);
//       } else {
//         _selectedItems.remove(itemValue);
//       }
//     });
//   }

//   bool _isLoading = false;
//   // RejectReasonFormBloc rejectReasonFormBloc = RejectReasonFormBloc();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(context),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.only(left: 30.0, top: 10.0, right: 30),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Select reasons below for candidate rejection, multiple reasons can be selected. ",
//                   style: TextStyle(color: kGrey),
//                 ),
//                 Space(10),
//                 Text(
//                   "Reason : -",
//                   style: TextStyle(
//                       fontFamily: "Poppins", fontWeight: FontWeight.bold),
//                 ),
//                 Space(5),
//                 FutureBuilder<List<ListRejectReasonModel>>(
//                     future: rejectReasonModel,
//                     builder: (context, snapshot) {
//                       if (snapshot.data != null) {
//                         return Padding(
//                           padding: const EdgeInsets.only(top:8.0),
//                           child: ListView.builder(
//                             itemCount: snapshot.data!.length,
//                             shrinkWrap: true,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.only(bottom: 10.0,),
//                                 child: Row(
//                                   children: [
//                                     SizedBox(
//                                       width: 20,
//                                       height: 20,
//                                       child: Checkbox(
//                                         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(5)),
//                                         checkColor: kWhite,
//                                         activeColor: kPrimaryColor,
//                                         // controlAffinity: ListTileControlAffinity.leading,
//                                         // title: Text(
//                                         //   snapshot.data![index].name!,
//                                         //   style: TextStyle(
//                                         //     fontFamily: "Poppins",
//                                         //   ),
//                                         // ),
//                                         value: _selectedItems
//                                             .contains(snapshot.data![index].name!),
//                                         onChanged: (isChecked) => _itemChange(
//                                             snapshot.data![index].name!, isChecked!),
//                                       ),
//                                     ),
//                                     SizedBox(width: 30,),
//                                     Text(
//                                       snapshot.data![index].name!,
//                                       style: TextStyle(
//                                         fontFamily: "Poppins",
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                               // RadioListTile(
//                               //   title: Text(listReason[index]),
//                               //   value: listReason[index],
//                               //   groupValue: raasonOption,
//                               //   onChanged: (value) {
//                               //     setState(() {
//                               //       raasonOption = value.toString();
//                               //     });
//                               //   },
//                               // );
//                             },
//                           ),
//                         );
//                       } else {
//                         return const SizedBox();
//                       }
//                     }),
//                 // CheckboxGroupFieldBlocBuilder<ListRejectReasonModel>(
//                 //   canTapItemTile: true,
//                 //   multiSelectFieldBloc: rejectReasonFormBloc.rejectReason,
//                 //   itemBuilder: (context, item) => FieldItem(
//                 //     alignment: AlignmentDirectional.centerEnd,
//                 //     child: Text(item.name!),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: ButtonPrimary(
//           "Submit",
//           onPressed: () {
//             rejectReason();
//           },
//           rounded: false,
//         ),
//       ),
//     );
//   }

//   AppBar _buildAppBar(BuildContext context) {
//     return AppBar(
//       centerTitle: false,
//       title: Text(
//         "Reject Reason",
//         style: TextStyle(
//           fontFamily: "Poppins",
//           fontWeight: FontWeight.bold,
//           color: kBlack,
//         ),
//       ),
//       elevation: 0,
//       scrolledUnderElevation: 0,
//       backgroundColor: Colors.transparent,
//       leading: IconButton(
//         icon: const Icon(
//           Icons.arrow_back,
//         ),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//     );
//   }

//   Future<void> rejectReason() async {
//     setState(() {
//       _isLoading = true;
//     });
//     DefaultResponseModel responseModel = await rejectReasonBloc.rejectNurse(1);

//     setState(() {
//       _isLoading = false;
//     });
//     if (responseModel.isSuccess) {
//       if (mounted) {
//         ThemeSnackBar.showSnackBar(context, responseModel.message);
//       }
//     } else {
//       if (mounted) {
//         ThemeSnackBar.showSnackBar(context, responseModel.message);
//       }
//     }
//   }
// }
