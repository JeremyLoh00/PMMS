import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:private_nurse_for_client/bloc/feedback_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/http_response.dart';
import 'package:private_nurse_for_client/models/feedback/feedback_filter_request_model.dart';
import 'package:private_nurse_for_client/models/feedback/feedback_model.dart';
import 'package:private_nurse_for_client/models/feedback/list_feedback_response_model.dart';
import 'package:private_nurse_for_client/public_components/empty_list.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';
import 'package:private_nurse_for_client/screens/nurse_profile/components/feedback_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NurseReview extends StatefulWidget {
  final int nurseId;
  const NurseReview({super.key, required this.nurseId});

  @override
  State<NurseReview> createState() => _NurseReviewState();
}

class _NurseReviewState extends State<NurseReview> {
  FeedbackBloc _feedbackBloc = FeedbackBloc();
  FeedbackFilterRequestModel _requestModel = FeedbackFilterRequestModel();
  static const _pageSize = 30;

  final PagingController<int, FeedbackModel> _feedbackPagingController =
      PagingController(firstPageKey: 1);

  // For refresher
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch

    _feedbackPagingController.refresh();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      //Call API
      final ListFeedbackResponseModel response =
          await _feedbackBloc.getFeedbackList(widget.nurseId, _requestModel);

      // If success
      if (response.statusCode == HttpResponse.HTTP_OK) {
        List<FeedbackModel> listFeedbackModel = response.data!;

        // Compare the lenght with the page size to know either already last page or not
        final isLastPage = listFeedbackModel.length < _requestModel.take!;
        if (isLastPage) {
          _feedbackPagingController.appendLastPage(listFeedbackModel);
        } else {
          final nextPageKey = pageKey + listFeedbackModel.length;
          _feedbackPagingController.appendPage(listFeedbackModel, nextPageKey);
        }
      } else {
        _feedbackPagingController.error = response.message;
      }
    } catch (error) {
      _feedbackPagingController.error = "Server Error";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _feedbackPagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SmartRefresher(
        controller: _refreshController,
        header: WaterDropMaterialHeader(
          backgroundColor: kPrimaryColor,
        ),
        onRefresh: _onRefresh,
        child: CustomScrollView(
          slivers: <Widget>[
            PagedSliverList<int, FeedbackModel>(
              pagingController: _feedbackPagingController,
              builderDelegate: PagedChildBuilderDelegate<FeedbackModel>(
                  firstPageProgressIndicatorBuilder: (context) {
                    return ThemeSpinner.spinner();
                  },
                  newPageProgressIndicatorBuilder: (context) {
                    return ThemeSpinner.spinner();
                  },
                  noItemsFoundIndicatorBuilder: (context) => const EmptyList(
                        icon: Iconsax.message_favorite,
                        title: "No feedback found",
                        subtitle: "No new feedback available",
                        query: '',
                      ),
                  animateTransitions: true,
                  itemBuilder: (context, feedbackModel, index) {
                    return FeedBackItem(feedbackModel: feedbackModel);
                  }),
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: false,
      title: Text(
        "Reviews",
        style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.bold,
          color: kBlack,
        ),
      ),
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
