import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:private_nurse_for_client/screens/job/create_job/components/field_bloc/option_field_bloc.dart';

class VariantFieldBloc extends GroupFieldBloc {
  final int? id;
  final TextFieldBloc prefferedStartTime;
  final TextFieldBloc duration;

  VariantFieldBloc({
    required this.prefferedStartTime,
    required this.duration,
    String? name,
    this.id,
  }) : super(name: name, fieldBlocs: [
          prefferedStartTime,
          duration,
        ]);
}
