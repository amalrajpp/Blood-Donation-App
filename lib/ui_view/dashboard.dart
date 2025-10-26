import 'package:blood/fitness_app_theme.dart';
import 'package:blood/ui_view/accepted_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:redacted/redacted.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:water_bottle/water_bottle.dart';
import '../flutter_whirlpool/screens/water_drawer/water_drawer.dart';
import '../mobile/theme/colors.dart';
import '../models/request_model.dart';
import '../send.dart';
import '../ui_view/request_card.dart';
import 'admin_page.dart';
import 'announcement.dart';
import 'blood_bank.dart';
import 'shimmer.dart';
import 'tab_item.dart';
import 'package:vector_math/vector_math.dart' as vmath;

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, this.animationController});

  final AnimationController? animationController;
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              getAppBarUI(),
              Column(
                children: [
                  const SizedBox(height: 155),
                  Expanded(
                      child: Container(
                          decoration: const BoxDecoration(
                            color: FitnessAppTheme.background,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: tabIndex == 0
                              ? const WelcomeUser()
                              : Container())),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fitness_app/blood1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          height: 170,
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                title: const Text(
                  "Dashboard",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                automaticallyImplyLeading: false,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 7),
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.red.shade100,
                  ),
                  child: TabBar(
                    onTap: (value) {
                      setState(() {
                        tabIndex = value;
                      });
                    },
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: const BoxDecoration(
                      color: Color(0xFFB71C1C),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black54,
                    tabs: const [
                      TabItem(title: 'User Panel', count: 0),
                      TabItem(title: 'Announcements', count: 0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Water extends StatefulWidget {
  Water({Key? key}) : super(key: key);
  @override
  WaterState createState() => WaterState();
}

class WaterState extends State<Water> {
  final sphereBottleRef = GlobalKey<SphericalBottleState>();
  var selectedStyle = 0;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => sphereBottleRef.currentState?.waterLevel = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final sphere = SphericalBottle(
      key: sphereBottleRef,
      waterColor: Colors.red,
      bottleColor: Colors.redAccent,
      capColor: Colors.grey.shade700,
    );
    final bottle = Center(
      child: SizedBox(width: 200, height: 300, child: sphere),
    );

    return Center(
      child: Container(
        width: 90,
        height: 90,
        child: bottle,
      ),
    );
  }
}

class BloodCycle extends StatefulWidget {
  const BloodCycle({super.key});

  @override
  State<BloodCycle> createState() => _BloodCycleState();
}

class _BloodCycleState extends State<BloodCycle> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: FitnessAppTheme.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
              topRight: Radius.circular(20.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: FitnessAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),
        width: 330,
        height: 260,
        child: const WaterDrawer(),
      ),
    );
  }
}

class WelcomeUser extends StatefulWidget {
  const WelcomeUser({super.key});

  @override
  State<WelcomeUser> createState() => WelcomeUserState();
}

class WelcomeUserState extends State<WelcomeUser> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          children: [
            const SizedBox(height: 50),
            _welcomeUser(
              context,
            ),
            const SizedBox(
              height: 30,
            ),
            bottle(context),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: _buildDashboardItem(
                    context,
                    icon: "assets/images/faq.png",
                    label: 'FAQ',
                    onTap: () {
                      showModalBottomSheet<void>(
                        showDragHandle: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20.0)),
                        ),
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                              height: MediaQuery.of(context).size.height - 200,
                              child: AnnouncementsScreen());
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: _buildDashboardItem(
                    context,
                    icon: "assets/images/bank.png",
                    label: 'Blood bank',
                    onTap: () {
                      showModalBottomSheet<void>(
                        showDragHandle: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20.0)),
                        ),
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                              height: MediaQuery.of(context).size.height - 200,
                              child: BloodBanksNearMeScreen());
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildDashboardItem(BuildContext context,
    {required String icon,
    required String label,
    required VoidCallback onTap}) {
  var size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: (size.width - 80) / 2,
      height: 150,
      decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
                color: black.withOpacity(0.01),
                spreadRadius: 20,
                blurRadius: 10,
                offset: const Offset(0, 10))
          ],
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: (size.width - 60) / 2,
              height: 60,
              child: Image.asset(
                icon,
                color: Colors.red,
              ),
            ),
            Spacer(),
            const Spacer(),
          ],
        ),
      ),
    ),
  );
}

Widget _welcomeUser(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 150,
    decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
              color: black.withOpacity(0.01),
              spreadRadius: 20,
              blurRadius: 10,
              offset: const Offset(0, 10))
        ],
        borderRadius: BorderRadius.circular(30)),
    child: Padding(
      padding: const EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 14, color: black),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Amal Raj P P",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: black),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: Container(
              width: 60,
              height: 60,
              child: Center(
                child: Image.asset(
                  "assets/images/welcome.png",
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget bottle(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Row(
    children: [
      Container(
        width: (size.width - 60) / 2,
        height: 320,
        decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        child: const WaterDrawer(),
      ),
      SizedBox(
        height: 320,
        width: 20,
        child: Column(
          children: [
            Container(
              height: 170,
              width: 20,
              color: FitnessAppTheme.background,
            ),
            Container(
              height: 150,
              width: 20,
              color: white,
            )
          ],
        ),
      ),
      Column(
        children: [
          GestureDetector(
            child: Container(
              width: (size.width - 60) / 2,
              height: 150,
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Guidelines',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: (size.width - 60) / 2,
                      height: 60,
                      child: Image.asset(
                        "assets/images/guide1.png",
                        color: Colors.red,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            onTap: () {
              showModalBottomSheet<void>(
                showDragHandle: true,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                ),
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        children: const [
                          Text(
                            'Eligibility Criteria',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text('• Age: 18-65 years old'),
                          Text('• Minimum weight: 50 kg'),
                          Text(
                              '• No recent infections, surgeries, or chronic diseases'),
                          SizedBox(height: 20),
                          Text(
                            'Preparation Before Donation',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text('• Hydrate well'),
                          Text('• Eat a healthy meal before donating'),
                          Text('• Avoid alcohol and caffeine'),
                          SizedBox(height: 20),
                          Text(
                            'During Donation',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text('• Relax and stay calm'),
                          Text(
                              '• Follow the instructions of the medical staff'),
                          Text('• Inform staff if you feel unwell'),
                          SizedBox(height: 20),
                          Text(
                            'Post-Donation Care',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text('• Rest for a few minutes'),
                          Text('• Drink plenty of fluids'),
                          Text(
                              '• Avoid strenuous activities for the rest of the day'),
                          SizedBox(height: 20),
                          Text(
                            'Contact Information',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                              '• For any queries or emergencies, contact us at: [Your Contact Info]'),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              width: (size.width - 60) / 2,
              height: 150,
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Last Donation",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: (size.width - 60) / 2,
                        height: 60,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              "assets/images/date1.png",
                              color: Colors.red,
                            ),
                            const Positioned(
                              bottom: 15.0, // Distance from the bottom
                              left: 0,
                              right: 0,
                              child: Text(
                                "06/12/24",
                                textAlign: TextAlign
                                    .center, // Center the text horizontally
                                style: TextStyle(
                                  color: Colors.red, // Adjust as needed
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )),
                    Spacer(),
                  ],
                ),
              ))
        ],
      ),
    ],
  );
}
