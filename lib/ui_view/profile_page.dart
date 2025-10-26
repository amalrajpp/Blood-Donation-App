import 'package:blood/ui_view/shimmer.dart';
import 'package:blood/ui_view/user_table.dart';
import 'package:blood/widgets/setting_item.dart';
import 'package:blood/widgets/setting_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../fitness_app_theme.dart';
import '../phone_auth/login.dart';
import 'tab_item.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isDarkMode = false;
  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        body: Stack(
          children: [
            getAppBarUI(),
            tabIndex == 0 ? getMainListViewUI() : getMainListViewUI2()
          ],
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
                  "Profile",
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
                      TabItem(title: 'Account', count: 0),
                      TabItem(title: 'Details', count: 0),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return Column(
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SettingItem(
                          title: "User List",
                          icon: Ionicons.people,
                          bgColor: FitnessAppTheme.background,
                          iconColor: Colors.black,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        FirestoreTable()));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SettingItem(
                          title: "Preference",
                          icon: Ionicons.options,
                          bgColor: FitnessAppTheme.background,
                          iconColor: Colors.black,
                          onTap: () {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    /*  Container(
                      height: 60,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SettingItem(
                          title: "Language",
                          icon: Ionicons.earth,
                          bgColor: FitnessAppTheme.background,
                          iconColor: Colors.black,
                          value: "English",
                          onTap: () {},
                        ),
                      ),
                    ), 
                    const SizedBox(height: 20), */
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SettingItem(
                          title: "Notifications",
                          icon: Ionicons.notifications,
                          bgColor: FitnessAppTheme.background,
                          iconColor: Colors.black,
                          onTap: () {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    /*  Container(
                      height: 60,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8, top: 8, bottom: 8),
                        child: SettingSwitch(
                          title: "Dark Mode",
                          icon: Ionicons.moon,
                          bgColor: FitnessAppTheme.background,
                          iconColor: Colors.black,
                          value: isDarkMode,
                          onTap: (value) {
                            setState(() {
                              isDarkMode = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),*/
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SettingItem(
                          title: "Help",
                          icon: Ionicons.nuclear,
                          bgColor: FitnessAppTheme.background,
                          iconColor: Colors.black,
                          onTap: () {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SettingItem(
                          title: "Logout",
                          icon: Ionicons.log_out,
                          bgColor: FitnessAppTheme.background,
                          iconColor: Colors.black,
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getMainListViewUI2() {
    return Column(
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
            child: ListView(
              padding: const EdgeInsets.only(
                  left: 13, right: 13, top: 18, bottom: 65),
              children: const [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 17.0),
                  child: Text(
                    "Personal details",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                UserDetails(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class UserDetails extends StatelessWidget {
  const UserDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('user').doc(uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 1500,
            child: ShimmerCard(),
          );
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('User not found'));
        }

        var user = snapshot.data!.data() as Map<String, dynamic>;

        return Column(
          children: [
            Card(
              margin: const EdgeInsets.all(20),
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      iconColor: FitnessAppTheme.grey,
                      textColor: FitnessAppTheme.grey,
                      leading: const Icon(Icons.phone_android, size: 25),
                      title: const Text(
                        "Mobile",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      subtitle: Text(
                        user['phone'],
                        style:
                            const TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      dense: true,
                    ),
                    ListTile(
                      iconColor: FitnessAppTheme.grey,
                      textColor: FitnessAppTheme.grey,
                      leading: const Icon(Icons.mail, size: 25),
                      title: const Text(
                        "Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      subtitle: Text(
                        FirebaseAuth.instance.currentUser!.email!,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      dense: true,
                    ),
                    ListTile(
                      iconColor: FitnessAppTheme.grey,
                      textColor: FitnessAppTheme.grey,
                      leading: const Icon(Icons.web_asset, size: 25),
                      title: const Text(
                        "Date of birth",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      subtitle: Text(
                        user['dob'],
                        style:
                            const TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      dense: true,
                    ),
                    ListTile(
                      iconColor: FitnessAppTheme.grey,
                      textColor: FitnessAppTheme.grey,
                      leading: const Icon(Icons.location_on_outlined, size: 25),
                      title: const Text(
                        "District",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      subtitle: Text(
                        user['district'],
                        style:
                            const TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      dense: true,
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(20),
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      iconColor: FitnessAppTheme.grey,
                      textColor: FitnessAppTheme.grey,
                      leading: const Icon(Icons.person, size: 25),
                      title: const Text(
                        "Gender",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      subtitle: Text(
                        user['gender'],
                        style:
                            const TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      dense: true,
                    ),
                    ListTile(
                      iconColor: FitnessAppTheme.grey,
                      textColor: FitnessAppTheme.grey,
                      leading: const Icon(Icons.bloodtype_sharp, size: 25),
                      title: const Text(
                        "Blood Group",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      subtitle: Text(
                        user['group'],
                        style:
                            const TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      dense: true,
                    ),
                    ListTile(
                      iconColor: FitnessAppTheme.grey,
                      textColor: FitnessAppTheme.grey,
                      leading:
                          const Icon(Icons.monitor_weight_outlined, size: 25),
                      title: const Text(
                        "Weight",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      subtitle: Text(
                        user['weight'],
                        style:
                            const TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      dense: true,
                    ),
                    ListTile(
                      iconColor: FitnessAppTheme.grey,
                      textColor: FitnessAppTheme.grey,
                      leading: const Icon(Icons.calendar_month, size: 25),
                      title: const Text(
                        "Last donation",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      subtitle: Text(
                        user['lastDonation'],
                        style:
                            const TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      dense: true,
                    ),
                  ],
                ),
              ),
            ),
            const Card(
              margin: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    iconColor: FitnessAppTheme.grey,
                    textColor: FitnessAppTheme.grey,
                    leading: const Icon(Icons.checklist_rtl, size: 25),
                    title: Text(
                      "Status",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    subtitle: Text(
                      "Available",
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    ),
                    dense: true,
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
