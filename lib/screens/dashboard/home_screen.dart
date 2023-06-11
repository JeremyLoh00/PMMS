import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/button_secondary.dart';
import 'package:private_nurse_for_client/screens/job/job_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 350),
      child: ButtonSecondary(
        text: "Job list",
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JobDetail(),
              ));
        },
      ),
    );
  }
}
