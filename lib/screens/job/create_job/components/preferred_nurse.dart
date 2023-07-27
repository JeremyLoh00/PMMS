import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:private_nurse_for_client/form_bloc/store_job_form_bloc.dart';
import 'package:private_nurse_for_client/public_components/space.dart';

class PreferredNurse extends StatefulWidget {
  StoreJobFormBloc formBloc;
  PreferredNurse({
    super.key,
    required this.formBloc,
  });

  @override
  State<PreferredNurse> createState() => _PreferredNurseState();
}

List<String> listGender = ['Male', 'Female', 'Any'];

List<String> listRace = [
  'Malay',
  'Chinese',
  'Indian',
  'Sabahan',
  'Sarawakian',
  'Any'
];

class _PreferredNurseState extends State<PreferredNurse> {
  String genderOption = listGender[0];
  String raceOption = listRace[0];
  int delayAnimationDuration = 200;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DelayedDisplay(
          delay: Duration(milliseconds: delayAnimationDuration),
          child: const Text(
            "Preferred Nurse",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Space(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Gender",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RadioButtonGroupFieldBlocBuilder<String>(
                    selectFieldBloc: widget.formBloc.preferredGender,
                    itemBuilder: (context, dynamic value) =>
                        FieldItem(child: Text(value)),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Race",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RadioButtonGroupFieldBlocBuilder<String>(
                    selectFieldBloc: widget.formBloc.preferredRace,
                    itemBuilder: (context, dynamic value) =>
                        FieldItem(child: Text(value)),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: SizedBox(),
                    ),
                  ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
