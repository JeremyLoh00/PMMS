import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/input_decoration%20copy.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/screens/subscription/components/current_subscription_screen.dart';

import '../../theme.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

enum SingingCharacter { six, twelve }

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  SingingCharacter? _character = SingingCharacter.six;
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
               Container(
                padding: EdgeInsets.only(right: 20),
                // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kPrimary100Color,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kPrimaryColor),
                ),
                child: Row(
                  // row for 2 column: image and column
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('6 Months', style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold,),),
                        subtitle: Text("RM23/Month", style: TextStyle(color: kPrimaryColor),),
                        leading: Radio<SingingCharacter>(
                          fillColor: MaterialStateColor.resolveWith((states) => kPrimaryColor),
                          value: SingingCharacter.six,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Text(
                      "RM126",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.only(right: 20),
                // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  // row for 2 column: image and column
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('12 Months', style: TextStyle(fontWeight: FontWeight.bold,),),
                        subtitle: Text("RM17/Month"),
                        leading: Radio<SingingCharacter>(
                          fillColor: MaterialStateColor.resolveWith((states) => kPrimaryColor),
                          value: SingingCharacter.twelve,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Text(
                      "RM204",
                      style: TextStyle(
                        color: kBlack,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ButtonPrimary(
                "Subscribe",
                onPressed: () => {navigateTo(context, CurrentSubscriptionScreen())},
              )
            ],
          ),
        ),
      )),
    );
  }
}
