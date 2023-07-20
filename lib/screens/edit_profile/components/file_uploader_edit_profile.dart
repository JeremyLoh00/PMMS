import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path;
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/edit_profile_form_bloc.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';

class ImageUploader extends StatefulWidget {
  final EditProfileFormBloc formBloc;
  final Function(XFile) onImageSelected;
  final UserModel userModel;
  final Object heroTag;
  const ImageUploader(
      {super.key,
      required this.formBloc,
      required this.onImageSelected,
      required this.userModel,
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
      widget.formBloc.newProfilePhoto = _selectedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(150),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: 125,
            height: 125,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
              image: _selectedImage != null
                  ? DecorationImage(
                      image: FileImage(File(_selectedImage!.path)),
                      fit: BoxFit.cover)
                  : (widget.userModel.profilePhoto != null
                      ? DecorationImage(
                          image: NetworkImage(widget.userModel.profilePhoto!),
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
            child:
                _selectedImage != null && widget.userModel.profilePhoto == null
                    ? Icon(Icons.person, size: 60, color: Colors.grey[800])
                    : null,
          ),
          Positioned(
            bottom: 0,
            child: ScaleTap(
              onPressed: () async {
                widget.formBloc.newProfilePhoto != null // if have image
                    ? setState(() {
                        _selectedImage = null;

                        widget.formBloc.newProfilePhoto = null;
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
                      widget.formBloc.newProfilePhoto != null // if have image
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
