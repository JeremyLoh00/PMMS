// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_scale_tap/flutter_scale_tap.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:nursing_home_client/constant.dart';
// import 'package:nursing_home_client/form_bloc/edit_profile_form_bloc.dart';
// import 'package:nursing_home_client/models/user/user_model.dart';
// import 'package:nursing_home_client/public_components/space.dart';
// import 'package:open_filex/open_filex.dart';
// import 'package:path/path.dart' as path;

// class ImageUploader extends StatefulWidget {
//   final EditProfileFormBloc formBloc;
//   final Function(XFile) onImageSelected;
//   final UserModel userModel;
//   final Object heroTag;
//   const ImageUploader(
//       {super.key,
//       required this.formBloc,
//       required this.onImageSelected,
//       required this.userModel,
//       required this.heroTag});

//   @override
//   State<ImageUploader> createState() => _ImageUploaderState();
// }

// class _ImageUploaderState extends State<ImageUploader> {
//   XFile? _selectedImage;

//   Future<void> _selectAndUploadImage() async {
//     List<XFile>? selectedImages = await selectImages();
//     if (selectedImages != null && selectedImages.isNotEmpty) {
//       setImageToCircle(selectedImages[0], widget.onImageSelected);
//     }
//   }

//   Future<List<XFile>?> selectImages() async {
//     try {
//       if (Platform.isIOS) {
//         final picker = ImagePicker();
//         final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//         if (pickedFile != null) {
//           return [pickedFile];
//         }
//       } else {
//         final picker = ImagePicker();
//         final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//         if (pickedFile != null) {
//           return [pickedFile];
//         }
//       }
//     } catch (e) {
//       print('Error selecting image: $e');
//       return null;
//     }
//   }

//   void setImageToCircle(XFile selectedImage, Function(XFile) onImageSelected) {
//     setState(() {
//       _selectedImage = selectedImage;
//       onImageSelected(selectedImage);
//       widget.formBloc.newProfilePhoto = _selectedImage;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(150),
//       child: Stack(
//         alignment: AlignmentDirectional.center,
//         children: [
//           Container(
//             width: 125,
//             height: 125,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.grey[300],
//               image: _selectedImage != null
//                   ? DecorationImage(
//                       image: FileImage(File(_selectedImage!.path)),
//                       fit: BoxFit.cover)
//                   : (widget.userModel.profilePhoto != null
//                       ? DecorationImage(
//                           image: NetworkImage(widget.userModel.profilePhoto!),
//                           fit: BoxFit.cover,
//                         )
//                       : null),

//               // image: _selectedImage != null
//               //     ? DecorationImage(
//               //         image: FileImage(File(_selectedImage!.path)),
//               //         fit: BoxFit.cover,
//               //       )
//               //     : null,
//             ),
//             child:
//                 _selectedImage != null && widget.userModel.profilePhoto == null
//                     ? Icon(Icons.person, size: 60, color: Colors.grey[800])
//                     : null,
//           ),
//           Positioned(
//             bottom: 0,
//             child: ScaleTap(
//               onPressed: () async {
//                 widget.formBloc.newProfilePhoto != null // if have image
//                     ? setState(() {
//                         _selectedImage = null;

//                         widget.formBloc.newProfilePhoto = null;
//                       })
//                     : _selectAndUploadImage();

//                 print("upload photo");
//               },
//               child: Container(
//                 width: 150,
//                 height: 30,
//                 decoration: BoxDecoration(
//                   color: kPrimaryColor.withOpacity(0.4),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       widget.formBloc.newProfilePhoto != null // if have image
//                           ? Icons.cancel
//                           : Icons.camera_alt_rounded,
//                       color: Colors.white,
//                       size: 20,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class InputFormalPhoto1 extends StatefulWidget {
//   final Function(XFile) onImageFormalSelected;
//   final EditProfileFormBloc formBloc;
//   const InputFormalPhoto1(
//       {super.key, required this.onImageFormalSelected, required this.formBloc});

//   @override
//   State<InputFormalPhoto1> createState() => _InputFormalPhoto1State();
// }

// class _InputFormalPhoto1State extends State<InputFormalPhoto1> {
//   String imageFileName = "Formal Photo 1";
//   XFile? _selectedFormalImage1;

//   Future<void> _selectAndUploadImage() async {
//     List<XFile>? selectedImages = await selectFormalImages1();
//     if (selectedImages != null && selectedImages.isNotEmpty) {
//       setFormalImageToText(selectedImages[0], widget.onImageFormalSelected);
//     }
//   }

//   Future<List<XFile>?> selectFormalImages1() async {
//     try {
//       FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['png', 'jpg', 'jpeg', 'tiff', 'tif', 'bmp'],
//       );

//       if (pickedFile != null) {
//         return [XFile(pickedFile.files.single.path!)];
//       }
//     } catch (e) {
//       print('Error selecting PDF file: $e');
//     }

//     return null;
//   }

//   void setFormalImageToText(
//       XFile selectedFormalImage1, Function(XFile) onImageSelected) {
//     setState(() {
//       _selectedFormalImage1 = selectedFormalImage1;
//       onImageSelected(selectedFormalImage1);
//       imageFileName = path.basename(_selectedFormalImage1!.path);
//       widget.formBloc.newFormalPhoto1 = _selectedFormalImage1;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           flex: 3,
//           child: ScaleTap(
//             onPressed: widget.formBloc.newFormalPhoto1 != null
//                 ? () async {
//                     await OpenFilex.open(_selectedFormalImage1!.path);
//                     return [XFile(_selectedFormalImage1!.path)];
//                   }
//                 : null,
//             child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: kGrey.withOpacity(0.3),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         imageFileName,
//                         style: TextStyle(
//                             color: widget.formBloc.newFormalPhoto1 != null
//                                 ? kBlack
//                                 : kGrey),
//                       ),
//                     ),
//                     widget.formBloc.newFormalPhoto1 != null
//                         ? ScaleTap(
//                             onPressed: () {
//                               setState(() {
//                                 imageFileName = "Formal Photo 1";
//                                 _selectedFormalImage1 = null;
//                                 widget.formBloc.newFormalPhoto1 = null;
//                               });
//                             },
//                             child: Icon(
//                               Icons.cancel,
//                               color: kDarkGrey,
//                             ),
//                           )
//                         : Space(0)
//                   ],
//                 )),
//           ),
//         ),
//         SizedBox(width: 10),
//         Expanded(
//           flex: 1,
//           child: UploadButton(
//             icon: Icons.upload,
//             title: "Upload",
//             onPressed: () async {
//               _selectAndUploadImage();
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class InputFormalPhoto2 extends StatefulWidget {
//   final Function(XFile) onImageFormalSelected;
//   final EditProfileFormBloc formBloc;
//   const InputFormalPhoto2(
//       {super.key, required this.onImageFormalSelected, required this.formBloc});

//   @override
//   State<InputFormalPhoto2> createState() => _InputFormalPhoto2State();
// }

// class _InputFormalPhoto2State extends State<InputFormalPhoto2> {
//   String imageFileName = "Formal Photo 2";
//   XFile? _selectedFormalImage2;

//   Future<void> _selectAndUploadImage() async {
//     List<XFile>? selectedImages = await selectFormalImages2();
//     if (selectedImages != null && selectedImages.isNotEmpty) {
//       setFormalImageToText(selectedImages[0], widget.onImageFormalSelected);
//     }
//   }

//   Future<List<XFile>?> selectFormalImages2() async {
//     try {
//       FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['png', 'jpg', 'jpeg', 'tiff', 'tif', 'bmp'],
//       );

//       if (pickedFile != null) {
//         return [XFile(pickedFile.files.single.path!)];
//       }
//     } catch (e) {
//       print('Error selecting PDF file: $e');
//     }

//     return null;
//   }

//   void setFormalImageToText(
//       XFile selectedFormalImage2, Function(XFile) onImageSelected) {
//     setState(() {
//       _selectedFormalImage2 = selectedFormalImage2;
//       onImageSelected(selectedFormalImage2);
//       imageFileName = path.basename(_selectedFormalImage2!.path);
//       widget.formBloc.newFormalPhoto2 = _selectedFormalImage2;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           flex: 3,
//           child: ScaleTap(
//             onPressed: widget.formBloc.newFormalPhoto2 != null
//                 ? () async {
//                     await OpenFilex.open(_selectedFormalImage2!.path);
//                     return [XFile(_selectedFormalImage2!.path)];
//                   }
//                 : null,
//             child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: kGrey.withOpacity(0.3),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         imageFileName,
//                         style: TextStyle(
//                             color: widget.formBloc.newFormalPhoto2 != null
//                                 ? kBlack
//                                 : kGrey),
//                       ),
//                     ),
//                     widget.formBloc.newFormalPhoto2 != null
//                         ? ScaleTap(
//                             onPressed: () {
//                               setState(() {
//                                 imageFileName = "Formal Photo 2";
//                                 _selectedFormalImage2 = null;
//                                 widget.formBloc.newFormalPhoto2 = null;
//                               });
//                             },
//                             child: Icon(
//                               Icons.cancel,
//                               color: kDarkGrey,
//                             ),
//                           )
//                         : Space(0)
//                   ],
//                 )),
//           ),
//         ),
//         SizedBox(width: 10),
//         Expanded(
//           flex: 1,
//           child: UploadButton(
//             icon: Icons.upload,
//             title: "Upload",
//             onPressed: () async {
//               _selectAndUploadImage();
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class InputPassportPhoto extends StatefulWidget {
//   final Function(XFile) onImageFormalSelected;
//   final EditProfileFormBloc formBloc;
//   const InputPassportPhoto(
//       {super.key, required this.onImageFormalSelected, required this.formBloc});

//   @override
//   State<InputPassportPhoto> createState() => _InputPassportPhotoState();
// }

// class _InputPassportPhotoState extends State<InputPassportPhoto> {
//   String imageFileName = "NRIC/Passport proof Front and Back (PDF)";
//   XFile? _selectedPassportPhoto;

//   Future<void> _selectAndUploadImage() async {
//     List<XFile>? selectedImages = await selectPassportPhoto();
//     if (selectedImages != null && selectedImages.isNotEmpty) {
//       setPassportPhotoToText(selectedImages[0], widget.onImageFormalSelected);
//     }
//   }

//   Future<List<XFile>?> selectPassportPhoto() async {
//     try {
//       FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf'],
//       );

//       if (pickedFile != null) {
//         return [XFile(pickedFile.files.single.path!)];
//       }
//     } catch (e) {
//       print('Error selecting PDF file: $e');
//     }
//   }

//   void setPassportPhotoToText(
//       XFile selectedPassportPhoto, Function(XFile) onImageSelected) {
//     setState(() {
//       _selectedPassportPhoto = selectedPassportPhoto;
//       onImageSelected(selectedPassportPhoto);
//       imageFileName = path.basename(_selectedPassportPhoto!.path);
//       widget.formBloc.newPassportPhoto = _selectedPassportPhoto;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           flex: 3,
//           child: ScaleTap(
//             onPressed: widget.formBloc.newPassportPhoto != null
//                 ? () async {
//                     await OpenFilex.open(_selectedPassportPhoto!.path);
//                     return [XFile(_selectedPassportPhoto!.path)];
//                   }
//                 : null,
//             child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: kGrey.withOpacity(0.3),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         imageFileName,
//                         style: TextStyle(
//                             color: widget.formBloc.newPassportPhoto != null
//                                 ? kBlack
//                                 : kGrey),
//                       ),
//                     ),
//                     widget.formBloc.newPassportPhoto != null
//                         ? ScaleTap(
//                             onPressed: () {
//                               setState(() {
//                                 imageFileName =
//                                     "NRIC/Passport proof Front and Back (PDF)";
//                                 _selectedPassportPhoto = null;
//                                 widget.formBloc.newPassportPhoto = null;
//                               });
//                             },
//                             child: Icon(
//                               Icons.cancel,
//                               color: kDarkGrey,
//                             ),
//                           )
//                         : Space(0)
//                   ],
//                 )),
//           ),
//         ),
//         SizedBox(width: 10),
//         Expanded(
//           flex: 1,
//           child: UploadButton(
//             icon: Icons.upload,
//             title: "Upload",
//             onPressed: () async {
//               _selectAndUploadImage();
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class InputNurseAssistantCertificate extends StatefulWidget {
//   final Function(XFile) onImageFormalSelected;
//   final EditProfileFormBloc formBloc;
//   const InputNurseAssistantCertificate(
//       {super.key, required this.onImageFormalSelected, required this.formBloc});

//   @override
//   State<InputNurseAssistantCertificate> createState() =>
//       _InputNurseAssistantCertificateState();
// }

// class _InputNurseAssistantCertificateState
//     extends State<InputNurseAssistantCertificate> {
//   String pdfFileName = "Nurse Assistant Certificate (PDF)";
//   XFile? _selectedPDF;

//   Future<void> _selectAndUploadPDF() async {
//     List<XFile>? selectedPDF = await selectPDF();
//     if (selectedPDF != null && selectedPDF.isNotEmpty) {
//       setPDFText(selectedPDF[0], widget.onImageFormalSelected);
//     }
//   }

//   Future<List<XFile>?> selectPDF() async {
//     try {
//       FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf'],
//       );

//       if (pickedFile != null) {
//         return [XFile(pickedFile.files.single.path!)];
//       }
//     } catch (e) {
//       print('Error selecting PDF file: $e');
//     }

//     return null;
//   }

//   void setPDFText(XFile selectedPDF, Function(XFile) onPDFSelected) {
//     setState(() {
//       _selectedPDF = selectedPDF;
//       onPDFSelected(selectedPDF);
//       pdfFileName = path.basename(_selectedPDF!.path);
//       widget.formBloc.nurseAssistanceCertificate = _selectedPDF;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           flex: 3,
//           child: ScaleTap(
//             onPressed: widget.formBloc.nurseAssistanceCertificate != null
//                 ? () async {
//                     await OpenFilex.open(_selectedPDF!.path);
//                     return [XFile(_selectedPDF!.path)];
//                   }
//                 : null,
//             child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: kGrey.withOpacity(0.3),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         pdfFileName,
//                         style: TextStyle(
//                             color: widget.formBloc.nurseAssistanceCertificate !=
//                                     null
//                                 ? kBlack
//                                 : kGrey),
//                       ),
//                     ),
//                     widget.formBloc.nurseAssistanceCertificate != null
//                         ? ScaleTap(
//                             onPressed: () {
//                               setState(() {
//                                 pdfFileName =
//                                     "Nurse Assistant Certificate (PDF)";
//                                 _selectedPDF = null;
//                                 widget.formBloc.nurseAssistanceCertificate =
//                                     null;
//                               });
//                             },
//                             child: Icon(
//                               Icons.cancel,
//                               color: kDarkGrey,
//                             ),
//                           )
//                         : Space(0)
//                   ],
//                 )),
//           ),
//         ),
//         SizedBox(width: 10),
//         Expanded(
//           flex: 1,
//           child: UploadButton(
//             icon: Icons.upload,
//             title: "Upload",
//             onPressed: () async {
//               _selectAndUploadPDF();
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ResumePDF extends StatefulWidget {
//   final Function(XFile) onImageFormalSelected;
//   final EditProfileFormBloc formBloc;
//   const ResumePDF(
//       {super.key, required this.onImageFormalSelected, required this.formBloc});

//   @override
//   State<ResumePDF> createState() => _ResumePDFState();
// }

// class _ResumePDFState extends State<ResumePDF> {
//   String pdfFileName = "Resume (PDF)";
//   XFile? _selectedPDF;

//   Future<void> _selectAndUploadPDF() async {
//     List<XFile>? selectedPDF = await selectPDF();
//     if (selectedPDF != null && selectedPDF.isNotEmpty) {
//       setPDFText(selectedPDF[0], widget.onImageFormalSelected);
//     }
//   }

//   Future<List<XFile>?> selectPDF() async {
//     try {
//       FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf'],
//       );

//       if (pickedFile != null) {
//         return [XFile(pickedFile.files.single.path!)];
//       }
//     } catch (e) {
//       print('Error selecting PDF file: $e');
//     }

//     return null;
//   }

//   void setPDFText(XFile selectedPDF, Function(XFile) onPDFSelected) {
//     setState(() {
//       _selectedPDF = selectedPDF;
//       onPDFSelected(selectedPDF);
//       pdfFileName = path.basename(_selectedPDF!.path);
//       widget.formBloc.resumePDF = _selectedPDF;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           flex: 3,
//           child: ScaleTap(
//             onPressed: widget.formBloc.resumePDF != null
//                 ? () async {
//                     await OpenFilex.open(_selectedPDF!.path);
//                     return [XFile(_selectedPDF!.path)];
//                   }
//                 : null,
//             child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: kGrey.withOpacity(0.3),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         pdfFileName,
//                         style: TextStyle(
//                             color: widget.formBloc.resumePDF != null
//                                 ? kBlack
//                                 : kGrey),
//                       ),
//                     ),
//                     widget.formBloc.resumePDF != null
//                         ? ScaleTap(
//                             onPressed: () {
//                               setState(() {
//                                 pdfFileName = "Resume (PDF)";
//                                 _selectedPDF = null;
//                                 widget.formBloc.resumePDF = null;
//                               });
//                             },
//                             child: Icon(
//                               Icons.cancel,
//                               color: kDarkGrey,
//                             ),
//                           )
//                         : Space(0)
//                   ],
//                 )),
//           ),
//         ),
//         SizedBox(width: 10),
//         Expanded(
//           flex: 1,
//           child: UploadButton(
//             icon: Icons.upload,
//             title: "Upload",
//             onPressed: () async {
//               _selectAndUploadPDF();
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class UploadButton extends StatelessWidget {
//   const UploadButton({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.onPressed,
//   });

//   final IconData icon;
//   final String title;
//   final Function()? onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return ScaleTap(
//       onPressed: onPressed,
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(5),
//         decoration: BoxDecoration(
//           color: kWhite,
//           borderRadius: BorderRadius.circular(4),
//           border: Border.all(color: kSecondaryColor),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               icon,
//               color: kSecondaryColor,
//             ),
//             SizedBox(
//               width: 5,
//             ),
//             Expanded(
//               child: Text(
//                 title,
//                 style: TextStyle(color: kSecondaryColor),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
