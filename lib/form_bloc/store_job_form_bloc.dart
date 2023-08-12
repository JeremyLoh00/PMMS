import 'dart:async';

import 'package:form_bloc/form_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:private_nurse_for_client/bloc/job_bloc.dart';
import 'package:private_nurse_for_client/bloc/service_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/validators.dart';
import 'package:private_nurse_for_client/models/job/job_form_error_model.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/job/job_store_response_model.dart';
import 'package:private_nurse_for_client/models/job/schedule_list_response_model.dart';
import 'package:private_nurse_for_client/models/job_schedule/job_schedule_model.dart';
import 'package:private_nurse_for_client/models/registration/register_nurse_request_model.dart';
import 'package:private_nurse_for_client/models/service/service_list_response_model.dart';
import 'package:private_nurse_for_client/models/service/service_model.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/field_bloc/variant_field_bloc.dart';

class StoreJobFormBloc extends FormBloc<String, String> {
  XFile? newFormalPhoto1;
  //Form key declaration and validations
  final name = TextFieldBloc(
    initialValue: "izzat",
    validators: [
      InputValidator.required,
      InputValidator.nameChar,
    ],
  );

  final age = TextFieldBloc(
    initialValue: "18",
    validators: [
      InputValidator.required,
    ],
  );

  final height = TextFieldBloc(
    initialValue: "165.0",
    validators: [
      InputValidator.required,
    ],
  );

  final weight = TextFieldBloc(
    initialValue: "70.0",
    validators: [
      InputValidator.required,
    ],
  );

  final phoneNum = TextFieldBloc(
    initialValue: "012-3456789",
    validators: [
      InputValidator.required,
      InputValidator.phoneNo,
    ],
  );

  final address = TextFieldBloc(initialValue: "No 26 Jalan Ikan"
      // validators: [
      //   InputValidator.required,
      // ],
      );

  // State
  final division = TextFieldBloc();
  // Get the integer value from the division field bloc
  int getDivisionValue() {
    final divisionText = division.value;
    if (divisionText.isNotEmpty) {
      return int.parse(divisionText);
    } else {
      // Handle the case when the division field is empty or invalid
      return 0; // Or any default value you want to use
    }
  }

  // city
  final cityModel = TextFieldBloc();
  // Get the integer value from the division field bloc
  int getCityValue() {
    final cityText = cityModel.value;
    if (cityText.isNotEmpty) {
      return int.parse(cityText);
    } else {
      // Handle the case when the division field is empty or invalid
      return 0; // Or any default value you want to use
    }
  }

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

  final preferredGender = SelectFieldBloc(
    validators: [FieldBlocValidators.required],
    items: [
      'Male',
      'Female',
      'Any',
    ],
  );

  final preferredRace = SelectFieldBloc(
    validators: [FieldBlocValidators.required],
    items: [
      'Malay',
      'Chinese',
      'Indian',
      'Sabahan',
      'Sarawakian',
      'Any',
    ],
  );

  final variants = ListFieldBloc<VariantFieldBloc, dynamic>(name: 'variants');

  List<Map<String, VariantFieldBloc>> listSelected = [];

  StoreJobFormBloc() {
    // Get job and insert to list of job to show the checkbox
    getServiceData();
    getScheduleData();
    addFieldBlocs(fieldBlocs: [
      serviceInfo,
      scheduleList,
      preferredGender,
      preferredRace,
      name,
      age,
      height,
      weight,
      phoneNum,
      address,
      division,
      cityModel,
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

      // Preferred Gender
      if (jobModel.patient?.preferredGender ==
          preferredGender.value?.toUpperCase()) {
        jobModel.patient?.preferredGenderId = PREFERRED_GENDER_MALE;
      } else if (jobModel.patient?.preferredGender ==
          preferredGender.value?.toUpperCase()) {
        jobModel.patient?.preferredGenderId = PREFERRED_GENDER_FEMALE;
      } else if (jobModel.patient?.preferredGender ==
          preferredGender.value?.toUpperCase()) {
        jobModel.patient?.preferredGenderId = PREFERRED_GENDER_ANY;
      }

      // Preferred Race
      if (jobModel.patient?.preferredRace ==
          preferredRace.value?.toUpperCase()) {
        jobModel.patient?.preferredGenderId = PREFERRED_RACE_MALAY;
      } else if (jobModel.patient?.preferredRace ==
          preferredRace.value?.toUpperCase()) {
        jobModel.patient?.preferredGenderId = PREFERRED_RACE_CHINESE;
      } else if (jobModel.patient?.preferredRace ==
          preferredRace.value?.toUpperCase()) {
        jobModel.patient?.preferredGenderId = PREFERRED_RACE_INDIAN;
      } else if (jobModel.patient?.preferredRace ==
          preferredRace.value?.toUpperCase()) {
        jobModel.patient?.preferredGenderId = PREFERRED_RACE_SABAHAN;
      } else if (jobModel.patient?.preferredRace ==
          preferredRace.value?.toUpperCase()) {
        jobModel.patient?.preferredGenderId = PREFERRED_RACE_SARAWAKIAN;
      } else if (jobModel.patient?.preferredRace ==
          preferredRace.value?.toUpperCase()) {
        jobModel.patient?.preferredGenderId = PREFERRED_RACE_ANY;
      }

      // Patient Info
      jobModel.patient?.name = name.value.trim();
      jobModel.patient?.age = age.value.trim();
      jobModel.height = height.value.trim();
      jobModel.weight = weight.value.trim();
      jobModel.phoneNo = phoneNum.value.trim();
      jobModel.address = address.value.trim();

      RegisterClientRequestModel requestModel = RegisterClientRequestModel();
      requestModel.worldDivisionId = getDivisionValue();
      requestModel.worldCityId = getCityValue();


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
          if (errorModel.patientsPreferredGender != null) {
            preferredGender.addError(errorModel.patientsPreferredGender![0]);
          }
          if (errorModel.patientsPreferredRace != null) {
            preferredRace.addError(errorModel.patientsPreferredRace![0]);
          }
          if (errorModel.patientsName != null) {
            name.addError(errorModel.patientsName![0]);
          }
          if (errorModel.patientsAge != null) {
            age.addError(errorModel.patientsAge![0]);
          }
          if (errorModel.height != null) {
            height.addError(errorModel.height![0]);
          }
          if (errorModel.weight != null) {
            weight.addError(errorModel.weight![0]);
          }
          if (errorModel.emergencyContactPhoneNo != null) {
            phoneNum.addError(errorModel.emergencyContactPhoneNo![0]);
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
