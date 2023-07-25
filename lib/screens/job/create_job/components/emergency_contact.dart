import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/theme.dart';

class EmergencyContact extends StatefulWidget {
  const EmergencyContact({super.key});

  @override
  State<EmergencyContact> createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {
  TextEditingController name = TextEditingController();
  TextEditingController phoneNum = TextEditingController();
  TextEditingController relationship = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Emergency Contact",
            style: textStyleNormal(
              fontWeight: FontWeight.bold,
              fontsize: 16.0,
            ),
          ),
          Space(10.0),
          TextFormField(
            controller: name,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.person_outline_rounded),
              enabled: true,
              hintText: 'Name',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          Space(10.0),
          TextFormField(
            controller: phoneNum,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.phone_outlined),
              enabled: true,
              hintText: 'Phone No.',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          Space(10.0),
          TextFormField(
            controller: relationship,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.group_outlined),
              enabled: true,
              hintText: 'Relationship',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
