import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/bloc/job_bloc.dart';
import 'package:private_nurse_for_client/bloc/user_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/helpers/http_response.dart';
import 'package:private_nurse_for_client/helpers/secure_storage_api.dart';
import 'package:private_nurse_for_client/helpers/user_data_notifier.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/job/list_job_response_model.dart';
import 'package:private_nurse_for_client/models/job_filter_request/job_filter_request_model.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/models/user/user_response_model.dart';
import 'package:private_nurse_for_client/public_components/empty_list.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';
import 'package:private_nurse_for_client/resource/user_resource.dart';
import 'package:private_nurse_for_client/screens/dashboard/component/home_function.dart';
import 'package:private_nurse_for_client/screens/job_description/job_description_screen.dart';
import 'package:private_nurse_for_client/theme.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:easy_debounce/easy_debounce.dart';

class OpenTab extends StatefulWidget {
  const OpenTab({
    super.key,
    required this.selectedTabIndex,
    required this.jobFilterRequestModel,
    required this.pagingController,
  });

  final int selectedTabIndex;

  final JobFilterRequestModel jobFilterRequestModel;
  final PagingController<int, JobModel> pagingController;

  @override
  State<OpenTab> createState() => _OpenTabState();
}

class _OpenTabState extends State<OpenTab> {
  // For pagination
  static const _pageSize = 30;
  late Future<UserModel?> _userModel;
  UserBloc userBloc = UserBloc();

  // For refresher
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void callBackHomePaginator() {
    _onRefresh();
  }

  void _onRefresh() async {
    UserModel? user = await checkAuthenticated();

    if (user != null) {
      // Declare notifier
      final UserDataNotifier userDataNotifier =
          Provider.of<UserDataNotifier>(context, listen: false);
      // Set to the notifier
      userDataNotifier.setUser(user);
    }
    // monitor network fetch

    widget.pagingController.refresh();
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

  JobsBloc jobBloc = JobsBloc();

  int jobStatus = OPEN;

  Future<void> _fetchPage(int pageKey) async {
    widget.jobFilterRequestModel.page = pageKey;
    try {
      //Call API
      final ListJobResponseModel response = await jobBloc.getListJobs(
        widget.jobFilterRequestModel,
      );

      // If success
      if (response.statusCode == HttpResponse.HTTP_OK) {
        List<JobModel> listJobsModel = response.data!;

        // Compare the lenght with the page size to know either already last page or not
        final isLastPage =
            listJobsModel.length < widget.jobFilterRequestModel.take!;
        if (isLastPage) {
          widget.pagingController.appendLastPage(listJobsModel);
        } else {
          final nextPageKey = pageKey + listJobsModel.length;
          widget.pagingController.appendPage(listJobsModel, nextPageKey);
        }
      } else {
        widget.pagingController.error = response.message;
      }
    } catch (error) {
      widget.pagingController.error = "Server Error";
    }
  }

  @override
  void initState() {
    super.initState();
    widget.jobFilterRequestModel.tab = 1;

    widget.pagingController.addPageRequestListener((pageKey) {
      EasyDebounce.debounce(
        'openTab',
        const Duration(milliseconds: 500),
        () => _fetchPage(pageKey),
      );
    });

    _userModel = getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      header: WaterDropMaterialHeader(
        backgroundColor: kPrimaryColor,
      ),
      onRefresh: _onRefresh,
      child: CustomScrollView(
        slivers: <Widget>[
          PagedSliverList<int, JobModel>(
            pagingController: widget.pagingController,
            builderDelegate: PagedChildBuilderDelegate<JobModel>(
                firstPageProgressIndicatorBuilder: (context) {
                  return ThemeSpinner.spinner();
                },
                newPageProgressIndicatorBuilder: (context) {
                  return ThemeSpinner.spinner();
                },
                noItemsFoundIndicatorBuilder: (context) => EmptyList(
                      icon: Icons.work_outline,
                      title: "No jobs found",
                      subtitle: "No new job available",
                      query: '',
                    ),
                animateTransitions: true,
                itemBuilder: (context, jobModel, index) {
                  return jobItem(context, index,
                      jobModel); // return jobItem(context, index, jobModel);
                }),
          )
        ],
      ),
    );
  }

  Widget jobItem(BuildContext context, int index, JobModel jobModel) {
    return ScaleTap(
      onPressed: () {
        navigateTo(
            context,
            JobDescription(
              jobModel: jobModel,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          //  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.only(top: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              profileShadow(
                kGrey.withOpacity(0.2),
              ),
            ],
          ),
          child: Row(
            // row for 2 column: image and column
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // image
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Space(5),
                  Text(
                    " #${jobModel.id!}",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Space(5),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CachedNetworkImage(
                      imageUrl: jobModel.service!.photoPath!,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        width: 10,
                        height: 10,
                        child: Center(
                          child: ThemeSpinner.spinner(),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 15),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Space(7),
                      badgeStatus(
                        status: jobModel.jobStatus!,
                        statusId: jobModel.jobStatusId!,
                      ),
                      Space(5),
                      Text(
                        jobModel.service!.name!,
                        style: TextStyle(
                          color: kBlack,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Expanded(
                      //       child: Text(
                      //         jobModel.service!.name!,
                      //         style: TextStyle(
                      //           color: kBlack,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //         maxLines: 1,
                      //         overflow: TextOverflow.ellipsis,
                      //       ),
                      //     ),
                      //     badgeStatus(
                      //       status: jobModel.status!,
                      //       bgColor: kBgSuccess,
                      //       textColor: kTextSuccess,
                      //     ),
                      //   ],
                      // ),
                      Space(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Iconsax.user,
                            color: kPrimaryColor,
                            size: 16,
                          ),
                          SizedBox(width: 5),
                          Expanded(
                              child: Text(
                            jobModel.patient!.name!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ))
                        ],
                      ),
                      Space(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Iconsax.clock,
                            color: kPrimaryColor,
                            size: 16,
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              jobModel.jobSchedule!.first.date!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Space(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Iconsax.calendar,
                            color: kPrimaryColor,
                            size: 16,
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              jobModel.jobSchedule!.first.startTime!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
