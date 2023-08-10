import 'dart:async';

import 'package:form_bloc/form_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:private_nurse_for_client/bloc/feedback_bloc.dart';
import 'package:private_nurse_for_client/bloc/job_bloc.dart';
import 'package:private_nurse_for_client/helpers/validators.dart';
import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/feedback/feedback_model.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/job/job_store_response_model.dart';
import 'package:private_nurse_for_client/models/list_feedback_for_specific_nurse/review_nurse_request_model.dart';

class StoreReviewFormBloc extends FormBloc<String, String> {
  JobModel jobModel;
  JobsBloc feedbackBloc = new JobsBloc();
  XFile? newFormalPhoto1;
  //Form key declaration and validations
  final newComment = TextFieldBloc(
    validators: [
      InputValidator.required,
    ],
  );
  final newRating = TextFieldBloc();

  StoreReviewFormBloc(this.jobModel) {
    
    addFieldBlocs(fieldBlocs: [
      newComment,
      newRating,
    ]);
  }
  @override
  Future<void> onSubmitting() async {
    try {
      print("calling API");
      ReviewNurseRequestModel reviewNurseRequestModel =
          ReviewNurseRequestModel();

      reviewNurseRequestModel.comment = newComment.value;
      reviewNurseRequestModel.rating = int.parse(newRating.value);
      reviewNurseRequestModel.photoPath = newFormalPhoto1;

      //Call API
      DefaultResponseModel responseModel =
          await feedbackBloc.storeReview(jobModel.id!, reviewNurseRequestModel);

      if (responseModel.isSuccess) {
        emitSuccess(successResponse: responseModel.data!);
      } else {
        print(responseModel.message);
      }
    } catch (exception) {
      emitFailure(failureResponse: exception.toString());
    }
  }
}
