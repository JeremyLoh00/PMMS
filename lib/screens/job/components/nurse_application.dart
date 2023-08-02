// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_scale_tap/flutter_scale_tap.dart';
// import 'package:private_nurse_for_client/constant.dart';
// import 'package:private_nurse_for_client/helpers/general_method.dart';
// import 'package:private_nurse_for_client/public_components/custom_list_tile.dart';
// import 'package:private_nurse_for_client/public_components/space.dart';
// import 'package:private_nurse_for_client/screens/job/nurse_profile/nurse_profile.dart';
// import 'package:private_nurse_for_client/screens/job/patient_profile/patient_profile.dart';
// import 'package:private_nurse_for_client/theme.dart';

// class NurseApplication extends StatefulWidget {
//   final String src;
//   NurseApplication({
//     Key? key,
//     required this.src,
//   }) : super(key: key);

//   @override
//   State<NurseApplication> createState() => _NurseApplicationState();
// }

// class _NurseApplicationState extends State<NurseApplication> {
//   List<String> status = [
//     'Accepted',
//     'Cancelled',
//     'Awaiting',
//     'On-going',
//     'plant',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Nurse Applications",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 12.0,
//           ),
//         ),
//         ListView.builder(
//           shrinkWrap: true,
//           physics: const BouncingScrollPhysics(),
//           itemCount: status.length, // Replace with your actual item count
//           itemBuilder: (context, index) {
//             return ScaleTap(
//               onPressed: () {
//                 // navigateTo(context, InformationDetailsScreen(selectedTabIndex: widget.selectedTabIndex,));
//                 setState(() {
//                   if (status[index] == 'Accepted') {
//                     navigateTo(
//                       context,
//                       NurseProfile(
//                         src: widget.src,
//                         hasButton: true,
//                       ),
//                     );
//                   } else if (status[index] == 'Cancelled') {
//                     navigateTo(
//                       context,
//                       NurseProfile(
//                         src: widget.src,
//                       ),
//                     );
//                   } else if (status[index] == 'Awaiting') {
//                     navigateTo(
//                       context,
//                       NurseProfile(
//                         src: widget.src,
//                         hasButton: true,
//                       ),
//                     );
//                   } else if (status[index] == 'On-going') {
//                     navigateTo(
//                       context,
//                       NurseProfile(
//                         src: widget.src,
//                         hasButton: true,
//                       ),
//                     );
//                   } else {
//                     navigateTo(
//                       context,
//                       NurseProfile(
//                         src: widget.src,
//                       ),
//                     );
//                   }
//                 });
//               },
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   margin: EdgeInsets.only(top: 10),
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: kWhite,
//                     borderRadius: BorderRadius.circular(5),
//                     boxShadow: [
//                       profileShadow(
//                         kGrey.withOpacity(0.3),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     // row for 2 column: image and column
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // image
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                             width: 40,
//                             height: 40,
//                             child: CachedNetworkImage(
//                               imageUrl: widget.src,
//                               imageBuilder: (context, imageProvider) =>
//                                   Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   image: DecorationImage(
//                                     image: imageProvider,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               placeholder: (context, url) =>
//                                   const CircularProgressIndicator(
//                                 color: kPrimaryColor,
//                               ),
//                               errorWidget: (context, url, error) =>
//                                   const Icon(Icons.error),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(width: 5),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Space(7),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: const Text(
//                                     "Nurse Aida",
//                                     style: TextStyle(
//                                       color: kBlack,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 5),
//                                 status[index] == 'Accepted'
//                                     ? Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         children: [
//                                           Container(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 10,
//                                                       vertical: 2),
//                                               decoration: BoxDecoration(
//                                                 color: Color.fromRGBO(
//                                                     209, 250, 229, 10),
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                               ),
//                                               child: Text(
//                                                 status[0],
//                                                 style: TextStyle(
//                                                   color: Color.fromRGBO(
//                                                       6, 95, 70, 1),
//                                                   fontSize: 12,
//                                                   fontWeight: FontWeight.w500,
//                                                 ),
//                                               ))
//                                         ],
//                                       )
//                                     : status[index] == 'Cancelled'
//                                         ? Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.end,
//                                             children: [
//                                               Container(
//                                                   padding: const EdgeInsets
//                                                           .symmetric(
//                                                       horizontal: 10,
//                                                       vertical: 2),
//                                                   decoration: BoxDecoration(
//                                                     color: Color.fromRGBO(
//                                                         250, 209, 209, 0.965),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                   ),
//                                                   child: Text(
//                                                     status[1],
//                                                     style: TextStyle(
//                                                       color: Color.fromRGBO(
//                                                           95, 6, 6, 1),
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                     ),
//                                                   ))
//                                             ],
//                                           )
//                                         : status[index] == 'Awaiting'
//                                             ? Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.end,
//                                                 children: [
//                                                   Container(
//                                                       padding: const EdgeInsets
//                                                               .symmetric(
//                                                           horizontal: 10,
//                                                           vertical: 2),
//                                                       decoration: BoxDecoration(
//                                                         color: Color.fromRGBO(
//                                                             247,
//                                                             250,
//                                                             209,
//                                                             0.965),
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                       ),
//                                                       child: Text(
//                                                         status[2],
//                                                         style: TextStyle(
//                                                           color: Color.fromRGBO(
//                                                               95, 86, 6, 1),
//                                                           fontSize: 12,
//                                                           fontWeight:
//                                                               FontWeight.w500,
//                                                         ),
//                                                       ))
//                                                 ],
//                                               )
//                                             : status[index] == 'On-going'
//                                                 ? Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.end,
//                                                     children: [
//                                                       Container(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .symmetric(
//                                                                   horizontal:
//                                                                       10,
//                                                                   vertical: 2),
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             color:
//                                                                 Color.fromRGBO(
//                                                                     209,
//                                                                     222,
//                                                                     250,
//                                                                     0.965),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         10),
//                                                           ),
//                                                           child: Text(
//                                                             status[3],
//                                                             style: TextStyle(
//                                                               color: Color
//                                                                   .fromARGB(
//                                                                       255,
//                                                                       6,
//                                                                       27,
//                                                                       95),
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w500,
//                                                             ),
//                                                           ))
//                                                     ],
//                                                   )
//                                                 : SizedBox(),
//                               ],
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
