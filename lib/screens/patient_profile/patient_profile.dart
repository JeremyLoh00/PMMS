import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/screens/patient_profile/components/patient_profile_description.dart';
import 'package:private_nurse_for_client/screens/patient_profile/components/patient_profile_header.dart';

class PatientProfile extends StatefulWidget {
  final JobModel jobModel;
  const PatientProfile({
    super.key,
    required this.jobModel,
  });

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

// final List<String> imageList = [
//   "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
//   "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
//   "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
//   "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
//   "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
//   "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
// ];

class _PatientProfileState extends State<PatientProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                        width: double.infinity,
                        child: GFCarousel(
                          autoPlay: true,
                          hasPagination: true,
                          viewportFraction: 1.0,
                          items: widget.jobModel.patientPhotoList!.map(
                            (url) {
                              return Container(
                                margin: EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  child: Image.network(url,
                                      fit: BoxFit.cover, width: 1000.0),
                                ),
                              );
                            },
                          ).toList(),
                          onPageChanged: (index) {
                            setState(() {
                              index;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      PatientProfileHeader(
                        title: widget.jobModel.patient!.name!,
                        name: widget.jobModel.patientEmergencyContact!.name!,
                        sufname: widget
                            .jobModel.patientEmergencyContact!.relationship!,
                        phoneNum:
                            widget.jobModel.patientEmergencyContact!.phoneNo!,
                        gender: widget.jobModel.patient!.genderId!,
                      ),
                      Divider(
                        color: kGrey,
                        thickness: 0.5,
                      ),
                      const SizedBox(height: 15.0),

                      //Description
                      PatientProfileDescription(
                        jobModel: widget.jobModel,
                      ),
                      const SizedBox(height: 15.0),

                      const SizedBox(height: 15.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Patient Profile",
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
