import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/public_components/space.dart';

class JobDescriptionDetail extends StatefulWidget {
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

  JobDescriptionDetail({
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
  State<JobDescriptionDetail> createState() => _JobDescriptionDetailState();
}

class _JobDescriptionDetailState extends State<JobDescriptionDetail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge status
                  Container(
                    width: 62,
                    padding: const EdgeInsets.symmetric(
                      vertical: 2.0,
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: kPrimary100Color,
                    ),
                    height: 20.0,
                    alignment: Alignment.center,
                    child: Text(
                      widget.status,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 10.0,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Space(15),
                  //Name and phone number
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.name,
                            style: TextStyle(
                                fontSize: 16,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold)),
                        Text(widget.phoneNum,
                            style: TextStyle(
                              color: kGrey,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              //Price
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Text("RM",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 5,
                      ),
                      Text(widget.price.toString(),
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Space(25),
          //Location
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: kPrimary100Color,
                ),
                height: 36.0,
                width: 36.0,
                alignment: Alignment.center,
                child: Icon(
                  Icons.location_on_outlined,
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.city,
                    style: TextStyle(
                        fontSize: 10,
                        color: kGrey,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600),
                  ),
                  Space(3),
                  Text(
                    widget.address,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Space(20),
          //Date and time
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: kPrimary100Color,
                ),
                height: 36.0,
                width: 36.0,
                alignment: Alignment.center,
                child: Icon(
                  Icons.schedule_outlined,
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.startDate,
                    style: TextStyle(
                        fontSize: 10,
                        color: kGrey,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600),
                  ),
                  Space(3),
                  Text(
                    widget.startTime,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Space(10),
                  Text(
                    widget.endDate,
                    style: TextStyle(
                        fontSize: 10,
                        color: kGrey,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600),
                  ),
                  Space(3),
                  Text(
                    widget.endTime,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
