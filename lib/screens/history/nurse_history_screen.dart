import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/screens/edit_profile/edit_profile_screen.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_app_bar.dart';
import 'package:private_nurse_for_client/screens/history/components/nurse_history_list.dart';
import 'package:private_nurse_for_client/theme.dart';

class NurseHistoryScreen extends StatefulWidget {
  const NurseHistoryScreen({super.key});

  @override
  State<NurseHistoryScreen> createState() => _NurseHistoryScreenState();
}

//List of history items
class _NurseHistoryScreenState extends State<NurseHistoryScreen> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
//nurse profile pic
  String src =
      "https://c4.wallpaperflare.com/wallpaper/246/739/689/digital-digital-art-artwork-illustration-abstract-hd-wallpaper-preview.jpg";

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              //list of history
              child: NurseHistoryList(
                src: src,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
