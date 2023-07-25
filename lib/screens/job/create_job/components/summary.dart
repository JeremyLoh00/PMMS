import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/card_summary_job.dart';
import 'package:private_nurse_for_client/theme.dart';

class Summary extends StatefulWidget {
  const Summary({super.key});

  @override
  State<Summary> createState() => _SummaryState();
}

List<String> cardName = [
  "Job & Service Info",
  "Preferred Nurse",
  "Patient Info",
  "Emergency Contact",
];

List<IconData> cardIcon = [
  Icons.list_alt_rounded,
  Icons.person_3_outlined,
  Icons.personal_injury_outlined,
  Icons.phone_outlined,
];

final List<String> patientDiagnosisList = [
  'Diabetic',
  'Hipertensi',
  'Heart Failure',
  'Kidney Disease',
  'Dyalisis',
  'Asthma',
  'Skin Problem',
  'Blindness',
  'Dementia',
  'Alzheimer',
  'Stroke',
  'Other',
];

final List<String> patientConditionList = [
  'Wheelchair Bound',
  'Bed Bound',
  'Can Ambulate',
  'Can Talk and Walk',
  'Cannot Talk',
  'Cooperative',
  'Not Cooperative',
];

final List<String> imageList = [
  "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
  "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
  "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
];

final List<int> numDay = [1, 2];

final List<String> date = [
  '12/7/2023',
  '13/7/2023',
];

final List<String> timeBefore = [
  '10:00',
  '11:00',
];

final List<String> timeAfter = [
  '13:00',
  '14:00',
];

class _SummaryState extends State<Summary> {
  int delayAnimationDuration = 200;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Job & Service Info
          DelayedDisplay(
            delay: Duration(microseconds: delayAnimationDuration),
            child: JobAndServiceInfoSummary(
              nameCard: cardName,
              cardIcon: cardIcon,
              numDay: numDay,
              date: date,
              timeBefore: timeBefore,
              timeAfter: timeAfter,
            ),
          ),
          // Preferred Nurse
          DelayedDisplay(
            delay: Duration(microseconds: delayAnimationDuration),
            child: PrefferedNurseCard(
              cardIcon: cardIcon,
              nameCard: cardName,
            ),
          ),
          // Patient Info
          DelayedDisplay(
            delay: Duration(microseconds: delayAnimationDuration),
            child: PatientInfoCard(
              cardIcon: cardIcon,
              nameCard: cardName,
              patientDiagnosisList: patientDiagnosisList,
              patientConditionList: patientConditionList,
              imageList: imageList,
            ),
          ),
          // Emergency Contact
          DelayedDisplay(
            delay: Duration(microseconds: delayAnimationDuration),
            child: EmergencyContactCard(),
          ),
        ],
      ),
    );
  }
}
