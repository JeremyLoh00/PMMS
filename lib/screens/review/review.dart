import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/store_job_form_bloc.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/screens/review/components/inputFormalPhoto.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

List<String> listReason = [
  'Inexperienced candidate',
  'Skills needed not match',
  'Better candidates exist',
  'Others',
];
IconData? _selectedIcon;
  XFile? _selectedFormalImage1;

class _ReviewState extends State<Review> {
  String raasonOption = listReason[0];
  TextEditingController comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Give Your Comments",
                  style: TextStyle(
                      fontFamily: "Poppins", fontWeight: FontWeight.bold),
                ),
                Space(5),
                Text(
                  "Give rating and comment for this job based on the nurse’s performance",
                  style: TextStyle(color: kGrey),
                ),
                Space(10),
                Row(
                  children: [
                    Text(
                      "Rating: ",
                      style: TextStyle(
                          fontFamily: "Poppins", fontWeight: FontWeight.bold),
                    ),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20.0,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: kPrimaryColor,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    )
                  ],
                ),
                Space(10),
                Text(
                  "Comments: ",
                  style: TextStyle(
                      fontFamily: "Poppins", fontWeight: FontWeight.bold),
                ),
                Space(5),
                Container(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(),
                    child: TextFormField(
                      controller: comment,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      expands: true,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                        enabled: true,
                        hintText: 'Comments here....',
                        labelText: 'Comments',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Space(10.0),
                // InputFormalPhoto(
                //   formBloc: widget.storeJobFormBloc,
                //   onImageFormalSelected: (XFile selectedImage) {
                //     setState(() {
                //       _selectedFormalImage1 = selectedImage;
                //       // widget.storeJobFormBloc.newFormalPhoto = selectedImage;
                //     });
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ButtonPrimary(
          "Submit",
          onPressed: () {},
          rounded: false,
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Text(
        "Comment",
        style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.bold,
          color: kBlack,
        ),
      ),
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
