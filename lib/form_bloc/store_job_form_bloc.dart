import 'dart:async';

import 'package:form_bloc/form_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:private_nurse_for_client/bloc/job_bloc.dart';
import 'package:private_nurse_for_client/bloc/service_bloc.dart';
import 'package:private_nurse_for_client/helpers/validators.dart';
import 'package:private_nurse_for_client/models/job/job_form_error_model.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/job/job_store_response_model.dart';
import 'package:private_nurse_for_client/models/job/schedule_list_response_model.dart';
import 'package:private_nurse_for_client/models/job_schedule/job_schedule_model.dart';
import 'package:private_nurse_for_client/models/service/service_list_response_model.dart';
import 'package:private_nurse_for_client/models/service/service_model.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/field_bloc/variant_field_bloc.dart';

class StoreJobFormBloc extends FormBloc<String, String> {
  XFile? newFormalPhoto1;
  //Form key declaration and validations
  final dateJobInfo = TextFieldBloc(
    validators: [
      InputValidator.required,
    ],
  );

  final timeJobInfo = TextFieldBloc(
    validators: [
      InputValidator.required,
    ],
  );

  final scheduleList = SelectFieldBloc<JobScheduleModel, dynamic>();

  final preferredDay = SelectFieldBloc();

  final serviceInfo = SelectFieldBloc<ServiceModel, dynamic>();

  final preferredNurse = SelectFieldBloc();

  final genderService = SelectFieldBloc();

  final raceService = SelectFieldBloc();

  final variants = ListFieldBloc<VariantFieldBloc, dynamic>(name: 'variants');

  List<Map<String, VariantFieldBloc>> listSelected = [];

  StoreJobFormBloc() {
    // Get job and insert to list of job to show the checkbox
    getServiceData();
    getScheduleData();
    addFieldBlocs(fieldBlocs: [
      serviceInfo,
      scheduleList,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    try {
      // Create model and insert all the necessary value
      JobModel jobModel = JobModel();
      jobModel.service = ServiceModel();
      jobModel.service = serviceInfo.value;
      jobModel.jobSchedule =
          variants.value.map<JobScheduleModel>((scheduleJob) {
        return JobScheduleModel(
          id: scheduleJob.id,
          startTime: scheduleJob.prefferedStartTime.value,
          duration: scheduleJob.duration.value,
        );
      }).toList();
      // jobModel.jobSchedule = [scheduleList.value!];

      //Declare Bloc
      JobsBloc jobBloc = JobsBloc();

      //Call API
      JobStoreResponseModel jobStoreResponseModel =
          await jobBloc.storeJob(jobModel);

      // Handle response
      if (jobStoreResponseModel.isSuccess) {
        // Emit success
        emitSuccess();
      } else {
        // Put error to the field
        JobFormErrorModel? errorModel = jobStoreResponseModel.errors;
        if (errorModel != null) {
          if (errorModel.serviceId != null) {
            serviceInfo.addError(errorModel.serviceId![0]);
          }
        }
        // Emit failure with validation errors
        emitFailure(failureResponse: jobStoreResponseModel.message);
      }
    } catch (exception) {
      emitFailure(failureResponse: exception.toString());
    }
  }

  // Query list of job
  void getServiceData() async {
    // Call API to get list of outlets
    ServiceBloc serviceBloc = ServiceBloc();
    ServiceListResponseModel serviceListResponseModel =
        await serviceBloc.getListService();

    if (serviceListResponseModel.isSuccess) {
      for (ServiceModel service in serviceListResponseModel.data!) {
        serviceInfo.addItem(service);
      }
      serviceInfo.updateInitialValue(serviceListResponseModel.data?[0]);
    }
  }

  // Query list of job
  void getScheduleData() async {
    // Call API to get list of outlets
    ServiceBloc serviceBloc = ServiceBloc();
    ScheduleListResponseModel scheduleListResponseModel =
        await serviceBloc.getListSchedule();

    if (scheduleListResponseModel.isSuccess) {
      for (JobScheduleModel schedule in scheduleListResponseModel.data!) {
        scheduleList.addItem(schedule);
      }
      scheduleList.updateInitialValue(scheduleListResponseModel.data?[0]);
    }
  }

  void addVariant(String dateId) {
    listSelected.add({
      dateId: VariantFieldBloc(
        name: 'variant',
        prefferedStartTime: TextFieldBloc(name: 'variantName'),
        duration: TextFieldBloc(name: 'option'),
      )
    });
    variants.addFieldBloc(
      listSelected.firstWhere(
        (element) => element.containsKey(dateId),
      )[dateId]!,
    );
  }

  void removeVariant(String dateId) {
    // variants.removeFieldBlocAt(dateID);
    VariantFieldBloc removeVariantFieldBloc = listSelected.firstWhere(
      (element) => element.containsKey(dateId),
    )[dateId]!;
    variants.removeFieldBloc(removeVariantFieldBloc);
  }
}
