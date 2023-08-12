import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:get_it/get_it.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:private_nurse_for_client/bloc/user_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/secure_storage_api.dart';
import 'package:private_nurse_for_client/helpers/user_data_notifier.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/models/user/user_response_model.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';
import 'package:private_nurse_for_client/resource/user_resource.dart';
import 'package:private_nurse_for_client/screens/edit_profile/edit_profile_screen.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_app_bar.dart';
import 'package:private_nurse_for_client/screens/profile/components/body.dart';
import 'package:private_nurse_for_client/theme.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<UserModel?> _userModel;
  UserBloc userBloc = UserBloc();
  // For refresher
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void callBackRefresh() {
    _onRefresh();
  }

  void _onRefresh() async {
    UserModel? user = await checkAuthenticated();

    if (user != null) {
      // Declare notifier
      final UserDataNotifier userDataNotifier =
          Provider.of<UserDataNotifier>(context, listen: false);
      // Set to the notifier
      userDataNotifier.setUserData(user);
    }
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  Future<UserModel?> checkAuthenticated() async {
    //get data from secure storage
    try {
      final UserResponseModel userResponseModel = await userBloc.me(context);
      if (userResponseModel.data != null) {
        print(userResponseModel.message);
        //save in secured storage
        await SecureStorageApi.saveObject("user", userResponseModel.data!);
        //save in GetIt
        UserResource.setGetIt(userResponseModel.data!);

        return userResponseModel.data!;
      } else {
        ThemeSnackBar.showSnackBar(context, userResponseModel.message);
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
  void initState() {
    super.initState();
    _userModel = getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: ThemeAppBar(
        "Profile",
        trailing: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Consumer<UserDataNotifier>(
              builder: (context, userDataNotifier, _) {
            // If the user data in the notifier is not null
            if (userDataNotifier.user != null) {
              // Show UI using the data in the notifier
              return editIcon(
                context,
                userDataNotifier.user!,
              );
              // Else try o get the data from shared preferences the show the UI
            } else {
              return FutureBuilder(
                  future: _userModel,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      // Set to the user data notifier
                      userDataNotifier.setUserData(snapshot.data);
                      // return UI
                      return editIcon(
                        context,
                        snapshot.data!,
                      );
                    } else {
                      // Show loading
                      return Center(
                        child: ThemeSpinner.spinner(),
                      );
                    }
                  });
            }
          }),
        ),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        header: WaterDropMaterialHeader(),
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: // Use the user data notifier
              Consumer<UserDataNotifier>(
                  builder: (context, userDataNotifier, _) {
            // If the user data in the notifier is not null
            if (userDataNotifier.user != null) {
              // Show UI using the data in the notifier
              return Body(
                userModel: userDataNotifier.user!,
              );
              // Else try o get the data from shared preferences the show the UI
            } else {
              return FutureBuilder(
                  future: _userModel,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      // Set to the user data notifier
                      userDataNotifier.setUserData(snapshot.data);
                      // return UI
                      return Body(
                        userModel: snapshot.data!,
                      );
                    } else {
                      // Show loading
                      return Center(
                        child: ThemeSpinner.spinner(),
                      );
                    }
                  });
            }
          }),
        ),
      ),
    );
  }

  Widget editIcon(BuildContext context, UserModel userModel) {
    return IconButton(
      onPressed: () {
        navigateTo(
          context,
          EditProfileScreen(
            userModel: userModel,
            callBackRefresh: callBackRefresh,
          ),
        );
      },
      splashColor: kPrimary100Color,
      tooltip: "Edit Profile",
      icon: Icon(
        Iconsax.edit,
        color: kPrimaryColor,
      ),
    );
  }
}
