import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_hub/const/firebase_const.dart';
import 'package:home_hub/models/active_bookings_model.dart';
import 'package:home_hub/models/last_bookings_model.dart';

class BookingProvider with ChangeNotifier {
  List<ActiveBookingModel> activeList = [];
  List<LastBookingModel> lastList = [];

  //get active booking data according to the user id
  Future getActiveBookingData(String userId) async {
    ActiveBookingModel activeBookingModel;
    List<ActiveBookingModel> newList2 = [];

    QuerySnapshot data = await firestore.collection(activeBookingCollection).get();
    for (var element in data.docs) {
      if (element.exists) {
        if (userId == element.get("userId")) {
          activeBookingModel = ActiveBookingModel.fromJson(element.data());
          newList2.add(activeBookingModel);
          notifyListeners();
        }
      }
    }
    activeList = newList2;
    notifyListeners();
    return activeList;
  }

  //get last booking data according to the user id
  Future getLastBookingData(String userId) async {
    LastBookingModel lastBookingModel;
    List<LastBookingModel> newList = [];

    QuerySnapshot data = await firestore.collection(lastBookingCollection).get();
    for (var element in data.docs) {
      if (element.exists) {
        if (userId == element.get("userId")) {
          lastBookingModel = LastBookingModel.fromJson(element.data());
          newList.add(lastBookingModel);
          notifyListeners();
        }
      }
    }
    lastList = newList;
    notifyListeners();
    return lastList;
  }
}