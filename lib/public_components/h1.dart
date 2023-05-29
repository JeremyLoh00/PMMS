import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';

class H1 extends StatelessWidget {
  final String title;

  H1({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 30,
        fontFamily: 'Poppins',
      ),
    );
  }
}
