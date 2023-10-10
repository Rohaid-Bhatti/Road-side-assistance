import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

//collection
const usersCollection = "users";
const hBanner = "homeBanner";
const category = "categories";
const pCategory = "pCategories";
const providerCollection = "serviceProvider";
const activeBookingCollection = "activeBooking";
const lastBookingCollection = "lastBooking";