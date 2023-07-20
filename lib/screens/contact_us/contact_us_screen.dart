import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/bloc/payment_controller.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/input_decoration%20copy.dart';
import 'package:private_nurse_for_client/public_components/space.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(PaymentController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Get in Touch",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const Text(
                "You could contact us with other way like below",
                style: TextStyle(
                  color: kGrey,
                  fontWeight: FontWeight.normal,
                  //fontSize: 20,
                ),
              ),
              Space(20),
              details(
                icon: Iconsax.building_3,
                text:
                    "1, Lot 1499, Jalan Tun Abdul Rahman, Taman Abdul Rahman, 89999, Pekan Pahang",
              ),
              details(
                icon: Iconsax.call,
                text: "013236563478",
              ),
              details(
                icon: Iconsax.global,
                text: "www.Nurse2Home.com.my",
              ),
              details(
                icon: Iconsax.sms,
                text: "nurse2home@example.com",
              ),
              Space(20),
              Divider(
                thickness: 1,
                color: kGrey,
              ),
              Space(20),
              Text(
                "Write your inquiry here",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DelayedDisplay(
                delay: const Duration(milliseconds: 200),
                child: TextField(
                  cursorColor: kPrimaryColor,
                  textCapitalization: TextCapitalization.none,
                  decoration: textFieldInputDecoration(
                    "",
                    hintText: "Inquiry",
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ButtonPrimary(
                "Sumbit",
                onPressed: () {
                  controller.makePayment(context: context);
                },
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget details({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: kSecondaryColor,
            size: 20,
          ),
          const SizedBox(width: 15),
          Expanded(
              child: Text(
            text,
            style: const TextStyle(
              color: kBlack,
              fontWeight: FontWeight.w400,
            ),
          ))
        ],
      ),
    );
  }
}
