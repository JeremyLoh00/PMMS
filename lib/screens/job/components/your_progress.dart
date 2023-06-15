import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';

class YourProgress extends StatelessWidget {
  const YourProgress({
    Key? key,
    required this.percentageValue,
  }) : super(key: key);

  final int percentageValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Text(
            "Your Progress",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
        // progress bar
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(148, 148, 148, 0.25),
                  blurRadius: 12.0,
                )
              ],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: PercentageProgressBar(percentageValue: percentageValue),
          ),
        )
      ],
    );
  }
}

class PercentageProgressBar extends StatelessWidget {
  const PercentageProgressBar({
    Key? key,
    required this.percentageValue,
  }) : super(key: key);

  final int percentageValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: LinearProgressIndicator(
              value: percentageValue / 100,
              minHeight: 10.0,
              color: kPrimaryColor,
              backgroundColor: const Color.fromRGBO(233, 233, 233, 1),
              semanticsValue: "$percentageValue%",
            ),
          ),
        ),
        const SizedBox(width: 5.0),
        Text(
          "$percentageValue%",
          style: const TextStyle(
            color: kDarkGrey,
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}
