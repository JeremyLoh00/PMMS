import 'dart:async';

import 'package:form_bloc/form_bloc.dart';
import 'package:private_nurse_for_client/helpers/validators.dart';

class StoreReviewFormBloc extends FormBloc<String, String> {
  //Form key declaration and validations
  final comment = TextFieldBloc(
    validators: [
      InputValidator.required,
    ],
  );

  @override
  FutureOr<void> onSubmitting() {
    // TODO: implement onSubmitting
    throw UnimplementedError();
  }
}
