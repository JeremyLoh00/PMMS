import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/theme.dart';

class ScheduleList extends StatefulWidget {
  // final String src;
  final JobModel jobModel;
  const ScheduleList({
    super.key,
    // required this.src,
    required this.jobModel,
  });

  @override
  State<ScheduleList> createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.jobModel.jobSchedule!.length,
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Date
                Text(
                  widget.jobModel.jobSchedule![index].date!,
                  style: TextStyle(
                      fontSize: 10,
                      color: kGrey,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600),
                ),
                Space(3),
                //Time
                Row(
                  children: [
                    Text(
                      widget.jobModel.jobSchedule![index].startTime!,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " - ",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.jobModel.jobSchedule![index].endTime!,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Space(15)
              ],
            ),
          );
        },
      ),
    );
  }
}
