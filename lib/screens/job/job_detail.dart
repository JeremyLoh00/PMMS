// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_scale_tap/flutter_scale_tap.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:private_nurse_for_client/constant.dart';
// import 'package:private_nurse_for_client/helpers/general_method.dart';
// import 'package:private_nurse_for_client/public_components/h1.dart';
// import 'package:private_nurse_for_client/screens/job/components/job_comment.dart';
// import 'package:private_nurse_for_client/screens/job/components/job_description.dart';
// import 'package:private_nurse_for_client/screens/job/components/job_header.dart';
// import 'package:private_nurse_for_client/screens/job/components/nurse_application.dart';
// import 'package:private_nurse_for_client/screens/job/components/job_patient.dart';
// import 'package:private_nurse_for_client/screens/profile/profile_screen.dart';

// class JobDetail extends StatefulWidget {
//   final bool hasComment;
//   const JobDetail({super.key, this.hasComment = false});

//   @override
//   State<JobDetail> createState() => _JobDetailState();
// }

// class _JobDetailState extends State<JobDetail> {
//   String src =
//       "https://c1.wallpaperflare.com/preview/547/839/590/accident-bleed-bleeding-bleeding-finger.jpg";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kWhite,
//       appBar: _buildAppBar(),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: CustomScrollView(
//             shrinkWrap: true,
//             physics: BouncingScrollPhysics(),
//             slivers: [
//               SliverList(
//                 delegate: SliverChildListDelegate(
//                   [
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.25,
//                       width: double.infinity,
//                       child: Hero(
//                         tag: "contest-banner",
//                         // child: Text("data"),
//                         child: Container(
//                           child: CachedNetworkImage(
//                             imageUrl: src,
//                             imageBuilder: (context, imageProvider) => Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20.0),
//                                 shape: BoxShape.rectangle,
//                                 image: DecorationImage(
//                                   image: imageProvider,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 15.0),
//                     JobHeader(
//                       title: "Wound Dressing",
//                       name: "Mr. John Doe",
//                       phoneNum: "012-3456789",
//                       //Job Detail Information
//                       location: "1, Jalan XXX, Taman YYY, 56600 Pekan, Pahang",
//                       date: "21/5/2023 - 24/5/2023 (4 days)",
//                       time: "10.00 A.M - 7.00 P.M. (9 hours)",
//                     ),
//                     const SizedBox(height: 15.0),

//                     //Patient Part
//                     JobPatient(
//                       src: src,
//                     ),
//                     const SizedBox(height: 15.0),
//                     JobDescription(
//                         description:
//                             "Rorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum."),
//                     const SizedBox(height: 15.0),
//                     Divider(
//                       color: kGrey,
//                       thickness: 0.5,
//                     ),
//                     const SizedBox(height: 15.0),
//                     //Nurse Application List
//                     NurseApplication(
//                       src: src,
//                     ),
//                     const SizedBox(height: 15.0),
//                     //User Review
//                     widget.hasComment == false
//                         ? JobComment(
//                             hasReview: false,
//                             comment: "Good Job.",
//                           )
//                         : JobComment(
//                             hasReview: true,
//                             comment: "Good Job.",
//                           ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   AppBar _buildAppBar() {
//     return AppBar(
//       elevation: 0,
//       scrolledUnderElevation: 0,
//       centerTitle: true,
//       backgroundColor: Colors.transparent,
//       leading: IconButton(
//         icon: Icon(
//           Icons.arrow_back,
//         ),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//     );
//   }
// }
