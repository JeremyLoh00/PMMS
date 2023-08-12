import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';
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
                                  child: Image.network(
                                    url,
                                    fit: BoxFit.cover,
                                    width: 1000.0,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.error);
                                    },
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      return ThemeSpinner.spinner();
                                    },
                                    
                                  ),
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
