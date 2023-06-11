import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/public_components/custom_list_tile.dart';
import 'package:private_nurse_for_client/theme.dart';

class ContestWinnerList extends StatefulWidget {
  ContestWinnerList({
    Key? key,
  }) : super(key: key);

  @override
  State<ContestWinnerList> createState() => _ContestWinnerListState();
}

class _ContestWinnerListState extends State<ContestWinnerList> {
  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      index: 1,
      leading: CircleAvatar(
        radius: 24.0,
        backgroundImage: NetworkImage(''),
      ),
      title: Text(
        "name",
        style: listTileTitleStyle(),
      ),
      subtitle: Text(
        "Complete at ",
        style: const TextStyle(
          color: kGrey,
          fontSize: 12.0,
          fontFamily: "Poppins",
        ),
      ),
      trailing: getRank(1),
    );
  }

  Widget getRank(int index) {
    int rankNo = 1;
    String ordinals = "";
    Color color;
    List<Color> colorList = [
      const Color.fromRGBO(161, 16, 185, 1),
      const Color.fromRGBO(157, 150, 254, 1),
      kPrimaryColor,
    ];

    switch (index) {
      case 0:
        rankNo = 1;
        ordinals = "st";
        color = colorList[0];
        break;
      case 1:
        rankNo = 2;
        ordinals = "nd";
        color = colorList[1];
        break;
      case 2:
        rankNo = 3;
        ordinals = "rd";
        color = colorList[2];
        break;
      default:
        // return nothing
        return const SizedBox.shrink();
    }

    return Container(
      height: 29.0,
      width: 29.0,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(35.0),
      ),
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
            color: color,
          ),
          children: [
            TextSpan(
              text: "$rankNo",
              style: const TextStyle(fontSize: 12.0),
            ),
            TextSpan(
              text: ordinals,
              style: const TextStyle(fontSize: 8.0),
            )
          ],
        ),
      ),
    );
  }
}
