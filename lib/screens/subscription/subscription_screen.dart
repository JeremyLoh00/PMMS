import 'package:card_swiper/card_swiper.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/bloc/subscription_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/helpers/http_response.dart';
import 'package:private_nurse_for_client/models/subscription/list_subscription_response_model.dart';
import 'package:private_nurse_for_client/models/subscription/subscription_filter_request_model.dart';
import 'package:private_nurse_for_client/models/subscription/subscription_model.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/input_decoration%20copy.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/screens/subscription/components/current_subscription_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../theme.dart';

class SubscriptionScreen extends StatefulWidget {
  final UserModel? userModel;
  const SubscriptionScreen({super.key, this.userModel});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

enum SingingCharacter { six, twelve }

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  SubscriptionBloc subscriptionBloc = SubscriptionBloc();
  SubscriptionFilterRequestModel subscriptionFilterRequestModel =
      SubscriptionFilterRequestModel();
  Future<void> _fetchPage(int pageKey) async {
    try {
      //Call API
      final ListSubscriptionResponseModel response =
          await subscriptionBloc.getListSubcription(
        subscriptionFilterRequestModel,
      );

      // If success
      if (response.statusCode == HttpResponse.HTTP_OK) {
        List<SubscriptionModel> listSubscriptionModel = response.data!;
      } else {
        print("No data");
      }
    } catch (error) {
      print("Server Error");
    }
  }

  @override
  void initState() {
    super.initState();
    subscriptionFilterRequestModel.take = 1;
  }

  @override
  SingingCharacter? _character = SingingCharacter.six;
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              'Subscription Plan',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Space(5),
            Text(
              'Subscribe to any plan below to start enjoy our services. ',
              style: TextStyle(color: kGrey),
            ),
            Space(20),
            Container(
              height: 313,
              child: 
              Swiper(
                itemBuilder: (context, index,) {
                  return Container(
                    width: 255,
                    height: 313,
                    padding: const EdgeInsets.all(20),
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.85, -0.52),
                        end: Alignment(-0.85, 0.52),
                        colors: [Color(0xD8146D88), Color(0xC926BE7E)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0xCE51C59A),
                          blurRadius: 24,
                          offset: Offset(5, 5),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '6-Month Plan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 1.23,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'RM 33',
                                      style: TextStyle(
                                        color: Color(0xF2F3FCD1),
                                        fontSize: 32,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        height: 0.77,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '.33',
                                      style: TextStyle(
                                        color: Color(0xF2F3FCD1),
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        height: 1.53,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '/month',
                                      style: TextStyle(
                                        color: Color(0xF2F3FCD1),
                                        fontSize: 10,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        height: 2.45,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'RM 200 in total',
                                style: TextStyle(
                                  color: Color(0xFFF4F4F4),
                                  fontSize: 11,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  height: 2.23,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Space(20),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 34,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          child: Text(
                                            'Description of the package will be shown here.',
                                            style: TextStyle(
                                              color: Color(0xFFF4F4F4),
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              height: 1.42,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Space(10),
                        ButtonPrimary(
                          "Subscibe",
                          onPressed: () {
                            // controller.makePayment(context: context);
                          },
                          primaryColor: kWhite,
                          titleColor: kPrimaryColor,
                        )
                        // Container(
                        //   width: double.infinity,
                        //   padding: const EdgeInsets.symmetric(vertical: 8),
                        //   decoration: ShapeDecoration(
                        //     color: Colors.white,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(20),
                        //     ),
                        //     shadows: [
                        //       BoxShadow(
                        //         color: Color(0x8422697F),
                        //         blurRadius: 16,
                        //         offset: Offset(2, 2),
                        //         spreadRadius: 0,
                        //       )
                        //     ],
                        //   ),
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.min,
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Text(
                        //         'Subscribe',
                        //         style: TextStyle(
                        //           color: Color(0xFF046380),
                        //           fontSize: 13,
                        //           fontFamily: 'Inter',
                        //           fontWeight: FontWeight.w600,
                        //           height: 1.54,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  );
                },
                itemCount: 10,
                itemHeight: 50,
                itemWidth: 50,
                viewportFraction: 0.8,
                scale: 0.8,
              ),
            ),
          ],
        ),
        // SingleChildScrollView(
        //   physics: const BouncingScrollPhysics(),
        //   child: Column(
        //     children: [
        //        Container(
        //         padding: EdgeInsets.only(right: 20),
        //         // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

        //         width: double.infinity,
        //         decoration: BoxDecoration(
        //           color: kPrimary100Color,
        //           borderRadius: BorderRadius.circular(10),
        //           border: Border.all(color: kPrimaryColor),
        //         ),
        //         child: Row(
        //           // row for 2 column: image and column
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Expanded(
        //               child: ListTile(
        //                 title: const Text('6 Months', style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold,),),
        //                 subtitle: Text("RM23/Month", style: TextStyle(color: kPrimaryColor),),
        //                 leading: Radio<SingingCharacter>(
        //                   fillColor: MaterialStateColor.resolveWith((states) => kPrimaryColor),
        //                   value: SingingCharacter.six,
        //                   groupValue: _character,
        //                   onChanged: (SingingCharacter? value) {
        //                     setState(() {
        //                       _character = value;
        //                     });
        //                   },
        //                 ),
        //               ),
        //             ),
        //             Text(
        //               "RM126",
        //               style: TextStyle(
        //                 color: kPrimaryColor,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       SizedBox(
        //         height: 15,
        //       ),
        //       Container(
        //         padding: EdgeInsets.only(right: 20),
        //         // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        //         width: double.infinity,
        //         decoration: BoxDecoration(
        //           color: kWhite,
        //           borderRadius: BorderRadius.circular(10),
        //         ),
        //         child: Row(
        //           // row for 2 column: image and column
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Expanded(
        //               child: ListTile(
        //                 title: const Text('12 Months', style: TextStyle(fontWeight: FontWeight.bold,),),
        //                 subtitle: Text("RM17/Month"),
        //                 leading: Radio<SingingCharacter>(
        //                   fillColor: MaterialStateColor.resolveWith((states) => kPrimaryColor),
        //                   value: SingingCharacter.twelve,
        //                   groupValue: _character,
        //                   onChanged: (SingingCharacter? value) {
        //                     setState(() {
        //                       _character = value;
        //                     });
        //                   },
        //                 ),
        //               ),
        //             ),
        //             Text(
        //               "RM204",
        //               style: TextStyle(
        //                 color: kBlack,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       SizedBox(
        //         height: 15,
        //       ),
        //       ButtonPrimary(
        //         "Subscribe",
        //         onPressed: () => {navigateTo(context, CurrentSubscriptionScreen())},
        //       )
        //     ],
        //   ),
        // ),
      )),
    );
  }
}
