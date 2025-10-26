// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:blood/api/create_request.dart';
import 'package:blood/fitness_app_theme.dart';
import 'package:choice/choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../api/alter_request.dart';
import 'custom_textfield.dart';
import 'dateField.dart';

class MyRequestCard extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;
  final pname;
  final hname;
  final date;
  final contact;
  final group;
  final unit;
  final requestId;
  final status;
  final acceptedId;
  final approval;

  const MyRequestCard(
      {super.key,
      this.animationController,
      this.animation,
      this.pname,
      this.hname,
      this.date,
      this.contact,
      this.group,
      this.unit,
      this.requestId,
      this.status,
      this.acceptedId,
      this.approval});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: FitnessAppTheme.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(60.0),
              topRight: Radius.circular(60.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: FitnessAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 14, bottom: 4, left: 16, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Patient name',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: FitnessAppTheme.grey.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 50),
                      Text(
                        pname,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            letterSpacing: -0.1,
                            color: FitnessAppTheme.darkText),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Hospital name',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: FitnessAppTheme.grey.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 50),
                      Flexible(
                        child: Text(
                          hname,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          style: const TextStyle(
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              letterSpacing: -0.1,
                              color: FitnessAppTheme.darkText),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Date',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: FitnessAppTheme.grey.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 50),
                      Text(
                        DateFormat('dd-MM-yyyy').format(date).toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            letterSpacing: -0.1,
                            color: FitnessAppTheme.darkText),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Contact number',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: FitnessAppTheme.grey.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 50),
                      Text(
                        contact,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            letterSpacing: -0.1,
                            color: FitnessAppTheme.darkText),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 18, right: 24, top: 7, bottom: 7),
              child: Container(
                height: 2,
                decoration: const BoxDecoration(
                  color: FitnessAppTheme.background,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 5, bottom: 14),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          group,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: -0.2,
                            color: FitnessAppTheme.darkText,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            'Blood group',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: FitnessAppTheme.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              unit,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                letterSpacing: -0.2,
                                color: FitnessAppTheme.darkText,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                'Unit',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: FitnessAppTheme.grey.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        status == "open" && (approval == "Approved")
                            ? showAlertDialog(context, requestId)
                            : null;
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: FitnessAppTheme.grey.withOpacity(0.06),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                                topRight: Radius.circular(15.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color:
                                      FitnessAppTheme.grey.withOpacity(0.0005),
                                  offset: const Offset(2, 2),
                                  blurRadius: 4),
                            ]),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                status == "open" ? "close" : "closed",
                                style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    letterSpacing: 0.0,
                                    color: Colors.red[900]),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.check_circle,
                                color: Color(0xFFB71C1C),
                                size: 13,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: FitnessAppTheme.background,
              height: 4,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 24, left: 16, right: 27),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 95,
                        height: 45,
                        decoration: BoxDecoration(
                          color: FitnessAppTheme.grey.withOpacity(0.06),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                              topRight: Radius.circular(15.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: FitnessAppTheme.grey.withOpacity(0.0005),
                                offset: const Offset(2, 2),
                                blurRadius: 4),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                child: const Icon(Icons.edit_note_sharp,
                                    color: Color(0xFFB71C1C)),
                                onTap: () {
                                  (approval == "Pending")
                                      ? showModalBottomSheet(
                                          backgroundColor:
                                              FitnessAppTheme.background,
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                          ),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          builder: (BuildContext context) {
                                            return EditRequest(
                                                pname: pname,
                                                hname: hname,
                                                date: date,
                                                contact: contact,
                                                group: group,
                                                unit: unit,
                                                requestId: requestId);
                                          },
                                        )
                                      : () {};
                                },
                              ),
                              Container(
                                height: double.infinity,
                                width: 1.5,
                                color: Colors.white,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  (approval == "Pending")
                                      ? showAlertDialog2(context, requestId)
                                      : () {};
                                },
                                child: const Icon(Icons.delete_outline_rounded,
                                    color: Color(0xFFB71C1C)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      (approval == "Approved")
                          ? GestureDetector(
                              onTap: () async {
                                if (acceptedId.length != 0) {
                                  showModalBottomSheet(
                                    backgroundColor: FitnessAppTheme.background,
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: StreamBuilder<
                                            QuerySnapshot<
                                                Map<String, dynamic>>>(
                                          stream: FirebaseFirestore.instance
                                              .collection('request')
                                              .doc(requestId)
                                              .collection('acceptedUsers')
                                              .snapshots(),
                                          builder: (_, snapshot) {
                                            if (snapshot.hasError) {
                                              return Text(
                                                  'Error = ${snapshot.error}');
                                            }

                                            if (snapshot.hasData) {
                                              final acceptedUsers =
                                                  snapshot.data!.docs;

                                              final userFutures = acceptedUsers
                                                  .map((acceptedUserDoc) async {
                                                final data =
                                                    acceptedUserDoc.data();
                                                final uid = data['acceptedUid']
                                                    as String;
                                                final unitNo =
                                                    data['unitNo'] as int;

                                                final userDoc =
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('user')
                                                        .doc(uid)
                                                        .get();

                                                final userData = userDoc.data();

                                                return {
                                                  'name': userData?['name'] ??
                                                      'Unknown',
                                                  'phone': userData?['phone'] ??
                                                      'Unknown',
                                                  'unitNo': unitNo,
                                                };
                                              }).toList();

                                              return FutureBuilder<
                                                  List<Map<String, dynamic>>>(
                                                future:
                                                    Future.wait(userFutures),
                                                builder: (_, userSnapshot) {
                                                  if (userSnapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  }

                                                  if (userSnapshot.hasError) {
                                                    return Text(
                                                        'Error = ${userSnapshot.error}');
                                                  }

                                                  if (userSnapshot.hasData) {
                                                    final users =
                                                        userSnapshot.data!;

                                                    return ListView.builder(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15.0,
                                                          vertical: 20.0),
                                                      itemCount: users.length,
                                                      itemBuilder: (_, i) {
                                                        final user = users[i];

                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 12.0),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  FitnessAppTheme
                                                                      .white,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    15.0),
                                                              ),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: FitnessAppTheme
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.2),
                                                                  offset:
                                                                      const Offset(
                                                                          0, 2),
                                                                  blurRadius:
                                                                      8.0,
                                                                ),
                                                              ],
                                                            ),
                                                            child: ListTile(
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal:
                                                                    16.0,
                                                              ),
                                                              leading:
                                                                  CircleAvatar(
                                                                radius: 24.0,
                                                                backgroundColor:
                                                                    FitnessAppTheme
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.1),
                                                                child: Text(
                                                                  user['unitNo']
                                                                      .toString(),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                                ),
                                                              ),
                                                              title: Text(
                                                                user['name'],
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      16.0,
                                                                ),
                                                              ),
                                                              subtitle: Text(
                                                                user['phone'],
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      14.0,
                                                                ),
                                                              ),
                                                              trailing: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  await makePhoneCall(
                                                                      user[
                                                                          'phone']);
                                                                },
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24.0),
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FitnessAppTheme
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.2),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .phone_enabled,
                                                                    color: Colors
                                                                        .black,
                                                                    size: 20.0,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  }

                                                  return const Center(
                                                    child:
                                                        Text('No users found'),
                                                  );
                                                },
                                              );
                                            }

                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              child: Container(
                                width: 155,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.15),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      bottomLeft: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: FitnessAppTheme.grey
                                            .withOpacity(0.0005),
                                        offset: const Offset(2, 2),
                                        blurRadius: 4),
                                  ],
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        acceptedId.length == 0
                                            ? "0 response"
                                            : (acceptedId.length > 1
                                                ? "${acceptedId.length.toString()} responses"
                                                : "${acceptedId.length.toString()} response"),
                                        style: TextStyle(
                                            fontFamily:
                                                FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color: Colors.red[900]),
                                      ),
                                      Container(
                                        height: double.infinity,
                                        width: 1,
                                        color: Colors.white,
                                      ),
                                      const Icon(Icons.forum,
                                          color: Color(0xFFB71C1C)),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: 155,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.15),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: FitnessAppTheme.grey
                                          .withOpacity(0.0005),
                                      offset: const Offset(2, 2),
                                      blurRadius: 4),
                                ],
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      approval,
                                      style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          letterSpacing: 0.0,
                                          color: Colors.red[900]),
                                    ),
                                    Container(
                                      height: double.infinity,
                                      width: 1,
                                      color: Colors.white,
                                    ),
                                    approval == "Pending"
                                        ? const Icon(Icons.timelapse,
                                            color: Color(0xFFB71C1C))
                                        : const Icon(Icons.dangerous_sharp,
                                            color: Color(0xFFB71C1C)),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context, String requestId) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Confirm Closing'),
          content: Text('Are you sure you want to close this blood request?'),
          actions: <Widget>[
            TextButton(
                onPressed: () async {
                  await closeRequest(requestId);
                  Navigator.pop(context);
                  final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      color: Colors.red[900],
                      title: 'Closed',
                      message: 'Request closed successfully .',

                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                },
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.red[900]),
                )),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Dialog
              },
              child: Text('Cancel', style: TextStyle(color: Colors.red[900])),
            )
          ],
        );
      });
}

void showAlertDialog2(BuildContext context, String requestId) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Confirm Deletion'),
          content:
              const Text('Are you sure you want to delete this blood request?'),
          actions: <Widget>[
            TextButton(
                onPressed: () async {
                  await deleteRequest(requestId);
                  Navigator.pop(context);
                  final snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      color: Colors.red[900],
                      title: 'Deleted',
                      message: 'Request deleted successfully .',
                      contentType: ContentType.success,
                    ),
                  );

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                },
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.red[900]),
                )),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Dialog
              },
              child: Text('Cancel', style: TextStyle(color: Colors.red[900])),
            )
          ],
        );
      });
}

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

class EditRequest extends StatefulWidget {
  const EditRequest({
    super.key,
    this.pname,
    this.hname,
    this.date,
    this.contact,
    this.group,
    this.unit,
    this.requestId,
  });

  final pname;
  final hname;
  final date;
  final contact;
  final group;
  final unit;
  final requestId;
  @override
  State<EditRequest> createState() => _EditRequestState();
}

class _EditRequestState extends State<EditRequest> {
  final pnameController = TextEditingController();
  final hnameController = TextEditingController();
  final numberController = TextEditingController();
  final dateController = TextEditingController();
  final unitController = TextEditingController();
  String? selectedValue;
  @override
  void initState() {
    pnameController.text = widget.pname;
    hnameController.text = widget.hname;
    numberController.text = widget.contact;
    dateController.text =
        DateFormat('dd-MM-yyyy').format(widget.date).toString();
    unitController.text = widget.unit;
    selectedValue = widget.group;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> choices = ['A+', 'B+', 'O+', 'AB+', 'A-', 'B-', 'O-', 'AB-'];
    int tabIndex = 0;
    void setSelectedValue(String? value) {
      setState(() => selectedValue = value);
    }

    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          CustomTextField(
            controller: pnameController,
            name: "Patient name",
            prefixIcon: Icons.person_outline,
            inputType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 6),
          CustomTextField(
            controller: hnameController,
            name: "Hospital name",
            prefixIcon: Icons.person_outline,
            inputType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
          ),
          Container(
            decoration: BoxDecoration(
              color: FitnessAppTheme.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topRight: Radius.circular(60.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: FitnessAppTheme.grey.withOpacity(0.2),
                    offset: const Offset(1.1, 1.1),
                    blurRadius: 10.0),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15),
                  child: Text(
                    'Blood group',
                    style: TextStyle(
                      fontFamily: FitnessAppTheme.fontName,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: FitnessAppTheme.grey.withOpacity(0.5),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: InlineChoice<String>.single(
                    clearable: true,
                    value: selectedValue,
                    onChanged: setSelectedValue,
                    itemCount: choices.length,
                    itemBuilder: (state, i) {
                      return ChoiceChip(
                        selectedColor: Colors.red[100],
                        backgroundColor: Colors.red[50],
                        checkmarkColor: const Color.fromARGB(255, 133, 16, 16),
                        selected: state.selected(choices[i]),
                        onSelected: state.onSelected(choices[i]),
                        label: Text(choices[i]),
                      );
                    },
                    listBuilder: ChoiceList.createWrapped(
                      spacing: 10,
                      runSpacing: 10,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 5,
                child: DateField(
                  controller: dateController,
                  name: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                  prefixIcon: Icons.calendar_month,
                  inputType: TextInputType.datetime,
                  textCapitalization: TextCapitalization.words,
                ),
              ),
              Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: CustomTextField(
                    controller: unitController,
                    name: "Unit",
                    prefixIcon: Icons.boy,
                    inputType: TextInputType.number,
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          CustomTextField(
            controller: numberController,
            name: "Contact number",
            prefixIcon: Icons.contact_page,
            inputType: TextInputType.number,
            textCapitalization: TextCapitalization.words,
          ),
          GestureDetector(
            onTap: () async {
              await updateRequest(
                  widget.requestId,
                  pnameController.text,
                  hnameController.text,
                  unitController.text,
                  numberController.text,
                  selectedValue!,
                  widget.date);
              final snackBar = SnackBar(
                /// need to set following properties for best effect of awesome_snackbar_content
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  color: Colors.red[900],
                  title: 'Requested',
                  message: 'Request updated successfully .',

                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                  contentType: ContentType.success,
                ),
              );

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);

              Navigator.pop(context);
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.red[900],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: FitnessAppTheme.grey.withOpacity(0.2),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: const Center(
                child: Text(
                  "Update",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 85,
          )
        ],
      ),
    ));
  }
}
