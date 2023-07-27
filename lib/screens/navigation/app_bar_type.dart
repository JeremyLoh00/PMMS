import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/constant.dart';

AppBar appBarError() {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: Text(
      "Error Page",
      style: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Colors.transparent,
    leading: Builder(
      builder: (context) => // Ensure Scaffold is in context
          ScaleTap(
              onPressed: () => Scaffold.of(context).openDrawer(),
              child: Icon(
                Icons.menu,
                color: kBlack,
              )),
    ),
    actions: [
      ScaleTap(
        onPressed: () {
          print("notification");
        },
        child: const Padding(
          padding: EdgeInsets.only(right: 15),
          child: Icon(
            Iconsax.notification,
            color: kDarkGrey,
          ),
        ),
      ),
    ],
  );
}
AppBar appBarNurseHistory() {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: const Text(
      "Nurse History",
      style: TextStyle(
        color: kBlack,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Colors.transparent,
    leading: Builder(
      builder: (context) => // Ensure Scaffold is in context
          ScaleTap(
              onPressed: () => Scaffold.of(context).openDrawer(),
              child: Icon(
                Icons.menu,
                color: kBlack,
              )),
    ),
  );
}

AppBar appBarSubscription() {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: const Text(
      "Subscription",
      style: TextStyle(
        color: kBlack,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Colors.transparent,
    leading: Builder(
      builder: (context) => // Ensure Scaffold is in context
          ScaleTap(
              onPressed: () => Scaffold.of(context).openDrawer(),
              child: Icon(
                Icons.menu,
                color: kBlack,
              )),
    ),
  );
}

AppBar appBarAboutUs() {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: const Text(
      "About Us",
      style: TextStyle(
        color: kBlack,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Colors.transparent,
    leading: Builder(
      builder: (context) => // Ensure Scaffold is in context
          ScaleTap(
              onPressed: () => Scaffold.of(context).openDrawer(),
              child: Icon(
                Icons.menu,
                color: kBlack,
              )),
    ),
  );
}

AppBar appBarContactUs() {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: Text(
      "Contact Us",
      style: TextStyle(
        color: kBlack,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Colors.transparent,
    leading: Builder(
      builder: (context) => // Ensure Scaffold is in context
          ScaleTap(
              onPressed: () {
                Scaffold.of(context).openDrawer();
                FocusScope.of(context).unfocus();
              },
              child: Icon(
                Icons.menu,
                color: kBlack,
              )),
    ),
  );
}

AppBar appBarHome({required Future<Object?> navigate}) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: Text(
      "Home",
      style: TextStyle(
        color: kBlack,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Colors.transparent,
    leading: Builder(
      builder: (context) => // Ensure Scaffold is in context
          ScaleTap(
              onPressed: () => Scaffold.of(context).openDrawer(),
              child: Icon(
                Icons.menu,
                color: kBlack,
              )),
    ),
    actions: [
      ScaleTap(
        onPressed: () {
          print("notification");
          navigate;
        },
        child: const Padding(
          padding: EdgeInsets.only(right: 15),
          child: Icon(
            Iconsax.notification,
            color: kDarkGrey,
          ),
        ),
      ),
    ],
  );
}
