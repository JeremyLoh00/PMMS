import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/public_components/space.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  String text =
      "Porem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis.";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: kPrimary100Color,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "About Us",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: kPrimary100Color,
                  ),
                ),
              ],
            ),
            Space(10),
            Text(
              text,
              textAlign: TextAlign.justify,
              style: TextStyle(height: 1.5), // height for line spacing
            ),
            Space(20),
            // vision and mission
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.lightbulb_rounded,
                            color: kPrimaryColor,
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              "Vision",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      const Text(
                        "Dorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          height: 1.5,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.assignment_turned_in,
                            color: kPrimaryColor,
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              "Mission",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      const Text(
                        "Dorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          height: 1.5,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Space(20),
            titleBanner(text: "Our Team", icon: Icons.groups),
            Space(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                teamMember(
                  icon: Icons.person_2_outlined,
                  title: "CEO",
                  name: "Muhammad Ali Bin Abu",
                ),
              ],
            ),
            Space(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                teamMember(
                  icon: Icons.person_2_outlined,
                  title: "HR Manager",
                  name: "Muhammad Ali Bin Abu",
                ),
                teamMember(
                  icon: Icons.person_2_outlined,
                  title: "CO Director",
                  name: "Muhammad Ali Bin Abu",
                ),
              ],
            ),
            Space(20),
            titleBanner(text: "Our Service", icon: Icons.groups),
            Space(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ourService(
                    icon: Icons.volunteer_activism,
                    title: "Door-to-door nurse service"),
                ourService(icon: Icons.vaccines, title: "Walk-in Hospital"),
              ],
            ),
            Space(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ourService(icon: Icons.healing, title: "Ambulance Service"),
                ourService(
                    icon: Icons.medication_liquid, title: "Medicine Purchase"),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Widget ourService({required IconData icon, required String title}) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kPrimary100Color,
            ),
            child: Center(
              child: Icon(
                icon,
                color: kPrimaryColor,
                size: 28,
              ),
            ),
          ),
          Space(8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget teamMember(
      {required IconData icon, required String title, required String name}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: kPrimaryColor,
            size: 28,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            name,
            style: TextStyle(
              color: kGrey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget titleBanner({required String text, required IconData icon}) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  kPrimary100Color,
                  kPrimary100Color.withOpacity(0.1),
                ],
              ),
            ),
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 25),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(
                  width: 13,
                ),
                Icon(
                  icon,
                  color: kPrimaryColor,
                ),
                SizedBox(width: 10),
                Text(
                  text,
                  style: TextStyle(color: kBlack, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        Expanded(child: SizedBox())
      ],
    );
  }
}
