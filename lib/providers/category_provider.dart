import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_hub/const/firebase_const.dart';
import 'package:home_hub/models/category_model.dart';
import 'package:home_hub/models/provider_model.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> categoryList = [];
  List<CategoryModel> pCategoryList = [];
  List<ProviderModel> providerByCategoryList = [];

  // Category provider
  Future getCategoryData() async {
    CategoryModel categoryModel;
    List<CategoryModel> newList = [];

    QuerySnapshot data = await firestore.collection(category).get();
    for (var element in data.docs) {
      if (element.exists) {
        categoryModel = CategoryModel.fromJson(element.data());
        newList.add(categoryModel);
        notifyListeners();
      }
    }
    categoryList = newList;
    notifyListeners();
    return categoryList;
  }

  // Popular Category provider
  Future getPCategoryData() async {
    CategoryModel pCategoryModel;
    List<CategoryModel> newList1 = [];

    QuerySnapshot data = await firestore.collection(pCategory).get();
    for (var element in data.docs) {
      if (element.exists) {
        pCategoryModel = CategoryModel.fromJson(element.data());
        newList1.add(pCategoryModel);
        notifyListeners();
      }
    }
    pCategoryList = newList1;
    notifyListeners();
    return pCategoryList;
  }

  // Service Providers according to the category
  Future getServiceByCategory(String categoriesName) async {
    ProviderModel providerModel;
    List<ProviderModel> newList2 = [];

    QuerySnapshot data = await firestore.collection(providerCollection).get();
    for (var element in data.docs) {
      if (element.exists) {
        if (categoriesName == element.get("categoryName")) {
          providerModel = ProviderModel.fromJson(element.data());
          newList2.add(providerModel);
          notifyListeners();
        }
      }
    }
    providerByCategoryList = newList2;
    notifyListeners();
    return providerByCategoryList;
  }
}