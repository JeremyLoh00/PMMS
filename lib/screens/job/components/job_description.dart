import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';

class JobDescription extends StatefulWidget {
  const JobDescription({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  State<JobDescription> createState() => _JobDescriptionState();
}

class _JobDescriptionState extends State<JobDescription> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Text(
            "Description",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: kGrey,
                fontSize: 12.0,
                letterSpacing: 0.02,
                height: 1.43,
              ),
              children: [
                TextSpan(
                  text: "  $initialText",
                ),
                TextSpan(
                  text: hide ? "..." : extendedText,
                ),
                TextSpan(
                    text: hide ? " Read more" : " Read less",
                    style: const TextStyle(color: kPrimaryColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = (() {
                        setState(() {
                          hide = !hide;
                        });
                      }))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
