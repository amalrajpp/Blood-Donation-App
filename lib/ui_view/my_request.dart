import 'package:blood/fitness_app_theme.dart';
import 'package:blood/ui_view/accepted_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:redacted/redacted.dart';
import 'package:shimmer/shimmer.dart';

import '../models/request_model.dart';
import '../ui_view/request_card.dart';
import 'shimmer.dart';
import 'tab_item.dart';

class MyRequestScreen extends StatefulWidget {
  const MyRequestScreen({super.key, this.animationController});

  final AnimationController? animationController;
  @override
  MyRequestScreenState createState() => MyRequestScreenState();
}

class MyRequestScreenState extends State<MyRequestScreen>
    with TickerProviderStateMixin {
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
                            ? const GetMainListViewUI()
                            : const GetMainListViewUI2()),
                  ),
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
                  "Blood Requests",
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
                      TabItem(title: 'Requests', count: 0),
                      TabItem(title: 'Accepted', count: 0),
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

class GetMainListViewUI extends StatefulWidget {
  const GetMainListViewUI({super.key});

  @override
  State<GetMainListViewUI> createState() => _GetMainListViewUIState();
}

class _GetMainListViewUIState extends State<GetMainListViewUI> {
  final requestQuery = FirebaseFirestore.instance
      .collection('request')
      .where('uid', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .orderBy("date", descending: true)
      .withConverter(
        fromFirestore: (snapshot, _) => Request.fromMap(snapshot.data()!),
        toFirestore: (request, _) => request.toMap(),
      );

  @override
  Widget build(BuildContext context) {
    return FirestoreListView<Request>(
      query: requestQuery,
      pageSize: 10,
      emptyBuilder: (context) => const Center(child: Text("No request")),
      errorBuilder: (context, error, stackTrace) => Text(error.toString()),
      loadingBuilder: (context) => ShimmerCard(),
      itemBuilder: (context, doc) {
        final request = doc.data();
        return RequestCard(
            pname: request.pname,
            hname: request.hname,
            date: request.date,
            contact: request.contact,
            group: request.group,
            unit: request.unit,
            requestId: request.requestId,
            acceptedUid: request.acceptedUid);
      },
    );
  }
}

class GetMainListViewUI2 extends StatefulWidget {
  const GetMainListViewUI2({super.key});

  @override
  State<GetMainListViewUI2> createState() => GetMainListViewUI2State();
}

class GetMainListViewUI2State extends State<GetMainListViewUI2> {
  final requestQuery = FirebaseFirestore.instance
      .collection('request')
      .where('acceptedUid',
          arrayContains: FirebaseAuth.instance.currentUser!.uid)
      .orderBy("date", descending: true)
      .withConverter(
        fromFirestore: (snapshot, _) => Request.fromMap(snapshot.data()!),
        toFirestore: (request, _) => request.toMap(),
      );

  @override
  Widget build(BuildContext context) {
    return FirestoreListView<Request>(
      query: requestQuery,
      pageSize: 10,
      emptyBuilder: (context) => const Center(child: Text("No request")),
      errorBuilder: (context, error, stackTrace) => Text(error.toString()),
      loadingBuilder: (context) => ShimmerCard(),
      itemBuilder: (context, doc) {
        final request = doc.data();
        return AcceptedCard(
          pname: request.pname,
          hname: request.hname,
          date: request.date,
          contact: request.contact,
          group: request.group,
          unit: request.unit,
        );
      },
    );
  }
}
