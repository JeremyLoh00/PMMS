import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';

class Payment extends StatefulWidget {
  JobModel jobModel;
  Payment({super.key, required this.jobModel});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String src =
      "https://c1.wallpaperflare.com/preview/547/839/590/accident-bleed-bleeding-bleeding-finger.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 25, right: 25),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Icon(
                Icons.wallet_outlined,
                color: kPrimaryColor,
                size: 100,
              ),
              Text(
                "Service Fee Payment",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                "Service Fee must be paid before proceed with the job. ",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "System Service Fee:",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.jobModel.systemServiceFee!,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontFamily: "Poppins",
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nursing Service Fee:",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.jobModel.nursingServiceFee!,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontFamily: "Poppins",
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total (RM):",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.jobModel.totalServiceFee!,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontFamily: "Poppins",
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: ButtonPrimary(
                  'PAY',
                  rounded: false,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
