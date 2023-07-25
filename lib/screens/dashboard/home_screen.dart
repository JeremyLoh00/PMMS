import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:private_nurse_for_client/bloc/user_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/job_filter_request/job_filter_request_model.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/public_components/button_secondary.dart';
import 'package:private_nurse_for_client/public_components/input_decoration.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/screens/dashboard/component/cancelled_tab.dart';
import 'package:private_nurse_for_client/screens/dashboard/component/completed_tab.dart';
import 'package:private_nurse_for_client/screens/dashboard/component/ongoing_tab.dart';
import 'package:private_nurse_for_client/screens/dashboard/component/open_tab.dart';
import 'package:private_nurse_for_client/screens/job/create_job/create_job.dart';
import 'package:private_nurse_for_client/screens/dashboard/component/job_list.dart';
import 'package:private_nurse_for_client/screens/job/create_job/select_job.dart';
import 'package:private_nurse_for_client/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  final UserModel? userModel;
  const HomeScreen({super.key, this.userModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  GlobalKey<ScaffoldState> _key = GlobalKey();
  String? selectedValue;
  JobFilterRequestModel jobFilterRequestModel = JobFilterRequestModel(
    cityId: -1,
    divisionId: 10,
  );
  UserBloc userBloc = UserBloc();
  final PagingController<int, JobModel> _jobPagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, JobModel> _ongoingPagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, JobModel> _completedPagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, JobModel> _cancelledPagingController =
      PagingController(firstPageKey: 1);
  // For refresher
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
        print(_selectedTabIndex);
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int _selectedTabIndex = 0;
  int jobStatus = 1;

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  String src =
      "https://c1.wallpaperflare.com/preview/547/839/590/accident-bleed-bleeding-bleeding-finger.jpg";

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 15),
      //   child: Expanded(
      //     flex: 3,
      //     child: ScaleTap(
      //       onPressed: () {},
      //       child: DropdownButtonFormField2<String>(
      //         decoration: textFieldInputDecoration2(),
      //         isExpanded: true,
      //         enableFeedback: true,
      //         hint: const Row(
      //           children: [
      //             Expanded(
      //               child: Text(
      //                 'Job Status',
      //                 style: TextStyle(
      //                   fontSize: 14,
      //                   fontWeight: FontWeight.bold,
      //                   color: Colors.black,
      //                 ),
      //                 overflow: TextOverflow.ellipsis,
      //               ),
      //             ),
      //           ],
      //         ),
      //         dropdownStyleData: DropdownStyleData(
      //           maxHeight: 200,
      //           //swidth: double.infinity,
      //           padding: null,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(14),
      //             boxShadow: [profileShadow(kGrey.withOpacity(0.3))],
      //             color: kWhite,
      //           ),
      //           elevation: 0,
      //           offset: const Offset(0, 0),
      //           scrollbarTheme: ScrollbarThemeData(
      //             radius: const Radius.circular(2),
      //             thickness: MaterialStateProperty.all<double>(6),
      //             thumbVisibility: MaterialStateProperty.all<bool>(true),
      //           ),
      //         ),
      //         items: items
      //             .map((item) => DropdownMenuItem<String>(
      //                   value: item,
      //                   child: Text(
      //                     item,
      //                     style: const TextStyle(
      //                       fontSize: 14,
      //                       fontWeight: FontWeight.bold,
      //                       color: Colors.black,
      //                     ),
      //                     overflow: TextOverflow.ellipsis,
      //                   ),
      //                 ))
      //             .toList(),
      //         value: selectedValue,
      //         onChanged: (value) {
      //           setState(() {
      //             selectedValue = value as String;
      //           });
      //         },
      //       ),
      //     ),
      //   ),
      // ),
      // Space(10),
      Expanded(
          child: Column(children: [
        TabBar(
          onTap: (value) {
            setState(() {
              _selectedTabIndex = value;
              // _jobPagingController.refresh();
              // _requestedPagingController.refresh();
              // _ongoingPagingController.refresh();
              // _completedPagingController.refresh();
              print(_selectedTabIndex);
            });
          },
          physics: const BouncingScrollPhysics(),
          controller: _tabController,
          splashBorderRadius: BorderRadius.circular(10),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              return states.contains(MaterialState.focused)
                  ? null
                  : kPrimary100Color;
            },
          ),
          isScrollable: true,
          indicatorColor: kPrimaryColor,
          enableFeedback: false,
          tabs: const [
            Tab(
              child: Text(
                "Open",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Tab(
              child: Text(
                "On-Going",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Tab(
              child: Text(
                "Completed",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Tab(
              child: Text(
                "Cancelled",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              OpenTab(
                userModel: widget.userModel!,
                selectedTabIndex: _selectedTabIndex,
                jobFilterRequestModel: jobFilterRequestModel,
                pagingController: _jobPagingController,
              ),
              OngoingTab(
                userModel: widget.userModel!,
                selectedTabIndex: _selectedTabIndex,
                jobFilterRequestModel: jobFilterRequestModel,
                pagingController: _ongoingPagingController,
              ),
              CompletedTab(
                userModel: widget.userModel!,
                selectedTabIndex: _selectedTabIndex,
                jobFilterRequestModel: jobFilterRequestModel,
                pagingController: _completedPagingController,
              ),
              CancelledTab(
                userModel: widget.userModel!,
                selectedTabIndex: _selectedTabIndex,
                jobFilterRequestModel: jobFilterRequestModel,
                pagingController: _cancelledPagingController,
              ),
            ],
          ),
        ),
      ]))
    ]);
  }
}
