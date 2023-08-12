import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/screens/job_description/components/comment.dart';
import 'package:private_nurse_for_client/screens/job_description/components/job_description_detail.dart';
import 'package:private_nurse_for_client/screens/job_description/components/nurse_application.dart';
import 'package:private_nurse_for_client/screens/job_description/components/patient.dart';

class Body extends StatefulWidget {
  final JobModel jobModel;
  const Body({Key? key, required this.jobModel}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Colors.grey.shade100,
          child: Column(children: [
            //Image
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.jobModel.service!.photoPath!,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => const CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            //Detail container
            Stack(clipBehavior: Clip.none, children: [
              Container(
                height: calcHeight(
                    widget.jobModel.jobSchedule!.length,
                    widget.jobModel.feedbacks != null
                        ? widget.jobModel.feedbacks!.length
                        : 0),
              ),
              Positioned(
                //Position of the float container
                top: MediaQuery.of(context).size.height * .16 -
                    (MediaQuery.of(context).size.width * .4),
                left: 15,
                right: 15,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: -4,
                        blurRadius: 30,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  width: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Title of job
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          color: kPrimaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.jobModel.service!.name!,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: kWhite),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //Job detail description
                      JobDescriptionDetail(
                        jobModel: widget.jobModel,
                      ),
                      //Patient info
                      Patient(
                        jobModel: widget.jobModel,
                      ),
                      //Nurse applications info

                      NurseApplication(
                        jobModel: widget.jobModel,
                      ),

                      // widget.jobModel.jobStatusId == WAITING_CLIENT_REVIEWS
                      //     ?
                      //     //Comment
                      //     Comment(jobModel: widget.jobModel)
                      //     : widget.jobModel.jobStatusId == COMPLETED
                      //         ? Comment(jobModel: widget.jobModel)
                      //         : SizedBox(),

                      widget.jobModel.feedbacks != null
                          ? Comment(jobModel: widget.jobModel)
                          : SizedBox()
                    ],
                  ),
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }

  double calcHeight(int length, int reviewLength) {
    if (reviewLength == null) {
      if (length == 1) {
        return 450;
      } else {
        return 450 + (length * 50);
      }
    } else {
      return 450 + (length * 50) + (reviewLength * 250);
    }
  }
}
