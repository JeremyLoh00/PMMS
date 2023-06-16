import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/button_secondary.dart';

class DeleteDialog extends StatefulBuilder {
  const DeleteDialog({Key? key, required StatefulWidgetBuilder builder})
      : super(key: key, builder: builder);

  static Future<void> show(
    BuildContext context, {
    StateSetter? stateSetter,
    bool dismissOnTouchOutside = true,
    bool isDissmissable = true,
    required final Function() onPressed,
  }) async {
    return await showDialog(
        barrierDismissible: isDissmissable,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setter) {
            stateSetter = setter;
            return WillPopScope(
              onWillPop: () async => isDissmissable,
              child: Dialog(
                insetPadding: const EdgeInsets.only(
                    left: 450, right: 450, top: 180, bottom: 180),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Header part
                        // Row(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Expanded(
                        //         child: Row(
                        //           children: [
                        //             Text(
                        //               AppLocalizations.of(context)!
                        //                   .confirmDelete,
                        //               style: TextStyle(
                        //                   fontSize: 20,
                        //                   fontWeight: FontWeight.bold),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ]),
                        // Divider(
                        //   color: Colors.grey.withOpacity(0.2),
                        //   thickness: 1,
                        // ),
                        const SizedBox(height: 10),

                        SingleChildScrollView(
                            //Content
                            child:
                                // content == null ? SizedBox(height: 0) : content,
                                Column(
                          children: [
                            const Icon(
                              Icons.warning_amber,
                              size: 30,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Confirm Delete",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        )),

                        //Footer
                        const SizedBox(height: 15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ButtonSecondary(
                                onPressed: (() {
                                  Navigator.of(context).pop();
                                }),
                                text: "Cancel",
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: ButtonPrimary(
                                "Confirm",
                                onPressed: onPressed,
                              ),
                            ),
                          ],
                        )
                      ]),
                ),
              ),
            );
          });
        });
  }
}
