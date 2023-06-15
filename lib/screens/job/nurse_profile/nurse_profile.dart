import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/screens/job/nurse_profile/components/nurse_profile_description.dart';
import 'package:private_nurse_for_client/screens/job/nurse_profile/components/nurse_profile_header.dart';
import 'package:private_nurse_for_client/screens/profile/profile_screen.dart';

class NurseProfile extends StatefulWidget {
  final String src;
  const NurseProfile({
    super.key,
    required this.src,
  });

  @override
  State<NurseProfile> createState() => _NurseProfileState();
}

class _NurseProfileState extends State<NurseProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomScrollView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: double.infinity,
                        child: Hero(
                          tag: "contest-banner",
                          // child: Text("data"),
                          child: Container(
                            child: CachedNetworkImage(
                              imageUrl: widget.src,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      NurseProfileHeader(
                        title: "Wound Dressing",
                        name: "Mr. John Doe",
                        sufname: "(Son)",
                        phoneNum: "012-3456789",
                      ),
                      Divider(
                        color: kGrey,
                        thickness: 0.5,
                      ),
                      const SizedBox(height: 15.0),

                      //Description
                      NurseProfileDescription(
                          description:
                              "Rorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum."),
                      const SizedBox(height: 15.0),

                      const SizedBox(height: 15.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
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
      actions: [
        ScaleTap(
          onPressed: () {
            navigateTo(context, ProfileScreen());
          },
          child: Padding(
            padding: EdgeInsets.only(right: 15),
            child: Container(
              width: 25,
              height: 25,
              padding: const EdgeInsets.all(0.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CachedNetworkImage(
                imageUrl: widget.src,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        ScaleTap(
          onPressed: () {
            print("notification");
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Iconsax.notification,
              color: kDarkGrey,
            ),
          ),
        ),
      ],
    );
  }
}
