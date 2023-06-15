import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateJobInfo extends StatefulWidget {
  const CreateJobInfo({super.key});

  @override
  State<CreateJobInfo> createState() => _CreateJobInfoState();
}

class _CreateJobInfoState extends State<CreateJobInfo> {
  String? pref_week;
  String? pref_day;
  TextEditingController date = TextEditingController();
  final format = DateFormat('HH:mm');

  final weekList = [
    'Every Week',
    'First Week',
    'Second Week',
    'Third Week',
    'Fourth Week',
  ];

  final daysList = [
    'Everyday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Weekend',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        TextFormField(
          readOnly: true,
          controller: date,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.calendar_month_outlined),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            enabled: true,
            hintText: 'Date',
            labelText: 'Date',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1998),
              lastDate: DateTime(2200),
            );

            if (pickedDate != null) {
              setState(() {
                date.text = DateFormat('yyyy-MM-dd').format(pickedDate);
              });
            } else {}
          },
        ),
        SizedBox(
          height: 20,
        ),
        DateTimeField(
          format: format,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.access_time),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            enabled: true,
            hintText: 'Time',
            labelText: 'Time',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onShowPicker: (context, currentValue) async {
            final pickerTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(
                currentValue ?? DateTime.now(),
              ),
            );

            return DateTimeField.convert(pickerTime);
          },
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "PReferred Period",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 200,
              child: DropdownButtonFormField(
                hint: Text("Preferred Week"),
                value: pref_week,
                onChanged: (String? newValue) {
                  setState(() {
                    pref_week = newValue ?? "";
                  });
                },
                items: _week(),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              child: DropdownButtonFormField(
                hint: Text("Preferred Days"),
                value: pref_day,
                onChanged: (String? newValue) {
                  setState(() {
                    pref_day = newValue ?? "";
                  });
                },
                items: _days(),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _week() {
    return weekList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>> _days() {
    return daysList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}
