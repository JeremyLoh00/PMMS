import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';

class ViewFullImageScreen extends StatelessWidget {
  final String imageUrl;

  ViewFullImageScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: kWhite),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: PhotoView(
          loadingBuilder: (context, event) {
            return ThemeSpinner.spinner();
          },
          backgroundDecoration: BoxDecoration(color: Colors.black),
          imageProvider: NetworkImage(imageUrl),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
        ),
      ),
    );
  }
}
