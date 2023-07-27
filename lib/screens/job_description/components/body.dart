import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/screens/job_description/components/job_description_detail.dart';
import 'package:private_nurse_for_client/screens/job_description/components/nurse_application.dart';
import 'package:private_nurse_for_client/screens/job_description/components/patient.dart';

class Body extends StatefulWidget {
  final String src;
  final String title;
  final double price;
  final String status;
  final String name;
  final String phoneNum;
  final String city;
  final String address;
  final String startDate;
  final String startTime;
  final String endDate;
  final String endTime;

  Body({
    Key? key,
    required this.src,
    required this.title,
    required this.price,
    required this.status,
    required this.name,
    required this.phoneNum,
    required this.city,
    required this.address,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

//Main tables page
class _BodyState extends State<Body> {
  Color borderColor = Colors.grey.withOpacity(0.5);
  Color sectionColor = Colors.black;
  int selectedMenu = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
            color: kWhite,
            child: Column(children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: CachedNetworkImage(
                    imageUrl: widget.src,
                    imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
              ),
              //Detail container
              Stack(clipBehavior: Clip.none, children: [
                Container(height: 700,),
                Positioned(
                  top: MediaQuery.of(context).size.height * .12 -
                      (MediaQuery.of(context).size.width * .4),
                  left: 15,
                  right: 15,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kWhite,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: -4,
                          blurRadius: 30,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    width: 350,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Title of job
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              color: kPrimaryColor,
                            ),
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: kWhite),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //Job detail description
                          JobDescriptionDetail(
                              src: widget.src,
                              title: widget.title,
                              price: widget.price,
                              status: widget.status,
                              name: widget.name,
                              phoneNum: widget.phoneNum,
                              city: widget.city,
                              address: widget.address,
                              startDate: widget.startDate,
                              startTime: widget.startTime,
                              endDate: widget.endDate,
                              endTime: widget.endTime),
                          //Patient info
                          Patient(src: widget.src),
                          //Nurse applications info
                          NurseApplication(src: widget.src),
                        ]),
                  ),
                ),
              ]),
            ]),
          ),
        ),
    );
  }
}
