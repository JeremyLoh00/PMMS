import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/screens/dashboard/component/home_function.dart';
import 'package:private_nurse_for_client/screens/nurse_profile/nurse_profile.dart';
import 'package:private_nurse_for_client/theme.dart';

class NurseApplication extends StatefulWidget {
  // final String src;
  final JobModel jobModel;
  NurseApplication(
      {Key? key,
      // required this.src,
      required this.jobModel})
      : super(key: key);

  @override
  State<NurseApplication> createState() => _NurseApplicationState();
}

class _NurseApplicationState extends State<NurseApplication> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nurse Applications",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.jobModel.listOfAppliedNurse!
                .length, // Replace with your actual item count
            itemBuilder: (context, index) {
              return ScaleTap(
                onPressed: () {
                  // navigateTo(context, InformationDetailsScreen(selectedTabIndex: widget.selectedTabIndex,));
                  setState(() {
                    if (widget.jobModel.jobStatusId == OPEN) {
                      navigateTo(
                        context,
                        NurseProfile(
                          lsitOfAppliedNurseModel:
                              widget.jobModel.listOfAppliedNurse![index],
                              jobModel: widget.jobModel,
                          hasButton: true,
                        ),
                      );
                    } else if (widget.jobModel.jobStatusId == WAITING_CLIENT_PAYMENT) {
                      navigateTo(
                        context,
                        NurseProfile(
                          lsitOfAppliedNurseModel:
                              widget.jobModel.listOfAppliedNurse![index],
                               jobModel: widget.jobModel,
                          hasButton: true,
                        ),
                      );
                    } else if (widget.jobModel.jobStatusId == ONGOING) {
                      navigateTo(
                        context,
                        NurseProfile(
                          lsitOfAppliedNurseModel:
                              widget.jobModel.listOfAppliedNurse![index],
                               jobModel: widget.jobModel,
                          hasButton: true,
                        ),
                      );
                    } else {
                      navigateTo(
                        context,
                        NurseProfile(
                          lsitOfAppliedNurseModel:
                              widget.jobModel.listOfAppliedNurse![index],
                               jobModel: widget.jobModel,
                          hasButton: true, 
                        ),
                      );
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        profileShadow(
                          kGrey.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Row(
                      // row for 2 column: image and column
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // image
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: CachedNetworkImage(
                                imageUrl: widget.jobModel
                                    .listOfAppliedNurse![index].profilePhoto!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Space(7),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.jobModel.listOfAppliedNurse![index]
                                          .name!,
                                      style: TextStyle(
                                        color: kBlack,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  badgeStatus(
                                    status: widget.jobModel.listOfAppliedNurse![index].nurse!.applyJobStatus!,
                                    statusId: widget.jobModel.listOfAppliedNurse![index].nurse!.applyJobStatusId!,
                                  )
                                  // status[index] == 'Accepted'
                                  //     ? Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.end,
                                  //         children: [
                                  //           Container(
                                  //               padding:
                                  //                   const EdgeInsets.symmetric(
                                  //                       horizontal: 10,
                                  //                       vertical: 2),
                                  //               decoration: BoxDecoration(
                                  //                 color: Color.fromRGBO(
                                  //                     209, 250, 229, 10),
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(10),
                                  //               ),
                                  //               child: Text(
                                  //                 status[0],
                                  //                 style: TextStyle(
                                  //                   color: Color.fromRGBO(
                                  //                       6, 95, 70, 1),
                                  //                   fontSize: 12,
                                  //                   fontWeight: FontWeight.w500,
                                  //                 ),
                                  //               ))
                                  //         ],
                                  //       )
                                  //     : status[index] == 'Cancelled'
                                  //         ? Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.end,
                                  //             children: [
                                  //               Container(
                                  //                   padding: const EdgeInsets
                                  //                           .symmetric(
                                  //                       horizontal: 10,
                                  //                       vertical: 2),
                                  //                   decoration: BoxDecoration(
                                  //                     color: Color.fromRGBO(
                                  //                         250, 209, 209, 0.965),
                                  //                     borderRadius:
                                  //                         BorderRadius.circular(
                                  //                             10),
                                  //                   ),
                                  //                   child: Text(
                                  //                     status[1],
                                  //                     style: TextStyle(
                                  //                       color: Color.fromRGBO(
                                  //                           95, 6, 6, 1),
                                  //                       fontSize: 12,
                                  //                       fontWeight:
                                  //                           FontWeight.w500,
                                  //                     ),
                                  //                   ))
                                  //             ],
                                  //           )
                                  //         : status[index] == 'Awaiting'
                                  //             ? Row(
                                  //                 mainAxisAlignment:
                                  //                     MainAxisAlignment.end,
                                  //                 children: [
                                  //                   Container(
                                  //                       padding:
                                  //                           const EdgeInsets
                                  //                                   .symmetric(
                                  //                               horizontal: 10,
                                  //                               vertical: 2),
                                  //                       decoration:
                                  //                           BoxDecoration(
                                  //                         color: Color.fromRGBO(
                                  //                             247,
                                  //                             250,
                                  //                             209,
                                  //                             0.965),
                                  //                         borderRadius:
                                  //                             BorderRadius
                                  //                                 .circular(10),
                                  //                       ),
                                  //                       child: Text(
                                  //                         status[2],
                                  //                         style: TextStyle(
                                  //                           color:
                                  //                               Color.fromRGBO(
                                  //                                   95,
                                  //                                   86,
                                  //                                   6,
                                  //                                   1),
                                  //                           fontSize: 12,
                                  //                           fontWeight:
                                  //                               FontWeight.w500,
                                  //                         ),
                                  //                       ))
                                  //                 ],
                                  //               )
                                  //             : status[index] == 'On-going'
                                  //                 ? Row(
                                  //                     mainAxisAlignment:
                                  //                         MainAxisAlignment.end,
                                  //                     children: [
                                  //                       Container(
                                  //                           padding:
                                  //                               const EdgeInsets
                                  //                                       .symmetric(
                                  //                                   horizontal:
                                  //                                       10,
                                  //                                   vertical:
                                  //                                       2),
                                  //                           decoration:
                                  //                               BoxDecoration(
                                  //                             color: Color
                                  //                                 .fromRGBO(
                                  //                                     209,
                                  //                                     222,
                                  //                                     250,
                                  //                                     0.965),
                                  //                             borderRadius:
                                  //                                 BorderRadius
                                  //                                     .circular(
                                  //                                         10),
                                  //                           ),
                                  //                           child: Text(
                                  //                             status[3],
                                  //                             style: TextStyle(
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       6,
                                  //                                       27,
                                  //                                       95),
                                  //                               fontSize: 12,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w500,
                                  //                             ),
                                  //                           ))
                                  //     ],
                                  //   )
                                  // : SizedBox(),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
