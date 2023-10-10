import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_hub/const/firebase_const.dart';
import 'package:home_hub/custom_widget/space.dart';
import 'package:home_hub/main.dart';
import 'package:home_hub/models/provider_model.dart';
import 'package:home_hub/providers/category_provider.dart';
import 'package:home_hub/screens/location_screen.dart';
import 'package:home_hub/screens/provider_detail_screen.dart';
import 'package:home_hub/utils/colors.dart';
import 'package:provider/provider.dart';

class SupplierScreen extends StatefulWidget {
  final String categoryName;

  SupplierScreen({Key? key, required this.categoryName}) : super(key: key);

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  CategoryProvider? categoryProvider;
  String? userId;
  String? username;
  String? email;
  String? userToken;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CategoryProvider provider = Provider.of(context, listen: false);
    provider.getServiceByCategory(widget.categoryName);
    getUserData();
  }

  void getUserData() async {
    User? users = auth.currentUser;
    if (users != null) {
      setState(() {
        userId = users.uid;
      });

      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(userId).get();

      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        setState(() {
          username = userData['name'];
          email = userData['email'];
          userToken = userData['deviceToken'];
        });
      } else {
        print('User data does not exist');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of(context);
    /*CategoryProvider categoryProvider = Provider.of(context);
    categoryProvider.getServiceByCategory(widget.categoryName);*/

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        iconTheme:
            IconThemeData(color: appData.isDark ? whiteColor : blackColor),
        title: Text(
          "Service Providers",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              color: appData.isDark ? whiteColor : blackColor),
        ),
      ),
      body: categoryProvider!.providerByCategoryList.isEmpty
          ? const Center(
              child: Text('No Service Provider Found'),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              shrinkWrap: true,
              itemCount: categoryProvider!.providerByCategoryList
                  .length /*serviceProviders[widget.index].serviceProviders.length*/,
              itemBuilder: (context, index) {
                ProviderModel product =
                    categoryProvider!.providerByCategoryList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProviderDetailScreen(product: product)));
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: appData.isDark
                          ? Colors.black
                          : Colors.grey.withOpacity(0.2),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                categoryProvider!.providerByCategoryList[index]
                                    .providerImage /*serviceProviders[widget.index].serviceProviders[index].providerImage*/,
                                width: 100,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        Space(16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    categoryProvider!
                                        .providerByCategoryList[index]
                                        .providerName /*serviceProviders[widget.index].serviceProviders[index].name*/,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20),
                                  ),
                                  Space(4),
                                  Text(
                                    categoryProvider!
                                        .providerByCategoryList[index]
                                        .categoryName /*serviceProviders[widget.index].serviceProviders[index].occupation*/,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: greyColor, fontSize: 14),
                                  ),
                                  Space(4),
                                  Text(
                                    'Experience: ${categoryProvider!.providerByCategoryList[index].providerExperience}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              Space(16),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '\$${categoryProvider!.providerByCategoryList[index].providerPrice}' /*"₹${serviceProviders[widget.index].serviceProviders[index].perHourPrice}"*/,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 20),
                                          ),
                                          Space(8),
                                          ElevatedButton(
                                            child: Text(
                                              "Book",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LocationScreen(
                                                    categoryName: categoryProvider!
                                                        .providerByCategoryList[
                                                            index]
                                                        .categoryName,
                                                    providerId: categoryProvider!
                                                        .providerByCategoryList[
                                                            index]
                                                        .uid,
                                                    providerImage: categoryProvider!
                                                        .providerByCategoryList[
                                                            index]
                                                        .providerImage,
                                                    providerName: categoryProvider!
                                                        .providerByCategoryList[
                                                            index]
                                                        .providerName,
                                                    providerPrice: categoryProvider!
                                                        .providerByCategoryList[
                                                            index]
                                                        .providerPrice,
                                                    userId: userId!,
                                                    userName: username!,
                                                    userToken: userToken!,
                                                    providerDes: categoryProvider!
                                                        .providerByCategoryList[
                                                            index]
                                                        .providerDes,
                                                    providerToken: categoryProvider!
                                                        .providerByCategoryList[
                                                            index]
                                                        .deviceToken,
                                                  ) /*PaymentScreen()*/,
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: StadiumBorder(),
                                              backgroundColor: appData.isDark
                                                  ? Colors.grey.withOpacity(0.2)
                                                  : Colors.black,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 16, horizontal: 32),
                                              fixedSize: Size(140, 50),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
