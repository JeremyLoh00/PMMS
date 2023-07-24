import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class OptionFieldBloc extends GroupFieldBloc {
  final int? id;
  final TextFieldBloc option;
  final TextFieldBloc price;
  final TextFieldBloc cost;
  final TextFieldBloc sku;
  final TextFieldBloc barcode;

  OptionFieldBloc(
      {required this.option,
      required this.price,
      required this.cost,
      required this.sku,
      required this.barcode,
      String? name,
      this.id})
      : super(name: name, fieldBlocs: [option, price, cost, sku, barcode]);
}
