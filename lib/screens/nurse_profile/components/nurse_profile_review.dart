import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:private_nurse_for_client/bloc/nurse_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/helpers/http_response.dart';
import 'package:private_nurse_for_client/models/list_feedback_for_specific_nurse/list_feedback_for_specific_nurse_model.dart';
import 'package:private_nurse_for_client/models/list_feedback_for_specific_nurse/list_feedback_response_model.dart';
import 'package:private_nurse_for_client/models/nurse/nurse_filter_request_model.dart';
import 'package:private_nurse_for_client/models/user/list_user_response_model.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/public_components/empty_list.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';
import 'package:private_nurse_for_client/screens/history/components/nurse_history_item.dart';
import 'package:private_nurse_for_client/screens/profile/profile_screen.dart';
import 'package:private_nurse_for_client/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NurseProfileReview extends StatefulWidget {
  const NurseProfileReview({
    Key? key,
    required this.description,
    required this.src,
    required this.name,
    required this.comment,
    required this.commentPic,
    required this.date,
  }) : super(key: key);

  final String description;
  final String src;
  final String commentPic;
  final String name;
  final String comment;
  final String date;

  @override
  State<NurseProfileReview> createState() => _NurseProfileReviewState();
}

class _NurseProfileReviewState extends State<NurseProfileReview> {
  NurseBloc nurseBloc = NurseBloc();
  static const _pageSize = 30;
  final PagingController<int, ListFeedbackForSpecificNurseModel>
      _nursePagingController = PagingController(firstPageKey: 1);

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
      final ListFeedbackResponseModel response =
          await nurseBloc.getListFeedbackForSpecificNurse(
        nurseHistoryFilterRequestModel,
      );

      // If success
      if (response.statusCode == HttpResponse.HTTP_OK) {
        List<ListFeedbackForSpecificNurseModel> listNurseModel = response.data!;

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

  final int charactersLimit = 150;
  late String initialText;
  late String extendedText;
  final double _reviewRating = 4.0;
  IconData? _selectedIcon;

  List<String> text1 = [
    'Diabetics',
    'Hypertension',
    'Skin Problem',
  ];

  List<String> text2 = [
    'Bed Bound',
    'Not Cooperative',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Text(
            "Reviews",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 10,
            ),
            ScaleTap(
              onPressed: () {
                navigateTo(context, ProfileScreen());
              },
              child: Padding(
                padding: EdgeInsets.only(right: 15),
                child: Container(
                  width: 35,
                  height: 35,
                  padding: const EdgeInsets.all(0.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.src,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w800),
                ),
                RatingBarIndicator(
                  itemBuilder: (context, index) => Icon(
                    _selectedIcon ?? Icons.star,
                    color: kPrimaryColor,
                  ),
                  rating: _reviewRating,
                  itemCount: 5,
                  itemSize: 15.0,
                  unratedColor: Color.fromRGBO(4, 99, 128, 0.39),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 60.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.comment,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Hero(
                  tag: "contest-banner",
                  // child: Text("data"),
                  child: Container(
                    child: CachedNetworkImage(
                      imageUrl: widget.commentPic,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.date,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                  color: kGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
    // return SmartRefresher(
    //   controller: _refreshController,
    //   header: WaterDropMaterialHeader(
    //     backgroundColor: kPrimaryColor,
    //   ),
    //   onRefresh: _onRefresh,
    //   child: CustomScrollView(
    //     slivers: <Widget>[
    //       PagedSliverList<int, ListFeedbackForSpecificNurseModel>(
    //         pagingController: _nursePagingController,
    //         builderDelegate:
    //             PagedChildBuilderDelegate<ListFeedbackForSpecificNurseModel>(
    //                 firstPageProgressIndicatorBuilder: (context) {
    //                   return ThemeSpinner.spinner();
    //                 },
    //                 newPageProgressIndicatorBuilder: (context) {
    //                   return ThemeSpinner.spinner();
    //                 },
    //                 noItemsFoundIndicatorBuilder: (context) => EmptyList(
    //                       icon: Icons.work_outline,
    //                       title: "No review found",
    //                       subtitle: "No review available",
    //                       query: '',
    //                     ),
    //                 animateTransitions: true,
    //                 itemBuilder: (context, reviewModel, index) {
    //                   return reviewItem(context, index, reviewModel);
    //                 }),
    //       )
    //     ],
    //   ),
    // );
  }
}

// Widget reviewItem(BuildContext context, int index,
//     ListFeedbackForSpecificNurseModel reviewModel) {
//   return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.only(bottom: 5.0),
//           child: Text(
//             "Reviews",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18.0,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: 10,
//             ),
//             ScaleTap(
//               onPressed: () {
//                 navigateTo(context, ProfileScreen());
//               },
//               child: Padding(
//                 padding: EdgeInsets.only(right: 15),
//                 child: Container(
//                   width: 35,
//                   height: 35,
//                   padding: const EdgeInsets.all(0.5),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                   ),
//                   child: CachedNetworkImage(
//                     imageUrl: widget.src,
//                     imageBuilder: (context, imageProvider) => Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         image: DecorationImage(
//                           image: imageProvider,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     errorWidget: (context, url, error) =>
//                         const Icon(Icons.error),
//                   ),
//                 ),
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   reviewModel.rating.toString(),
//                   style: TextStyle(
//                       fontFamily: "Poppins",
//                       fontSize: 14,
//                       fontWeight: FontWeight.w800),
//                 ),
//                 RatingBarIndicator(
//                   itemBuilder: (context, index) => Icon(
//                     _selectedIcon ?? Icons.star,
//                     color: kPrimaryColor,
//                   ),
//                   rating: _reviewRating,
//                   itemCount: 5,
//                   itemSize: 15.0,
//                   unratedColor: Color.fromRGBO(4, 99, 128, 0.39),
//                 ),
//                 SizedBox(
//                   width: 5,
//                 ),
//               ],
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(
//             left: 60.0,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 reviewModel.comment!,
//                 style: TextStyle(
//                   fontFamily: "Poppins",
//                   fontSize: 14,
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.2,
//                 width: MediaQuery.of(context).size.width * 0.4,
//                 child: Hero(
//                   tag: "contest-banner",
//                   // child: Text("data"),
//                   child: Container(
//                     child: CachedNetworkImage(
//                       imageUrl: widget.commentPic,
//                       imageBuilder: (context, imageProvider) => Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.0),
//                           shape: BoxShape.rectangle,
//                           image: DecorationImage(
//                             image: imageProvider,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 widget.date,
//                 style: TextStyle(
//                   fontFamily: "Poppins",
//                   fontSize: 12,
//                   color: kGrey,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
// }
