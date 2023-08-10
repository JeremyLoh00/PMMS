import 'package:card_swiper/card_swiper.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/bloc/subscription_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/models/subscription/subscription_response_model.dart';
import 'package:private_nurse_for_client/models/subscription/subscription_model.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/space.dart';

class SubscriptionScreen extends StatefulWidget {
  final UserModel? userModel;
  final int? fromCustomeDialog;
  const SubscriptionScreen({super.key, this.userModel, this.fromCustomeDialog});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

enum SingingCharacter { six, twelve }

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late Future<SubscriptionModel> subscriptionModel;

  SubscriptionBloc subscriptionBloc = SubscriptionBloc();

  Future<SubscriptionModel> getSubscriptionList() async {
    SubscriptionResponseModel listSubscriptionResponseModel =
        await subscriptionBloc.getListSubcription();
    return listSubscriptionResponseModel.data!;
  }

  @override
  void initState() {
    subscriptionModel = getSubscriptionList();
    super.initState();
  }

  @override
  SingingCharacter? _character = SingingCharacter.six;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.fromCustomeDialog == 1 ? _buildAppBar() : null,
        body: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(children: [
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
              FutureBuilder<SubscriptionModel>(
                  future: subscriptionModel,
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Container(
                        height: 320,
                        child: Swiper(
                          itemCount: snapshot.data!.allPackages!.length,
                          itemHeight: 50,
                          itemWidth: 50,
                          viewportFraction: 0.8,
                          scale: 0.85,
                          itemBuilder: (
                            context,
                            index,
                          ) {
                            return Container(
                              width: 255,
                              height: 313,
                              padding: const EdgeInsets.all(20),
                              decoration: ShapeDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.85, -0.52),
                                  end: Alignment(-0.85, 0.52),
                                  colors: [
                                    Color(0xD8146D88),
                                    Color(0xC926BE7E)
                                  ],
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
                                    snapshot.data!.allPackages![index].name!,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "RM ",
                                                style: TextStyle(
                                                  color: Color(0xF2F3FCD1),
                                                  fontSize: 32,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  height: 0.77,
                                                ),
                                              ),
                                              TextSpan(
                                                text: snapshot
                                                    .data!
                                                    .allPackages![index]
                                                    .monthlyPrice,
                                                style: TextStyle(
                                                  color: Color(0xF2F3FCD1),
                                                  fontSize: 32,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  height: 0.77,
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
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "RM ",
                                                style: TextStyle(
                                                  color: Color(0xF2F3FCD1),
                                                  fontSize: 11,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 2.23,
                                                ),
                                              ),
                                              TextSpan(
                                                text: snapshot.data!
                                                    .allPackages![index].price!,
                                                style: TextStyle(
                                                  color: Color(0xFFF4F4F4),
                                                  fontSize: 11,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 2.23,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' in total',
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
                                      ],
                                    ),
                                  ),
                                  Space(20),
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              child: Text(
                                                snapshot
                                                    .data!
                                                    .allPackages![index]
                                                    .description!,
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
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        child: Text("NO data"),
                      );
                    }
                  })
            ])),
      );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text("Subscription"),
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
