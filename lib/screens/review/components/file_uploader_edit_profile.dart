import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path;
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/store_review_form_bloc.dart';
import 'package:private_nurse_for_client/models/feedback/feedback_model.dart';

class ImageUploader extends StatefulWidget {
  final StoreReviewFormBloc formBloc;
  final Function(XFile) onImageSelected;
  final FeedbackModel feedbackModel;
  final Object heroTag;
  const ImageUploader(
      {super.key,
      required this.formBloc,
      required this.onImageSelected,
      required this.feedbackModel,
      required this.heroTag});

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  XFile? _selectedImage;

  Future<void> _selectAndUploadImage() async {
    List<XFile>? selectedImages = await selectImages();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      setImageToCircle(selectedImages[0], widget.onImageSelected);
    }
  }

  Future<List<XFile>?> selectImages() async {
    try {
      if (Platform.isIOS) {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          return [pickedFile];
        }
      } else {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          return [pickedFile];
        }
      }
    } catch (e) {
      print('Error selecting image: $e');
      return null;
    }
  }

  void setImageToCircle(XFile selectedImage, Function(XFile) onImageSelected) {
    setState(() {
      _selectedImage = selectedImage;
      onImageSelected(selectedImage);
      widget.formBloc.newFormalPhoto1= _selectedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // borderRadius: BorderRadius.circular(150),

      borderRadius: BorderRadius.circular(10),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: 125,
            height: 125,
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              color: Colors.grey[300],
              image: _selectedImage != null
                  ? DecorationImage(
                      image: FileImage(File(_selectedImage!.path)),
                      fit: BoxFit.cover)
                  : (widget.feedbackModel.feedbackPhotoPath != null
                      ? DecorationImage(
                          image: NetworkImage(widget.feedbackModel.feedbackPhotoPath!.toString()),
                          fit: BoxFit.cover,
                        )
                      : null),

              // image: _selectedImage != null
              //     ? DecorationImage(
              //         image: FileImage(File(_selectedImage!.path)),
              //         fit: BoxFit.cover,
              //       )
              //     : null,
            ),
            child: null,
          ),
          Positioned(
            bottom: 0,
            child: ScaleTap(
              onPressed: () async {
                widget.formBloc.newFormalPhoto1 != null // if have image
                    ? setState(() {
                        _selectedImage = null;

                        widget.formBloc.newFormalPhoto1 = null;
                      })
                    : _selectAndUploadImage();

                print("upload photo");
              },
              child: Container(
                width: 150,
                height: 30,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.formBloc.newFormalPhoto1 != null // if have image
                          ? Icons.cancel
                          : Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UploadButton extends StatelessWidget {
  const UploadButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: kSecondaryColor),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: kSecondaryColor,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: kSecondaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
