import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/store_job_form_bloc.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/screens/edit_profile/edit_profile_screen.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/field_bloc/variant_field_bloc.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/summary.dart';
import 'package:private_nurse_for_client/theme.dart';

class CreateServiceInfo extends StatefulWidget {
  final StoreJobFormBloc storeJobFormBloc;
  Set<DateTime> selectedDays;
  CreateServiceInfo(
    this.storeJobFormBloc, {
    super.key,
    required this.selectedDays,
  });

  @override
  State<CreateServiceInfo> createState() => _CreateServiceInfoState();
}

List<String> listPreferredTime = [
  '8 AM',
  '5 Hours',
  '7 Hours',
  '9 Hours',
  '12 Hours',
];

List<String> listDuration = [
  '3 Hours',
  '5 Hours',
  '7 Hours',
  '9 Hours',
  '10 Hours',
  '12 Hours',
];

class _CreateServiceInfoState extends State<CreateServiceInfo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String dateId = widget.selectedDays.first.day.toString() +
        "-" +
        widget.selectedDays.first.month.toString() +
        "-" +
        widget.selectedDays.first.year.toString();
    widget.storeJobFormBloc.addVariant(dateId);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          BlocBuilder<ListFieldBloc<VariantFieldBloc, dynamic>,
              ListFieldBlocState<VariantFieldBloc, dynamic>>(
            bloc: widget.storeJobFormBloc.variants,
            builder: (context, state) {
              if (state.fieldBlocs.isNotEmpty) {
                String? _preffredTime;
                String? _prefferedDuration;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.fieldBlocs.length,
                  itemBuilder: (context, index) {
                    String dateId = widget.selectedDays.first.day.toString() +
                        "-" +
                        widget.selectedDays.first.month.toString() +
                        "-" +
                        widget.selectedDays.first.year.toString();
                    print(widget.storeJobFormBloc.listSelected[index].entries);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Space(30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.storeJobFormBloc.listSelected[index]
                                    .entries.first.key,
                                style: textStyleNormal(
                                  fontWeight: FontWeight.bold,
                                  fontsize: 16,
                                ),
                              ),
                              const SizedBox(
                                width: 30.0,
                              ),
                              //Divider
                              Container(
                                width: 1,
                                height: 180.0,
                                color: Colors.grey.shade300,
                              ),
                              const SizedBox(
                                width: 30.0,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Preferred Start Time",
                                      style: textStyleNormal(
                                        color: kGrey,
                                        fontsize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Space(10.0),
                                    Container(
                                      width: double.infinity,
                                      child: DropdownButtonFormField(
                                        hint: const Text("Time"),
                                        value: _preffredTime,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _preffredTime = newValue ?? "";
                                          });
                                        },
                                        items: _prefferedTimeList(),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 5.0,
                                                  horizontal: 10.0),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 3,
                                              color: Colors.grey,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Space(20.0),
                                    Text(
                                      "Duration",
                                      style: textStyleNormal(
                                        color: kGrey,
                                        fontsize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Space(10.0),
                                    Container(
                                      width: double.infinity,
                                      child: DropdownButtonFormField(
                                        hint: const Text("Duration"),
                                        value: _prefferedDuration,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _prefferedDuration = newValue ?? "";
                                          });
                                        },
                                        items: _duration(),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 5.0,
                                                  horizontal: 10.0),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 3,
                                              color: Colors.grey,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Space(30),
                      ],
                    );
                  },
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _prefferedTimeList() {
    return listPreferredTime.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>> _duration() {
    return listDuration.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}
