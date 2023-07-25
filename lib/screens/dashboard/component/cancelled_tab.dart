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
import 'package:private_nurse_for_client/theme.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CancelledTab extends StatefulWidget {
  const CancelledTab({
    super.key,
    required this.selectedTabIndex,
    required this.jobFilterRequestModel,
    required this.pagingController,
    required this.userModel,
  });

  final int selectedTabIndex;
  final JobFilterRequestModel jobFilterRequestModel;
  final PagingController<int, JobModel> pagingController;
  final UserModel userModel;

  @override
  State<CancelledTab> createState() => _CancelledTabState();
}

class _CancelledTabState extends State<CancelledTab> {
  double _rating = 3.3;
  // For pagination
  static const _pageSize = 30;

  // For refresher
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void callBackHomePaginator() {
    _onRefresh();
  }

  void _onRefresh() async {
    // monitor network fetch
    widget.pagingController.refresh();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  JobsBloc jobBloc = JobsBloc();
  JobFilterRequestModel jobFilterRequestModel = JobFilterRequestModel();
  int jobStatus = 4;

  Future<void> _fetchPage(int pageKey) async {
    jobFilterRequestModel.page = pageKey;
    try {
      //Call API
      final ListJobResponseModel response = await jobBloc.getListJobs(
        jobFilterRequestModel,
      );

      // If success
      if (response.statusCode == HttpResponse.HTTP_OK) {
        List<JobModel> listJobsModel = response.data!;

        // Compare the lenght with the page size to know either already last page or not
        final isLastPage = listJobsModel.length < _pageSize;
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
    jobFilterRequestModel.tab = jobStatus;
    jobFilterRequestModel.take = pageSize;
    widget.jobFilterRequestModel.page = 1;
    widget.pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
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
                      title: "No cancelled jobs found",
                      subtitle: "You have not cancel your current job",
                      query: '',
                    ),
                animateTransitions: true,
                itemBuilder: (context, jobModel, index) {
                  return cancelledJobItem(context, index, jobModel);
                }),
          )
        ],
      ),
    );
  }

  Widget cancelledJobItem(BuildContext context, int index, JobModel jobModel) {
    return ScaleTap(
      onPressed: () {
        // navigateTo(
        //   context,
        //   InformationDetailsScreen(
        //     userModel: widget.userModel,
        //     jobModel: jobModel,
        //     selectedTabIndex: widget.selectedTabIndex,
        //     rating: jobModel.feedback!.rating!.toDouble(),
        //     callbackHomePaginator: callBackHomePaginator,
        //   ),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
          child: Column(
            children: [
              Row(
                // row for 2 column: image and column
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // image
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Space(7),
                        badgeStatus(
                          status: jobModel.status!,
                          bgColor: kBgSuccess,
                          textColor: kTextSuccess,
                        ),
                        Space(5),
                        Text(
                          jobModel.service!.name!,
                          style: TextStyle(
                            color: kBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                              // jobModel.client!.userModel!.name!,
                              maxLines: 2,
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
                                jobModel.jobSchedule!.date!,
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
                               jobModel.jobSchedule!.startTime!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Space(5),
                        Text(
                          jobModel.status!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Space(20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  const Icon(
                    Iconsax.star1,
                    color: kPrimaryColor,
                    size: 16,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    jobModel.feedback!.rating!.toStringAsFixed(1),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Icon(
                    Icons.chat_bubble,
                    color: kPrimaryColor,
                    size: 16,
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: Text(
                      jobModel.feedback!.comment!,
                      style: const TextStyle(
                        color: kGrey,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
              Space(10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Cancelled on ${DateTime.now().day} | ${DateTime.now().hour}",
                      style: TextStyle(
                        color: kGrey,
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}