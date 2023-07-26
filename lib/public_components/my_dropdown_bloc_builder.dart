import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/theme.dart';

// ignore: must_be_immutable
class MyDropdownBlocBuilder extends StatelessWidget {
  SelectFieldBloc selectFieldBloc;
  FieldItem Function(BuildContext, dynamic)? itemBuilder;
  final String? label;
  void Function(dynamic)? onChanged;

  MyDropdownBlocBuilder(
      {Key? key,
      required this.selectFieldBloc,
      this.itemBuilder,
      this.label,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    label!,
                    style: textStyleNormal(color: kBlack),
                  ),
                ],
              )
            : const SizedBox(),
        DropdownFieldBlocBuilder(
          onChanged: onChanged,
          showEmptyItem: false,
          selectFieldBloc: selectFieldBloc,
          itemBuilder: itemBuilder ??
              (context, itemData) => FieldItem(
                    child: DropdownMenuItem(
                      value: itemData.toString(),
                      child: Text(itemData.toString()),
                    ),
                  ),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: kTextGray),
              gapPadding: 10,
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: kPrimaryColor),
                gapPadding: 10),
            contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: kTextGray),
              gapPadding: 10,
            ),
            fillColor: Colors.white,
            filled: true,
            labelStyle: textStyleNormal(color: kTextGray),
          ),
        ),
      ],
    );
  }
}
