// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_scale_tap/flutter_scale_tap.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:open_filex/open_filex.dart';
// import 'package:private_nurse_for_client/constant.dart';
// import 'package:private_nurse_for_client/form_bloc/store_job_form_bloc.dart';
// import 'package:path/path.dart' as path;
// import 'package:private_nurse_for_client/public_components/space.dart';

// class InputFormalPhoto extends StatefulWidget {
//   final Function(XFile) onImageFormalSelected;
//   final StoreJobFormBloc formBloc;
//   const InputFormalPhoto(
//       {super.key, required this.onImageFormalSelected, required this.formBloc});

//   @override
//   State<InputFormalPhoto> createState() => _InputFormalPhotoState();
// }

// class _InputFormalPhotoState extends State<InputFormalPhoto> {
//   String imageFileName = "NRIC Photo (required)";
//   String? _selectedFormalImage1;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.formBloc.newFormalPhoto1 != null) {
//       _selectedFormalImage1 = widget.formBloc.newFormalPhoto1!.path;
//       imageFileName = path.basename(_selectedFormalImage1!);
//     }
//   }

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
//         allowedExtensions: [
//           'png',
//           'jpg',
//           'jpeg',
//         ],
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
//       _selectedFormalImage1 = selectedFormalImage1.path;
//       onImageSelected(selectedFormalImage1);
//       imageFileName = path.basename(selectedFormalImage1.path);
//       print(path.basename(selectedFormalImage1.path));
//       widget.formBloc.newFormalPhoto1 = selectedFormalImage1;
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
//                     await OpenFilex.open(_selectedFormalImage1!);
//                     return [XFile(_selectedFormalImage1!)];
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
//                                 imageFileName = "Formal Photo 1 (required)";
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
//               size: 20,
//             ),
//             SizedBox(
//               width: 5,
//             ),
//             Expanded(
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   color: kSecondaryColor,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
