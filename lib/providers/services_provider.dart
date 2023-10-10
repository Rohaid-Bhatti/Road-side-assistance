import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_hub/const/firebase_const.dart';
import 'package:home_hub/models/provider_model.dart';

class ServicesProvider with ChangeNotifier {
  List<ProviderModel> providerList = [];

  Future getServiceProvider() async {
    ProviderModel providerModel;
    List<ProviderModel> newList = [];

    QuerySnapshot data = await firestore.collection(providerCollection).get();
    for (var element in data.docs) {
      if (element.exists) {
        providerModel = ProviderModel.fromJson(element.data());
        newList.add(providerModel);
        notifyListeners();
      }
    }
    providerList = newList;
    notifyListeners();
    return providerList;
  }
}
