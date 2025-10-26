import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> closeRequest(String requestId) async {
  FirebaseFirestore.instance
      .collection('request')
      .doc(requestId)
      .update({'status': "closed"});
  print("success");
}

Future<void> deleteRequest(String requestId) async {
  FirebaseFirestore.instance.collection('request').doc(requestId).delete();
  print("success");
}

Future<void> ApproveRequest(String requestId, String approval) async {
  FirebaseFirestore.instance
      .collection('request')
      .doc(requestId)
      .update({'approval': approval});
  print("success");
}
