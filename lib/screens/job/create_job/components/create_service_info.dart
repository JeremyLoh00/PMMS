import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/form_bloc/store_job_form_bloc.dart';
import 'package:private_nurse_for_client/screens/edit_profile/edit_profile_screen.dart';

class CreateServiceInfo extends StatefulWidget {
  StoreJobFormBloc storeJobFormBloc;
  CreateServiceInfo({
    super.key,
    required this.storeJobFormBloc,
  });

  @override
  State<CreateServiceInfo> createState() => _CreateServiceInfoState();
}

List<String> listGender = ['Male', 'Female'];

List<String> listRace = ['Malay', 'Chinese', 'Indian', 'Others'];

class _CreateServiceInfoState extends State<CreateServiceInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
        ],
      ),
    );
  }
}
