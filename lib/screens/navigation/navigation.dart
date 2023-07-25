import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:get_it/get_it.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/bloc/user_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/helpers/secure_storage_api.dart';
import 'package:private_nurse_for_client/helpers/user_data_notifier.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/models/user/user_response_model.dart';
import 'package:private_nurse_for_client/public_components/custom_dialog.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';
import 'package:private_nurse_for_client/resource/user_resource.dart';
import 'package:private_nurse_for_client/screens/about_us/about_us_screen.dart';
import 'package:private_nurse_for_client/screens/contact_us/contact_us_screen.dart';
import 'package:private_nurse_for_client/screens/dashboard/home_screen.dart';
import 'package:private_nurse_for_client/screens/history/nurse_history_screen.dart';
import 'package:private_nurse_for_client/screens/navigation/app_bar_type.dart';
import 'package:private_nurse_for_client/screens/notification/notification_screen.dart';
import 'package:private_nurse_for_client/screens/profile/profile_screen.dart';
import 'package:private_nurse_for_client/screens/subscription/subscription_screen.dart';
import 'package:provider/provider.dart';

class Navigation extends StatefulWidget {
  static const routeName = '/navigation';
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  UserBloc userBloc = UserBloc();
  late Future<UserModel?> _userModel;
  final _pageController = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userModel = getUserDetails();
    // check access token either valid or not
    //WidgetsBinding.instance.addPostFrameCallback((_) => checkAccessToken());
  }

  void _selectDrawerItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<UserModel?> checkAuthenticated() async {
    //get data from secure storage
    try {
      final UserResponseModel userResponseModel = await userBloc.me(context);
      if (userResponseModel.data != null) {
        //save in secured storage
        await SecureStorageApi.saveObject("user", userResponseModel.data!);
        //save in GetIt
        UserResource.setGetIt(userResponseModel.data!);

        return userResponseModel.data!;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> getUserDetails() async {
    //return this._memoizer.runOnce((user) async {
    // Means no argument passed to this interface, so current user profile
    // Get from getit current user data
    UserModel user = GetIt.instance.get<UserModel>();
    if (user.id != null) {
      return user;
    } else {
      return await checkAuthenticated();
    }
  }

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
        drawer: FutureBuilder<UserModel?>(
          future: _userModel,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: ThemeSpinner.spinner(),
              );
            } else if (snapshot.hasData && snapshot.data != null) {
              final UserModel userModel = snapshot.data!;
              return drawer(context, userModel);
            } else {
              return drawer(
                  context, null); // Pass null if no user data available
            }
          },
        ),
        // body: _buildBody(),
        body: Consumer<UserDataNotifier>(
          builder: (context, userDataNotifier, child) {
            if (userDataNotifier.user != null) {
              // Show UI using the data in the notifier
              return _buildBody(
                userModel: userDataNotifier.user!,
              );
              // Else try to get the data from shared preferences the show the UI
            } else {
              return FutureBuilder(
                future: _userModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    // Set to the user data notifier
                    userDataNotifier.setUserData(snapshot.data);
                    // return UI
                    return _buildBody(
                      userModel: snapshot.data!,
                    );
                  } else {
                    // Show loading
                    return Center(
                      child: ThemeSpinner.spinner(),
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }

  Drawer drawer(BuildContext context, UserModel? userModel) {
    return Drawer(
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
                    child: Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Container(
                        width: 30,
                        height: 30,
                        padding: const EdgeInsets.all(0.5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: userModel!.profilePhoto!,
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
              ),
            ),
            Space(10),
            ScaleTap(
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                  // setState(() {
                  //   _selectedIndex == 0;
                  // });
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
                  // setState(() {
                  //   _selectedIndex == 1;
                  // });
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
                      Icons.history,
                      color: _selectedIndex == 1 ? kPrimaryColor : kGrey,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Nurse History",
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
                setState(() {
                  Navigator.pop(context);
                  // setState(() {
                  //   _selectedIndex == 1;
                  // });
                  _selectDrawerItem(2);
                });
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
                      Icons.subscriptions_outlined,
                      color: _selectedIndex == 2 ? kPrimaryColor : kGrey,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Subscription",
                      style: TextStyle(
                        color: _selectedIndex == 2 ? kPrimaryColor : kGrey,
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
                  // setState(() {
                  //   _selectedIndex == 1;
                  // });
                  _selectDrawerItem(3);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 3
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
                        color: _selectedIndex == 3 ? kPrimaryColor : kWhite,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: _selectedIndex == 3 ? 13 : 15),
                    Icon(
                      Icons.phone,
                      color: _selectedIndex == 3 ? kPrimaryColor : kGrey,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Contact Us",
                      style: TextStyle(
                        color: _selectedIndex == 3 ? kPrimaryColor : kGrey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            ScaleTap(
              onPressed: () {
                Navigator.pop(context);
                // setState(() {
                //   _selectedIndex == 2;
                // });
                _selectDrawerItem(4);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 4
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
                        color: _selectedIndex == 4 ? kPrimaryColor : kWhite,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: _selectedIndex == 4 ? 13 : 15),
                    Icon(
                      Icons.info_outline_rounded,
                      color: _selectedIndex == 4 ? kPrimaryColor : kGrey,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "About Us",
                      style: TextStyle(
                        color: _selectedIndex == 4 ? kPrimaryColor : kGrey,
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
              onPressed: () async {
                // Navigator.pop(context);
                print("logout");
                UserBloc userBloc = UserBloc();
                CustomDialog.show(context,
                    dismissOnTouchOutside: false,
                    description: "Log you out...",
                    center: ThemeSpinner.spinner());
                await userBloc.signOut(context);
              },
              child: Container(
                padding: EdgeInsets.all(15),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) {
                      return NotificationScreen();
                    },
                  ),
                );
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
        case 1:
        return appBarNurseHistory();
      case 2:
        // about us
        return appBarSubscription();
      case 3:
        return appBarContactUs();
      case 4:
        // about us
        return appBarAboutUs();
      default:
        return appBarError();
    }
  }

  Widget _buildBody({required UserModel userModel}) {
    switch (_selectedIndex) {
      case 0:
        return HomeScreen(
          userModel: userModel,
        );
      case 1:
        return NurseHistoryScreen();
      case 2:
        return SubscriptionScreen();
      case 3:
        return ContactUsScreen();
      case 4:
        return AboutUsScreen();
      default:
        return Placeholder();
    }
  }
}
