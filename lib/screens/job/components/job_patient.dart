// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_scale_tap/flutter_scale_tap.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:private_nurse_for_client/constant.dart';
// import 'package:private_nurse_for_client/helpers/general_method.dart';
// import 'package:private_nurse_for_client/public_components/space.dart';
// import 'package:private_nurse_for_client/screens/job/patient_profile/patient_profile.dart';
// import 'package:private_nurse_for_client/theme.dart';

// class JobPatient extends StatefulWidget {
//   final String src;
//   const JobPatient({
//     super.key,
//     required this.src,
//   });

//   @override
//   State<JobPatient> createState() => _JobPatientState();
// }

// class _JobPatientState extends State<JobPatient> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Patient",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 12.0,
//           ),
//         ),
//         ListView.builder(
//           shrinkWrap: true,
//           physics: const BouncingScrollPhysics(),
//           itemCount: 2, // Replace with your actual item count
//           itemBuilder: (context, index) {
//             return ScaleTap(
//               onPressed: () {
//                 // navigateTo(context, InformationDetailsScreen(selectedTabIndex: widget.selectedTabIndex,));
//                 navigateTo(
//                   context,
//                   PatientProfile(
//                     src: widget.src,
//                   ),
//                 );
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
//                                     "Ms. John",
//                                     style: TextStyle(
//                                       color: kBlack,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                                 // SizedBox(width: 5),
//                                 // Row(
//                                 //   mainAxisAlignment: MainAxisAlignment.end,
//                                 //   children: [
//                                 //     Container(
//                                 //         padding: const EdgeInsets.symmetric(
//                                 //             horizontal: 10, vertical: 2),
//                                 //         decoration: BoxDecoration(
//                                 //           color: kPrimaryColor,
//                                 //           borderRadius: BorderRadius.circular(10),
//                                 //         ),
//                                 //         child: Text(
//                                 //           "Completed",
//                                 //           style: TextStyle(
//                                 //             color: kWhite,
//                                 //             fontSize: 12,
//                                 //             fontWeight: FontWeight.w500,
//                                 //           ),
//                                 //         ))
//                                 //   ],
//                                 // ),
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
