import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/public_components/input_decoration%20copy.dart';

class StyledDropdown<T> extends StatelessWidget {
  StyledDropdown({
    Key? key,
    required this.list,
    required this.setDropdownValue,
    required this.items,
    this.selected,
  }) : super(key: key);

  final List<T> list;
  final ValueSetter<T> setDropdownValue;
  final T? selected;
  final List<DropdownMenuItem<T>> items;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2<T>(
        isDense: true,
        isExpanded: true,
        enableFeedback: false,
        decoration: textFieldInputDecoration2(),
        value: selected,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: kDarkGrey,
          overflow: TextOverflow.ellipsis,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          elevation: 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          offset: const Offset(0, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(2),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        onChanged: (T? value) {
          // Set dropdown value when the user selects an item.
          setDropdownValue(value as T);
        },
        items: items,
      ),
    );
  }
}
