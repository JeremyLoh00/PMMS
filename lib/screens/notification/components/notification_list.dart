import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/theme.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({
    super.key,
    required this.src,
  });

  final String src;

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 5, // Replace with your actual item count
        itemBuilder: (context, index) {
          return ScaleTap(
            onPressed: () {
              // navigateTo(context, InformationDetailsScreen(selectedTabIndex: widget.selectedTabIndex,));
            },
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        margin: EdgeInsets.only(top: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(5),
                         
                        ),
                        child: Row(
                            // row for 2 column: image and column
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // image
                             
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      padding: const EdgeInsets.all(0.5),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: widget.src,
                                        imageBuilder: (context, imageProvider) =>
                                            Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                              
                             SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,      
                                  children: [
                                 RichText(
                                          text: new TextSpan(
                                            style: TextStyle(color: Colors.black),
                                            children: <TextSpan>[
                                              new TextSpan(
                                                text: "Your job",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              new TextSpan(
                                                  text: ' "Wound Dressing" ',
                                                  style: new TextStyle(
                                                      fontWeight: FontWeight.bold)),
                                              new TextSpan(
                                                text:
                                                    "has been accepted by Nurse Aida. ",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                                      
                                    Text("1 hour",
                                          style: TextStyle(
                                              color: kTextGray,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    // Space(10),
                                    // Expanded(
                                      // child: 
                                    // ),
                                  ],
                                ),
                              )
                            ])),
                            Divider(
                    thickness: 1,
                    color: kPrimary100Color,
                  ),
             
                  ],
                )),
          );
        });
  }
}
