import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:private_nurse_for_client/bloc/nurse_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/http_response.dart';
import 'package:private_nurse_for_client/models/user/list_user_response_model.dart';
import 'package:private_nurse_for_client/models/nurse/nurse_filter_request_model.dart';
import 'package:private_nurse_for_client/models/nurse/nurse_model.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/public_components/empty_list.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';
import 'package:private_nurse_for_client/screens/edit_profile/edit_profile_screen.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_app_bar.dart';
import 'package:private_nurse_for_client/screens/history/components/nurse_history_item.dart';

import 'package:private_nurse_for_client/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NurseHistoryScreen extends StatefulWidget {
  const NurseHistoryScreen({super.key});

  @override
  State<NurseHistoryScreen> createState() => _NurseHistoryScreenState();
}

//List of history items
class _NurseHistoryScreenState extends State<NurseHistoryScreen> {
  NurseBloc nurseBloc = NurseBloc();
  static const _pageSize = 30;
  final PagingController<int, UserModel> _nursePagingController =
      PagingController(firstPageKey: 1);

  NurseFilterRequestModel nurseHistoryFilterRequestModel =
      NurseFilterRequestModel();

  // For refresher
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch

    _nursePagingController.refresh();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  Future<void> _fetchPage(int pageKey) async {
    nurseHistoryFilterRequestModel.page = pageKey;
    try {
      //Call API
      final ListUserResponseModel response =
          await nurseBloc.getListNurseHistory(
        nurseHistoryFilterRequestModel,
      );

      // If success
      if (response.statusCode == HttpResponse.HTTP_OK) {
        List<UserModel> listNurseModel = response.data!;

        // Compare the lenght with the page size to know either already last page or not
        final isLastPage = listNurseModel.length < _pageSize;
        if (isLastPage) {
          _nursePagingController.appendLastPage(listNurseModel);
        } else {
          final nextPageKey = pageKey + listNurseModel.length;
          _nursePagingController.appendPage(listNurseModel, nextPageKey);
        }
      } else {
        _nursePagingController.error = response.message;
        print(response.message);
      }
    } catch (error) {
      _nursePagingController.error = "Server Error";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nurseHistoryFilterRequestModel.page = 1;
    nurseHistoryFilterRequestModel.take = pageSize;
    _nursePagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

//nurse profile pic

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
          PagedSliverList<int, UserModel>(
            pagingController: _nursePagingController,
            builderDelegate: PagedChildBuilderDelegate<UserModel>(
                firstPageProgressIndicatorBuilder: (context) {
                  return ThemeSpinner.spinner();
                },
                newPageProgressIndicatorBuilder: (context) {
                  return ThemeSpinner.spinner();
                },
                noItemsFoundIndicatorBuilder: (context) => const EmptyList(
                      icon: Iconsax.people,
                      title: "No Nurse History ",
                      subtitle: "No new nurse history available",
                      query: '',
                    ),
                animateTransitions: true,
                itemBuilder: (context, nurseModel, index) {
                  return NurseHistoryItem(userModel: nurseModel);
                }),
          )
        ],
      ),
    );
  }
}
