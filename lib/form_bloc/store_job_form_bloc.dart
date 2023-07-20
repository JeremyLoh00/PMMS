import 'dart:async';

import 'package:form_bloc/form_bloc.dart';
import 'package:private_nurse_for_client/helpers/validators.dart';

class StoreJobFormBloc extends FormBloc<String, String> {
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

  final preferredWeek = SelectFieldBloc();

  final preferredDay = SelectFieldBloc();

  final serviceInfo = MultiSelectFieldBloc();

  final preferredNurse = SelectFieldBloc();

  final genderService = SelectFieldBloc();

  final raceService = SelectFieldBloc();

  @override
  FutureOr<void> onSubmitting() {
    // TODO: implement onSubmitting
    throw UnimplementedError();
  }
}
