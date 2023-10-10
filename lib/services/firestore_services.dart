import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_hub/const/firebase_const.dart';

//get users data
class FirestoreServices {
  static getUser(uid) {
    return firestore.collection(usersCollection).where('uid', isEqualTo: uid).snapshots();
  }
}

//get home banner from firebase firestore
class FirebaseService {
  CollectionReference homeBanner = firestore.collection(hBanner);
}