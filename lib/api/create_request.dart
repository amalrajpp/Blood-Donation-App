import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Function to add a diary entry
Future<void> createRequest(
    String patientName,
    String hospitalName,
    String unit,
    String contact,
    String bloodGroup,
    String section,
    DateTime entryDate) async {
  final userDocRef = FirebaseFirestore.instance.collection('request').doc();
  String uid = FirebaseAuth.instance.currentUser!.uid;
  userDocRef.set({
    'pname': patientName,
    'hname': hospitalName,
    'group': bloodGroup,
    'contact': contact,
    'unit': unit,
    'status': "open",
    'date': entryDate,
    'uid': uid,
    'requestId': userDocRef.id,
    'approval': "Pending",
    'section': section
  });
  print("success");
}

Future<void> registerUser(
    String userName,
    String district,
    String city,
    String group,
    String gender,
    String dateOfBirth,
    String weight,
    String number,
    String lastDonation) async {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  final userDocRef = FirebaseFirestore.instance.collection('user').doc(uid);

  userDocRef.update({
    'name': userName,
    'district': district,
    'city': city,
    'group': group,
    'gender': gender,
    'dob': dateOfBirth,
    'weight': weight,
    'phone': number,
    'lastDonation': lastDonation,
    'role': "user"
  });
  print("success");
}

Future<void> updateRequest(
    String requestId,
    String patientName,
    String hospitalName,
    String unit,
    String contact,
    String bloodGroup,
    DateTime entryDate) async {
  final userDocRef =
      FirebaseFirestore.instance.collection('request').doc(requestId);
  String uid = FirebaseAuth.instance.currentUser!.uid;
  userDocRef.update({
    'pname': patientName,
    'hname': hospitalName,
    'group': bloodGroup,
    'contact': contact,
    'unit': unit,
    'status': "open",
    'date': entryDate,
    'uid': uid,
    'requestId': userDocRef.id,
    'approval': "Pending"
  });
  print("success");
}
