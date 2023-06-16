import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';

class PatientProfileDescription extends StatefulWidget {
  const PatientProfileDescription({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  State<PatientProfileDescription> createState() =>
      _PatientProfileDescriptionState();
}

class _PatientProfileDescriptionState extends State<PatientProfileDescription> {
  final int charactersLimit = 150;
  late String initialText;
  late String extendedText;

  bool hide = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    hide = true;

    if (widget.description.length > charactersLimit) {
      initialText = widget.description.substring(0, charactersLimit);
      extendedText = widget.description
          .substring(charactersLimit, widget.description.length);
    } else {
      initialText = widget.description;
      extendedText = "";
    }
  }

  List<String> text1 = [
    'Diabetics',
    'Hypertension',
    'Skin Problem',
  ];

  List<String> text2 = [
    'Bed Bound',
    'Not Cooperative',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Text(
            "Diagnosis",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: text1.length,
                itemBuilder: (context, index) {
                  return RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: kBlack,
                        fontSize: 12.0,
                        letterSpacing: 0.02,
                        height: 1.43,
                      ),
                      children: [
                        TextSpan(
                          text: "\u2022 ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextSpan(
                          text: text1[index],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Text(
            "Patient Condition",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: text2.length,
                itemBuilder: (context, index) {
                  return RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: kBlack,
                        fontSize: 12.0,
                        letterSpacing: 0.02,
                        height: 1.43,
                      ),
                      children: [
                        TextSpan(
                          text: "\u2022 ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextSpan(
                          text: text2[index],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
