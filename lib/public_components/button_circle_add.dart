import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';

class ButtonCircleAdd extends StatelessWidget {
  final Function()? onPressed;

  const ButtonCircleAdd({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: const Icon(Icons.add, color: kWhite, size: 28,),
      style: TextButton.styleFrom(
          foregroundColor: Colors.transparent,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15),
          backgroundColor: kPrimaryColor
          ),
    );
  }
}
