import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/screens/profile/profile_screen.dart';
import 'package:private_nurse_for_client/screens/sign_in/sign_in_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  final _pageController = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // check access token either valid or not
    //WidgetsBinding.instance.addPostFrameCallback((_) => checkAccessToken());
  }

  void _selectDrawerItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String src =
      "https://c1.wallpaperflare.com/preview/547/839/590/accident-bleed-bleeding-bleeding-finger.jpg";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //callback function when back button is pressed
        return showExitAppPopup(context);
      },
      child: Scaffold(
        backgroundColor: kWhite,
        drawerEnableOpenDragGesture: true,
        appBar: _builtAppBar(),
        drawer: Drawer(
          backgroundColor: kWhite,
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ScaleTap(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: kBlack,
                        ),
                      ),
                      ScaleTap(
                        onPressed: () {
                          Navigator.pop(context);
                          navigateTo(context, ProfileScreen());
                        },
                        child: Icon(
                          Icons.person_outline,
                          color: kBlack,
                        ),
                        // child: Padding(
                        //   padding: EdgeInsets.only(right: 15),
                        //   child: Container(
                        //     width: 30,
                        //     height: 30,
                        //     padding: const EdgeInsets.all(0.5),
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //     ),
                        //     child: CachedNetworkImage(
                        //       imageUrl: src,
                        //       imageBuilder: (context, imageProvider) =>
                        //           Container(
                        //         decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           image: DecorationImage(
                        //             image: imageProvider,
                        //             fit: BoxFit.cover,
                        //           ),
                        //         ),
                        //       ),
                        //       errorWidget: (context, url, error) =>
                        //           const Icon(Icons.error),
                        //     ),
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                ),
                Space(10),
                ScaleTap(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                      setState(() {
                        _selectedIndex == 0;
                      });
                      _selectDrawerItem(0);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedIndex == 0
                          ? kPrimary100Color
                          : Colors.transparent,
                    ),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 25),
                          decoration: BoxDecoration(
                            color: _selectedIndex == 0 ? kPrimaryColor : kWhite,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        SizedBox(width: _selectedIndex == 0 ? 13 : 15),
                        Icon(
                          Icons.home,
                          color: _selectedIndex == 0 ? kPrimaryColor : kGrey,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Home",
                          style: TextStyle(
                            color: _selectedIndex == 0 ? kPrimaryColor : kGrey,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ScaleTap(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                      setState(() {
                        _selectedIndex == 1;
                      });
                      _selectDrawerItem(1);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedIndex == 1
                          ? kPrimary100Color
                          : Colors.transparent,
                    ),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 25),
                          decoration: BoxDecoration(
                            color: _selectedIndex == 1 ? kPrimaryColor : kWhite,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        SizedBox(width: _selectedIndex == 1 ? 13 : 15),
                        Icon(
                          Icons.phone,
                          color: _selectedIndex == 1 ? kPrimaryColor : kGrey,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Contact Us",
                          style: TextStyle(
                            color: _selectedIndex == 1 ? kPrimaryColor : kGrey,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ScaleTap(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedIndex == 2;
                    });
                    _selectDrawerItem(2);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedIndex == 2
                          ? kPrimary100Color
                          : Colors.transparent,
                    ),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 25),
                          decoration: BoxDecoration(
                            color: _selectedIndex == 2 ? kPrimaryColor : kWhite,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        SizedBox(width: _selectedIndex == 2 ? 13 : 15),
                        Icon(
                          Icons.info_outline_rounded,
                          color: _selectedIndex == 2 ? kPrimaryColor : kGrey,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "About Us",
                          style: TextStyle(
                            color: _selectedIndex == 2 ? kPrimaryColor : kGrey,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                const Divider(
                  color: kPrimary100Color,
                  thickness: 1,
                ),
                ScaleTap(
                  onPressed: () {
                      
                          Navigator.pop(context);
                          navigateTo(context, SignInScreen());
                        
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.logout_outlined,
                          color: kPrimaryColor,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Logout",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  AppBar _builtAppBar() {
    switch (_selectedIndex) {
      case 0:
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
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(
                  Iconsax.notification,
                  color: kDarkGrey,
                ),
              ),
            ),
            ScaleTap(
              onPressed: () {
                navigateTo(context, ProfileScreen());
              },
              child: Padding(
                padding: EdgeInsets.only(right: 15),
                child: Container(
                  width: 25,
                  height: 25,
                  padding: const EdgeInsets.all(0.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: src,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ],
        );
      case 1:
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
      case 2:
        // about us
        return AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "About Us",
            style: TextStyle(
              color: kWhite,
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
      default:
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
            ScaleTap(
              onPressed: () {
                // navigateTo(context, ProfileScreen());
              },
              child: Padding(
                padding: EdgeInsets.only(right: 15),
                child: Container(
                  width: 25,
                  height: 25,
                  padding: const EdgeInsets.all(0.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: src,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ],
        );
    }
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
      // return HomeScreen();
      case 1:
      // return ContactUsScreen();
      case 2:
      //  return AboutUsScreen();
      default:
        return Placeholder();
    }
  }
}
