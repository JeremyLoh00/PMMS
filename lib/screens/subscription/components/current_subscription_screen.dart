import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/input_decoration%20copy.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_app_bar.dart';

class CurrentSubscriptionScreen extends StatefulWidget {
  const CurrentSubscriptionScreen({super.key});

  @override
  State<CurrentSubscriptionScreen> createState() =>
      _CurrentSubscriptionScreenState();
}

class _CurrentSubscriptionScreenState extends State<CurrentSubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: kWhite,
          appBar: ThemeAppBar("Subscription"),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    // padding: EdgeInsets.only(right: 20),
                    // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: kWhite),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current Subscription",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: kPrimaryColor,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "3 Months 12 days",
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "6 month plan",
                                          style: TextStyle(
                                            color: kBlack,
                                          ),
                                        ),
                                        SizedBox(width: 100,),
                                        Text(
                                          "due at 25/12/2023",
                                          style: TextStyle(
                                              color: kGrey, fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
