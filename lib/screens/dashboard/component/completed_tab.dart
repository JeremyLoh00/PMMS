import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/bloc/job_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/helpers/http_response.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/job/list_job_response_model.dart';
import 'package:private_nurse_for_client/models/job_filter_request/job_filter_request_model.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/public_components/empty_list.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';
import 'package:private_nurse_for_client/screens/dashboard/component/home_function.dart';
import 'package:private_nurse_for_client/screens/job_description/job_description_screen.dart';
import 'package:private_nurse_for_client/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CompletedTab extends StatefulWidget {
  const CompletedTab({
    super.key,
    required this.selectedTabIndex,
    required this.jobFilterRequestModel,
    required this.pagingController,
   
  });

  final int selectedTabIndex;
  final JobFilterRequestModel jobFilterRequestModel;
  final PagingController<int, JobModel> pagingController;
 

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  // For pagination
  static const _pageSize = 5;

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
  int jobStatus = COMPLETED;

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
    jobFilterRequestModel.tab = 3;
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
                      title: "No completed jobs found",
                      subtitle: "You have not complete your current job",
                      query: '',
                    ),
                animateTransitions: true,
                itemBuilder: (context, jobModel, index) {
                  return completedJobItem(context, index, jobModel);
                }),
          )
        ],
      ),
    );
  }

  Widget completedJobItem(BuildContext context, int index, JobModel jobModel) {
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
                        height: 120,
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
                              // Space(20),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     const SizedBox(width: 10),
                              //     const Icon(
                              //       Iconsax.star1,
                              //       color: kPrimaryColor,
                              //       size: 16,
                              //     ),
                              //     const SizedBox(width: 3),
                              //     Text(
                              //       jobModel.feedback!.rating!.toStringAsFixed(1),
                              //       style: const TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: 13,
                              //       ),
                              //     ),
                              //     const SizedBox(width: 20),
                              //     const Icon(
                              //       Icons.chat_bubble,
                              //       color: kPrimaryColor,
                              //       size: 16,
                              //     ),
                              //     const SizedBox(width: 3),
                              //     Expanded(
                              //       child: Text(
                              //         jobModel.feedback!.comment!,
                              //         style: const TextStyle(
                              //           color: kGrey,
                              //           fontSize: 11,
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // Space(10),
                              // Padding(
                              //   padding: const EdgeInsets.all(10.0),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.end,
                              //     children: [
                              //       Text(
                              //         "Cancelled on ${DateTime.now().day} | ${DateTime.now().hour}",
                              //         style: TextStyle(
                              //           color: kGrey,
                              //           fontSize: 10,
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
