import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String pname;
  String hname;
  DateTime date;
  String contact;
  String group;
  String unit;
  String status;
  String requestId;
  List<String> acceptedUid;
  List<AcceptedUser> acceptedUsers;
  String approval;

  Request(
      {required this.pname,
      required this.hname,
      required this.date,
      required this.contact,
      required this.group,
      required this.unit,
      required this.status,
      required this.requestId,
      required this.acceptedUid,
      required this.acceptedUsers,
      required this.approval});

  Map<String, dynamic> toJson() => {
        "pname": pname,
        "hname": hname,
        "date": date,
        "contact": contact,
        "group": group,
        "unit": unit,
        "status": status,
        "requestId": requestId,
        "acceptedUid": acceptedUid,
        "approval": approval
      };
  factory Request.fromMap(Map<String, dynamic> data) {
    return Request(
        pname: data['pname'] as String,
        hname: data['hname'] as String,
        date: (data['date'] as Timestamp).toDate(),
        contact: data['contact'] as String,
        group: data['group'] as String,
        unit: data['unit'] as String,
        status: data['status'] as String,
        requestId: data['requestId'] as String,
        acceptedUid: data['acceptedUid'] == null
            ? []
            : (data['acceptedUid'] as List<dynamic>).cast<String>(),
        acceptedUsers: [],
        approval: data['approval'] as String);
  }

  Map<String, dynamic> toMap() => {
        'pname': pname,
        'hname': hname,
        'date': date,
        'contact': contact,
        'group': group,
        'unit': unit,
        'status': status,
        'requestId': requestId,
        'acceptedUid': acceptedUid,
        'approval': approval
      };
}

class AcceptedUser {
  String uid;
  int unitNo;

  AcceptedUser({required this.uid, required this.unitNo});

  Map<String, dynamic> toJson() => {
        'acceptedUid': uid,
        'unitNo': unitNo,
      };

  factory AcceptedUser.fromMap(Map<String, dynamic> data) {
    return AcceptedUser(
      uid: data['acceptedUid'] as String,
      unitNo: data['unitNo'] as int,
    );
  }
}
