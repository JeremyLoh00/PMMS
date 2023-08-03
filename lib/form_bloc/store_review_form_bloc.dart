import 'dart:async';

import 'package:form_bloc/form_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:private_nurse_for_client/bloc/feedback_bloc.dart';
import 'package:private_nurse_for_client/helpers/validators.dart';
import 'package:private_nurse_for_client/models/feedback/feedback_model.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/job/job_store_response_model.dart';

class StoreReviewFormBloc extends FormBloc<String, String> {
  FeedbackBloc feedbackBloc = new FeedbackBloc();
  XFile? newFormalPhoto1;
  //Form key declaration and validations
  final newComment = TextFieldBloc(
    validators: [
      InputValidator.required,
    ],
  );
  final newRating = TextFieldBloc();

  StoreReviewFormBloc() {
    addFieldBlocs(fieldBlocs: [
      newComment,
      newRating,
    ]);
  }
  @override
  Future<void> onSubmitting() async {
    try {
      print("calling API");
      // Create model and insert all the necessary value
      FeedbackModel feedbackModel = FeedbackModel();
      feedbackModel.comment = newComment.value;
      feedbackModel.rating = int.parse(newRating.value);
      feedbackModel.feedbackPhotoPath = newFormalPhoto1;

      //Call API
      JobStoreResponseModel responseModel =
          await feedbackBloc.storeFeedback(feedbackModel);

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
