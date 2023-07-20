import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/store_job_form_bloc.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/create_job_header.dart';

class CreateJob extends StatefulWidget {
  const CreateJob({super.key});

  @override
  State<CreateJob> createState() => _CreateJobState();
}

class _CreateJobState extends State<CreateJob> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreJobFormBloc(),
      child: Builder(
        builder: (context) {
          final storeJobFormBloc = BlocProvider.of<StoreJobFormBloc>(context);
          return FormBlocListener<StoreJobFormBloc, String, String>(
              onSubmitting: (context, state) {
                FocusScope.of(context).unfocus();
                CircularProgressIndicator();
              },
              onSuccess: (context, state) {
                ThemeSnackBar.showSnackBar(
                  context,
                  "Success",
                );
              },
              onFailure: (context, state) {
                ThemeSnackBar.showSnackBar(
                    context, state.failureResponse ?? "Error");
              },
              onSubmissionFailed: (context, state) {
                print("on submission failed ${state}");
              },
              child: Scaffold(
                backgroundColor: kWhite,
                drawerEnableOpenDragGesture: true,
                appBar: AppBar(
                  scrolledUnderElevation: 0,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    "Create Job",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                body: SafeArea(
                  child: Column(
                    children: [
                      CreateJobHeader(storeJobFormBloc: storeJobFormBloc),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
