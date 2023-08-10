import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:private_nurse_for_client/bloc/reject_reason_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/reject_reason_form_bloc.dart';
import 'package:private_nurse_for_client/helpers/http_response.dart';
import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/reject_reason/list_reject_reason_model.dart';
import 'package:private_nurse_for_client/models/reject_reason/reject_reason_list_response_model.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';

class RejectReason extends StatefulWidget {
  final JobModel jobModel;
  const RejectReason({super.key, required this.jobModel});

  @override
  State<RejectReason> createState() => _RejectReasonState();
}

List<String> listReason = [
  'Inexperienced candidate',
  'Skills needed not match',
  'Better candidates exist',
  'Others',
];

class _RejectReasonState extends State<RejectReason> {
  late Future<List<ListRejectReasonModel>> rejectReasonModel;

  RejectReasonBloc rejectReasonBloc = RejectReasonBloc();
  void initState() {
    rejectReasonModel = getRejectReason();
    super.initState();
  }

  Future<List<ListRejectReasonModel>> getRejectReason() async {
    RejectReasonListResponseModel rejectReasonListResponseModel =
        await rejectReasonBloc.getListRejectReason();
    return rejectReasonListResponseModel.data!;
  }

  String raasonOption = listReason[0];
  TextEditingController comment = TextEditingController();

  final List<String> _selectedItems = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  bool _isLoading = false;
  // RejectReasonFormBloc rejectReasonFormBloc = RejectReasonFormBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 30.0, top: 10.0, right: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select reasons below for candidate rejection, multiple reasons can be selected. ",
                  style: TextStyle(color: kGrey),
                ),
                Space(10),
                Text(
                  "Reason : -",
                  style: TextStyle(
                      fontFamily: "Poppins", fontWeight: FontWeight.bold),
                ),
                Space(5),
                FutureBuilder<List<ListRejectReasonModel>>(
                    future: rejectReasonModel,
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0,),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Checkbox(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5)),
                                        checkColor: kWhite,
                                        activeColor: kPrimaryColor,
                                        // controlAffinity: ListTileControlAffinity.leading,
                                        // title: Text(
                                        //   snapshot.data![index].name!,
                                        //   style: TextStyle(
                                        //     fontFamily: "Poppins",
                                        //   ),
                                        // ),
                                        value: _selectedItems
                                            .contains(snapshot.data![index].name!),
                                        onChanged: (isChecked) => _itemChange(
                                            snapshot.data![index].name!, isChecked!),
                                      ),
                                    ),
                                    SizedBox(width: 30,),
                                    Text(
                                      snapshot.data![index].name!,
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              // RadioListTile(
                              //   title: Text(listReason[index]),
                              //   value: listReason[index],
                              //   groupValue: raasonOption,
                              //   onChanged: (value) {
                              //     setState(() {
                              //       raasonOption = value.toString();
                              //     });
                              //   },
                              // );
                            },
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
                // CheckboxGroupFieldBlocBuilder<ListRejectReasonModel>(
                //   canTapItemTile: true,
                //   multiSelectFieldBloc: rejectReasonFormBloc.rejectReason,
                //   itemBuilder: (context, item) => FieldItem(
                //     alignment: AlignmentDirectional.centerEnd,
                //     child: Text(item.name!),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ButtonPrimary(
          "Submit",
          onPressed: () {
            rejectReason();
          },
          rounded: false,
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Text(
        "Reject Reason",
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

  Future<void> rejectReason() async {
    setState(() {
      _isLoading = true;
    });
    DefaultResponseModel responseModel = await rejectReasonBloc.rejectNurse(1);

    setState(() {
      _isLoading = false;
    });
    if (responseModel.isSuccess) {
      if (mounted) {
        ThemeSnackBar.showSnackBar(context, responseModel.message);
      }
    } else {
      if (mounted) {
        ThemeSnackBar.showSnackBar(context, responseModel.message);
      }
    }
  }
}
