import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:private_nurse_for_client/bloc/notification_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/http_response.dart';
import 'package:private_nurse_for_client/models/notification/list_notification_request_model.dart';
import 'package:private_nurse_for_client/models/notification/list_notification_response_model.dart';
import 'package:private_nurse_for_client/models/notification/notification_model.dart';
import 'package:private_nurse_for_client/public_components/empty_list.dart';
import 'package:private_nurse_for_client/public_components/theme_app_bar.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';
import 'package:private_nurse_for_client/screens/notification/components/notification_container.dart';
 
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:iconsax/iconsax.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationBloc notificationBloc = NotificationBloc();
  ListNotificationRequestModel requestModel = ListNotificationRequestModel();
  static const _pageSize = 30;
  final PagingController<int, NotificationModel> _notificationPagingController =
      PagingController(firstPageKey: 1);

  // For refresher
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch

    _notificationPagingController.refresh();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {       //Call API
      final ListNotificationResponseModel response =
          await notificationBloc.getNotificationList(requestModel);

      // If success
      if (response.statusCode == HttpResponse.HTTP_OK) {
        List<NotificationModel> listNotificationModel = response.data!;

        // Compare the lenght with the page size to know either already last page or not
        final isLastPage = listNotificationModel.length < requestModel.take!;
        if (isLastPage) {
          _notificationPagingController.appendLastPage(listNotificationModel);
        } else {
          final nextPageKey = pageKey + listNotificationModel.length;
          _notificationPagingController.appendPage(
              listNotificationModel, nextPageKey);
        }
      } else {
        _notificationPagingController.error = response.message;
      }
    } catch (error) {
      _notificationPagingController.error = "Server Error";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notificationPagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: ThemeAppBar("Notifications"),
      body: SmartRefresher(
        controller: _refreshController,
        header: WaterDropMaterialHeader(
          backgroundColor: kPrimaryColor,
        ),
        onRefresh: _onRefresh,
        child: CustomScrollView(
          slivers: <Widget>[
            PagedSliverList<int, NotificationModel>(
              pagingController: _notificationPagingController,
              builderDelegate: PagedChildBuilderDelegate<NotificationModel>(
                  firstPageProgressIndicatorBuilder: (context) {
                    return ThemeSpinner.spinner();
                  },
                  newPageProgressIndicatorBuilder: (context) {
                    return ThemeSpinner.spinner();
                  },
                  noItemsFoundIndicatorBuilder: (context) => const EmptyList(
                        icon: Iconsax.notification,
                        title: "No notification found",
                        subtitle: "No new notification available",
                        query: '',
                      ),
                  animateTransitions: true,
                  itemBuilder: (context, notification, index) {
                    return NotificationContainer(notificationModel: notification,);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
