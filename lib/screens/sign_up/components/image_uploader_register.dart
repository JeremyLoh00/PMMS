import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:file_picker/file_picker.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/register_client_form_bloc.dart';


class CircleImageUploader extends StatefulWidget {
  final Function(XFile) onImageSelected;
  final RegisterClientFormBloc formBloc;

  CircleImageUploader({required this.onImageSelected, required this.formBloc});

  @override
  _CircleImageUploaderState createState() => _CircleImageUploaderState();
}

class _CircleImageUploaderState extends State<CircleImageUploader> {
  String? _selectedImagePath;

  @override
  void initState() {
    super.initState();
    print(widget.formBloc.newProfilePhoto);
    if (widget.formBloc.newProfilePhoto != null) {
      _selectedImagePath = widget.formBloc.newProfilePhoto!.path;
    }
  }

  Future<void> _selectAndUploadImage() async {
    List<XFile>? selectedImages = await selectImages();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      setImageToCircle(selectedImages[0], widget.onImageSelected);
    }
  }

  Future<List<XFile>?> selectImages() async {
    try {
      FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg',],
      );

      if (pickedFile != null) {
        return [XFile(pickedFile.files.single.path!)];
      }
    } catch (e) {
      print('Error selecting PDF file: $e');
    }

    return null;
  }

  void setImageToCircle(XFile selectedImage, Function(XFile) onImageSelected) {
    setState(() {
      _selectedImagePath = selectedImage.path;
      onImageSelected(selectedImage);
      widget.formBloc.newProfilePhoto = selectedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(150),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              ScaleTap(
                onPressed: widget.formBloc.newProfilePhoto != null
                    ? () async {
                        await OpenFilex.open(_selectedImagePath!);
                        return [XFile(_selectedImagePath!)];
                      }
                    : null,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                    image: _selectedImagePath != null
                        ? DecorationImage(
                            image: FileImage(File(_selectedImagePath!)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _selectedImagePath == null
                      ? Icon(Icons.person, size: 60, color: Colors.grey[800])
                      : null,
                ),
              ),
              Positioned(
                bottom: 0,
                child: ScaleTap(
                  onPressed: () async {
                    widget.formBloc.newProfilePhoto != null // if have image
                        ? setState(() {
                            _selectedImagePath = null;

                            widget.formBloc.newProfilePhoto = null;
                          })
                        : _selectAndUploadImage();

                    print("upload photo");
                  },
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          widget.formBloc.newProfilePhoto !=
                                  null // if have image
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
        ),
        // _selectedImage == null
        //     ? const Padding(
        //         padding: EdgeInsets.only(top: 10),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Text(
        //               "Profile photo is required",
        //               style: TextStyle(
        //                 color: kDanger,
        //                 fontSize: 12,
        //               ),
        //             ),
        //           ],
        //         ),
        //       )
        //     : Container(),
      ],
    );
  }
}