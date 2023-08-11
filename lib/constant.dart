import 'dart:collection';

import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromRGBO(4, 99, 128, 1);
const kPrimary100Color = Color.fromRGBO(225, 244, 250, 1);
const kCompleted = Color.fromRGBO(6, 95, 70, 1);
const k100Completed = Color.fromRGBO(209, 250, 229, 1);
//TODO: change rootURL
const rootUrl = "https://private-nurse.mahirandigital.com/api/v1/";
const kSecondaryColor = Color.fromRGBO(4, 8, 116, 1);
const kLightBlue = Color.fromRGBO(244, 247, 255, 1);
const kDisabledText = Color.fromARGB(255, 152, 152, 152);
const kWhite = Colors.white;
const kLightGrey = Color.fromRGBO(204, 204, 204, 1);
const kGrey = Colors.grey;
const kDarkGrey = Color.fromRGBO(64, 64, 64, 1);
const kBlack = Colors.black;
const kBgColor = Color.fromARGB(255, 252, 252, 252);
const kTransparent = Colors.transparent;
const kPrimaryLight = Color.fromARGB(255, 238, 250, 246);
const kDanger = Color.fromARGB(255, 209, 0, 10);
const kDisabledBg = Color.fromARGB(255, 224, 224, 224);
const kPrimaryLightColor = Color.fromRGBO(241, 244, 250, 1.0);
const kTextGray = Color.fromRGBO(0, 0, 0, 0.40);

const pageSize = 10;

class DialogType {
  static const int info = 1;
  static const int danger = 2;
  static const int warning = 3;
  static const int success = 4;
}

// Success
const kBgSuccess = Color.fromRGBO(236, 253, 245, 1.0);
const kTextSuccess = kPrimaryColor;

// Danger
const kBgDanger = Color.fromRGBO(254, 242, 242, 1.0);
const kTextDanger = Color.fromRGBO(153, 27, 27, 1.0);

// Warning
const kBgWarning = Color.fromRGBO(255, 251, 235, 1.0);
const kTextWarning = Color.fromRGBO(188, 139, 20, 6);

// Info
const kBgInfo = Color.fromRGBO(236, 253, 245, 1.0);
const kTextInfo = kPrimaryColor;

//Badge status color
const kReviewBg = Color.fromRGBO(237, 233, 254, 1.0);
const kReviewText = Color.fromRGBO(91, 33, 182, 1.0);

const kOnGoingBg = Color.fromRGBO(219, 234, 254, 1.0);
const kOnGoingText = Color.fromRGBO(30, 64, 175, 1.0);

const kNurseApprovalBg = Color.fromRGBO(146, 64, 14, 1.0);
const kNurseApprovalText = Color.fromRGBO(254, 243, 199, 1.0);

const kCompletedBg = Color.fromRGBO(209, 250, 229, 1.0);
const kCompletedText = Color.fromRGBO(6, 68, 70, 1.0);

//Job Status
const int OPEN = 1; 
const int ONGOING = 2;
const int WAITING_CLIENT_REVIEWS = 3;
const int COMPLETED = 4;
const int CANCELLED = 5;
const int WAITING_CLIENT_PAYMENT = 6; 
const int WAITING_NURSE_APPROVAL = 7; 

class TransactionStatus {
  static const String success = "1";
  static const String pending = "2";
  static const String fail = "3";
}
const devToyyibPay = "https://dev.toyyibpay.com/";
