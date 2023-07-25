import 'dart:async';

import 'package:form_bloc/form_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:private_nurse_for_client/helpers/validators.dart';
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

  final preferredWeek = SelectFieldBloc();

  final preferredDay = SelectFieldBloc();

  final serviceInfo = MultiSelectFieldBloc();

  final preferredNurse = SelectFieldBloc();

  final genderService = SelectFieldBloc();

  final raceService = SelectFieldBloc();

  final variants = ListFieldBloc<VariantFieldBloc, dynamic>(name: 'variants');

  @override
  FutureOr<void> onSubmitting() {
    // TODO: implement onSubmitting
    throw UnimplementedError();
  }

   void addVariant() {
    variants.addFieldBloc(VariantFieldBloc(
      name: 'variant',
      variantName: TextFieldBloc(name: 'variantName'),
      options: ListFieldBloc(name: 'options'),
    ));
  }

  void removeVariant(int index) {
    variants.removeFieldBlocAt(index);
  }
}
