import 'package:card_swiper/card_swiper.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:private_nurse_for_client/bloc/subscription_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/models/subscription/subscription_response_model.dart';
import 'package:private_nurse_for_client/models/subscription/subscription_model.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';

class SubscriptionScreen extends StatefulWidget {
  final int? fromCustomerDialog;
  const SubscriptionScreen({super.key, this.fromCustomerDialog});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool isLoading = false;
  SubscriptionModel _subscriptionModel = SubscriptionModel();

  SubscriptionBloc subscriptionBloc = SubscriptionBloc();

  @override
  void initState() {
    getSubscriptionList();
    super.initState();
  }

  Future<void> getSubscriptionList() async {
    setState(() {
      isLoading = true;
    });
    SubscriptionResponseModel responseModel =
        await subscriptionBloc.getListSubcription();
    setState(() {
      isLoading = false;
    });

    if (responseModel.isSuccess) {
      setState(() {
        _subscriptionModel = responseModel.data!;
      });
    } else {
      if (mounted) {
        ThemeSnackBar.showSnackBar(context, responseModel.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.fromCustomerDialog == 1 ? _buildAppBar() : null,
        body: isLoading
            ? Center(
                child: ThemeSpinner.spinner(),
              )
            : listSubscription(_subscriptionModel));
  }

  Widget listSubscription(SubscriptionModel model) {
    return Container(
      height: 400,
      child: Swiper(
        loop: false,
        itemCount: model.allPackages!.length,
        itemHeight: 50,
        itemWidth: 50,
        viewportFraction: 0.8,
        scale: 0.85,
        itemBuilder: (
          context,
          index,
        ) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                padding: const EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(vertical: 30),
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
                      model.allPackages![index].name!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
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
                                  text: model.allPackages![index].monthlyPrice,
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
                                  text: model.allPackages![index].price!,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Text(
                                  model.allPackages![index].description!,
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
                      "Subscribe",
                      onPressed: () {},
                      primaryColor: kWhite,
                      textColor: Color(0xD8146D88),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
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
