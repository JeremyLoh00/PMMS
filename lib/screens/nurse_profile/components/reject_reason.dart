import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/bloc/reject_reason_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/http_response.dart';
import 'package:private_nurse_for_client/models/reject_reason/list_reject_reason_model.dart';
import 'package:private_nurse_for_client/models/reject_reason/reject_reason_list_response_model.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/space.dart';

class RejectReason extends StatefulWidget {
  const RejectReason({super.key});

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
  late Future<ListRejectReasonModel> rejectReasonModel;

  RejectReasonBloc rejectReasonBloc = RejectReasonBloc();
  void initState() {
    rejectReasonModel = getRejectReason();
    super.initState();
  }

  Future<ListRejectReasonModel> getRejectReason() async {
    RejectReasonListResponseModel rejectReasonListResponseModel =
        await rejectReasonBloc.getListRejectReason();
    return rejectReasonListResponseModel.data!;
  }

  String raasonOption = listReason[0];
  TextEditingController comment = TextEditingController();
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
                FutureBuilder<ListRejectReasonModel>(
                    future: rejectReasonModel,
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(
                            snapshot.data!.name!,
                            style: TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                          value: false,
                          onChanged: (value) {
                            setState(() {
                              value = true;
                            });
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                      // return ListView.builder(
                      //   itemCount: snapshot.data,
                      //   shrinkWrap: true,
                      //   itemBuilder: (context, index) {
                      //     return CheckboxListTile(
                      //       controlAffinity: ListTileControlAffinity.leading,
                      //       title: Text(
                      //         listReason[index],
                      //         style: TextStyle(
                      //           fontFamily: "Poppins",
                      //         ),
                      //       ),
                      //       value: false,
                      //       onChanged: (value) {
                      //         setState(() {
                      //           value = true;
                      //         });
                      //       },
                      //     );
                      //     // RadioListTile(
                      //     //   title: Text(listReason[index]),
                      //     //   value: listReason[index],
                      //     //   groupValue: raasonOption,
                      //     //   onChanged: (value) {
                      //     //     setState(() {
                      //     //       raasonOption = value.toString();
                      //     //     });
                      //     //   },
                      //     // );
                      //   },
                      // );
                    }),
                // SizedBox(
                //   height: 10,
                // ),
                // Container(
                //   height: 200,
                //   child: Padding(
                //     padding: const EdgeInsets.only(right: 30.0, left: 10.0),
                //     child: TextFormField(
                //       controller: comment,
                //       keyboardType: TextInputType.multiline,
                //       maxLines: null,
                //       expands: true,
                //       decoration: InputDecoration(
                //         contentPadding:
                //             const EdgeInsets.symmetric(horizontal: 10.0),
                //         enabled: true,
                //         hintText: 'Explain reject reason here....',
                //         labelText: 'Reasons',
                //         border: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             width: 3,
                //             color: Colors.grey,
                //           ),
                //           borderRadius: BorderRadius.circular(10.0),
                //         ),
                //       ),
                //     ),
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
          onPressed: () {},
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
}
