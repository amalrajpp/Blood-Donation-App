import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Function to add a diary entry
Future<void> acceptRequest(String requestId, int unitNo) async {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  FirebaseFirestore.instance.collection('request').doc(requestId).update({
    'acceptedUid': FieldValue.arrayUnion([uid]),
  });

  final requestDocRef =
      FirebaseFirestore.instance.collection('request').doc(requestId);
  requestDocRef.collection('acceptedUsers').doc(uid).set({
    'acceptedUid': uid,
    'unitNo': unitNo,
  });

  print("success");
}

Future<void> approveRequest(String requestId) async {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  FirebaseFirestore.instance
      .collection('request')
      .doc(requestId)
      .update({'approval': "Approved"});
  print("success");
}

Future<void> rejectRequest(String requestId) async {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  FirebaseFirestore.instance
      .collection('request')
      .doc(requestId)
      .update({'approval': "Rejected"});
  print("success");
}
