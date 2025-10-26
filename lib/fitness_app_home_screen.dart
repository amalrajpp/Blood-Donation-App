import 'package:blood/models/tabIcon_data.dart';
import 'package:blood/ui_view/admin_page.dart';
import 'package:blood/ui_view/user_table.dart';
import 'package:flutter/material.dart';
import 'fitness_app_theme.dart';
import 'ui_view/bottom_navy_bar.dart';
import 'ui_view/create_request.dart';
import 'ui_view/dashboard.dart';
import 'ui_view/details_screen.dart';
import 'ui_view/my_request.dart';
import 'ui_view/profile_page.dart';
import 'ui_view/user_role.dart';

class FitnessAppHomeScreen extends StatefulWidget {
  const FitnessAppHomeScreen({super.key});

  @override
  _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();
}

class _FitnessAppHomeScreenState extends State<FitnessAppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  int _currentIndex = 0;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyRequestScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: bottomBar(),
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return BottomNavyBar(
      showElevation: true, // use this to remove appBar's elevation
      items: [
        BottomNavyBarItem(
          icon: const Icon(Icons.view_headline_sharp),
          title: const Text('Requests'),
          activeColor: Colors.red[900]!,
        ),
        BottomNavyBarItem(
            icon: const Icon(Icons.add_box),
            title: const Text('Create'),
            activeColor: Colors.red[900]!),
        (UserManager().role == "admin")
            ? BottomNavyBarItem(
                icon: const Icon(Icons.fact_check_rounded),
                title: const Text('Approval'),
                activeColor: Colors.red[900]!,
              )
            : BottomNavyBarItem(
                icon: const Icon(Icons.dashboard),
                title: const Text('Dashboard'),
                activeColor: Colors.red[900]!),
        BottomNavyBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
            activeColor: Colors.red[900]!),
      ],
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
      selectedIndex: _currentIndex,
      onItemSelected: (index) => setState(() {
        _currentIndex = index;
        if (index == 0) {
          animationController?.reverse().then<dynamic>((data) {
            if (!mounted) {
              return;
            }
            setState(() {
              tabBody =
                  MyRequestScreen(animationController: animationController);
            });
          });
        } else if (index == 1) {
          animationController?.reverse().then<dynamic>((data) {
            if (!mounted) {
              return;
            }
            setState(() {
              tabBody =
                  CreateRequestScreen(animationController: animationController);
            });
          });
        } else if (index == 2) {
          animationController?.reverse().then<dynamic>((data) {
            if (!mounted) {
              return;
            }
            setState(() {
              tabBody =
                  UserManager().role == "admin" ? AdminPage() : Dashboard();
            });
          });
        } else if (index == 3) {
          animationController?.reverse().then<dynamic>((data) {
            if (!mounted) {
              return;
            }
            setState(() {
              tabBody = const AccountScreen();
            });
          });
        }
      }),
    );
  }
}
