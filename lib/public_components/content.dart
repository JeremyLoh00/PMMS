import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:private_nurse_for_client/constant.dart';

class Content extends StatefulWidget {
  final Widget body;
  final bool darkMode;
  final bool? isFooterExtra;
  Widget? footer;
  final void Function()? onBackPressed;
  final void Function()? onTextPressed;

  Content(
      {Key? key,
      required this.body,
      this.onBackPressed,
      this.isFooterExtra,
      this.footer,
      this.darkMode = false,
      this.onTextPressed})
      : super(key: key);

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(widget.darkMode ? 0 : 20),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            // flex: widget.isFooterExtra == true ? 6 : 9,
            child: Container(
              child: widget.body,
            ),
          ),
          widget.footer == null
              ? SizedBox()
              :  Container(color: kWhite, child: widget.footer),
                
        ],
      ),
    );
  }
}
