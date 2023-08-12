import 'dart:async';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/custom_dialog.dart';
import 'package:private_nurse_for_client/public_components/theme_app_bar.dart';
import 'package:private_nurse_for_client/screens/payment_gateway/components/body.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGatewayScreen extends StatefulWidget {
  final String billId;
  final String titlePage;
  final Future<void> Function()? callbackGetData;

  const PaymentGatewayScreen({
    super.key,
    required this.billId,
    this.callbackGetData, required this.titlePage,
  });

  @override
  State<PaymentGatewayScreen> createState() => _PaymentGatewayScreenState();
}

class _PaymentGatewayScreenState extends State<PaymentGatewayScreen> {
  String transactionStatus = TransactionStatus.pending;
  WebViewController? webViewController;
  final bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(widget.titlePage),
      body: Body(
        billId: widget.billId,
        callBackSetWebViewController: (WebViewController wb) {
          // Set the web view controller
          webViewController = wb;
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
        child: Row(
          children: [
            Expanded(
              child: ButtonPrimary(
                "Validate Payment",
                onPressed: () async {
                  // Get url from the payment gateway url
                  await validatePayment(context);
                },
                isLoading: _isLoading,
                loadingText: "Validating",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> validatePayment(BuildContext context) async {
    // Get url from the payment gateway url
    String? url = await webViewController?.currentUrl();

    if (url != null) {
      var uri = Uri.dataFromString(url); //converts string to a uri
      // Get status from the params
      Map<String, String> params =
          uri.queryParameters; // query parameters automatically populated
      transactionStatus = params['status_id'] ?? TransactionStatus.fail;
    }

    if (transactionStatus == TransactionStatus.success) {
      if (mounted) {
        CustomDialog.show(
          context,
          dismissOnTouchOutside: false,
          title: "Payment Success",
          description:
              "Thank you, your payment was received successfully, you may apply job now",
          btnOkText: "Okay",
          btnOkOnPress: () {
            // Navigator.of(context).pushAndRemoveUntil(
            //     MaterialPageRoute(builder: (c) => Navigation()),
            //     (route) => false);
            // pop dialogue
            // go to payment step
            // go to job details
            Navigator.pop(context);
            Navigator.pop(context);
            widget.callbackGetData!();
          },
          icon: Iconsax.check,
          dialogType: DialogType.success,
        );
      }
    } else {
      if (mounted) {
        CustomDialog.show(
          context,
          dismissOnTouchOutside: false,
          title: "Payment Incomplete",
          description: "Please follow the instructions on the screen.",
          btnOkText: "Okay",
          btnOkOnPress: () => Navigator.of(context).pop(),
          icon: FontAwesomeIcons.exclamation,
          dialogType: DialogType.danger,
        );
      }
    }
  }
}
