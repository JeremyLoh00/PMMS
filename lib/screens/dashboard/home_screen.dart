import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/public_components/button_secondary.dart';
import 'package:private_nurse_for_client/public_components/input_decoration.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/screens/dashboard/component/job_list.dart';
import 'package:private_nurse_for_client/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  GlobalKey<ScaffoldState> _key = GlobalKey();
  String? selectedValue;

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

  int _selectedTabIndex = 0;
  String src =
      "https://c1.wallpaperflare.com/preview/547/839/590/accident-bleed-bleeding-bleeding-finger.jpg";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: ScaleTap(
                  onPressed: () {},
                  child: DropdownButtonFormField2<String>(
                    decoration: textFieldInputDecoration2(),
                    isExpanded: true,
                    enableFeedback: true,
                    hint: Row(
                      children: const [
                        Expanded(
                          child: Text(
                            'State',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      //swidth: double.infinity,
                      padding: null,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [profileShadow(kGrey.withOpacity(0.3))],
                        color: kWhite,
                      ),
                      elevation: 0,
                      offset: const Offset(0, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(2),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                flex: 1,
                child: ScaleTap(
                  onPressed: () {},
                  child: Icon(
                    Icons.search,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Space(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              const Text(
                "Job Title",
                style: TextStyle(
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                ),
                Expanded(
                  flex: 1,
                  child: 
              ButtonSecondary(onPressed: null, text: "New", icon: Icons.add,))
            ],
          ),
        ),
        Space(10),
        Expanded(
            child: JobList(
          src: src,
        ))
      ],
    );
  }
}
