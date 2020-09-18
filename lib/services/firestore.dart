import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  final firestoreInstance = FirebaseFirestore.instance;

  Future saveUserData(name, email, password, dob, address, userID) async {
    var result = await firestoreInstance.collection('users').add({
      "name": name,
      "email": email,
      "password": password,
      "dob": dob,
      "address": address,
      "userID": userID
    });
    return result;
  }
}
