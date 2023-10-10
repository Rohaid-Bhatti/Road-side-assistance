import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_hub/const/firebase_const.dart';
import 'package:home_hub/models/provider_model.dart';
import 'package:home_hub/screens/location_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../custom_widget/space.dart';
import '../main.dart';
import '../utils/colors.dart';

class ProviderDetailScreen extends StatefulWidget {
  //my code
  final ProviderModel product;

  const ProviderDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProviderDetailScreen> createState() => _ProviderDetailScreenState();
}

class _ProviderDetailScreenState extends State<ProviderDetailScreen> {
  //for booking service sending data to firestore
  String? userId;
  String? username;
  String? email;
  String? userToken;

  //phone launcher code
  late String phoneNumber;

  @override
  void initState() {
    super.initState();
    phoneNumber = widget.product.providerNumber;
    getUserData();
  }

  // for getting the data of current user
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

  // for showing phone book
  void addToPhoneBook() async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // for launching messages app
  void _openMessageApp() async {
    final Uri uri = Uri(
      scheme: 'sms',
      path: phoneNumber, // Replace with the desired number
    );

    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch messaging app';
    }
  }

  // for launching whatsapp
  void _openWhatsApp() async {
    final Uri uri = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: '/$phoneNumber', // Replace with the desired number
    );

    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  // for showing bottom sheet
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder( // Add this line to set a custom shape
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 20,),
            ListTile(
              leading: Image.asset('assets/icons/messages.png', height: 35,),
              title: Text('Messages'),
              onTap: () {
                // Handle message option
                _openMessageApp();
                Navigator.pop(context); // Close the bottom sheet
              },
            ),
            const SizedBox(height: 12,),
            ListTile(
              leading: Image.asset('assets/icons/whatsapp.png', height: 35,),
              title: Text('WhatsApp'),
              onTap: () {
                // Handle WhatsApp option
                _openWhatsApp();
                Navigator.pop(context); // Close the bottom sheet
              },
            ),
            const SizedBox(height: 20,),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: transparent,
          title: Text(
            "Details",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.message_outlined, size: 22),
              onPressed: () {
                _showBottomSheet(context);
              },
            ),
          ],
        ),
        bottomSheet: BottomSheet(
          elevation: 10,
          enableDrag: false,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          primary: appData.isDark ? whiteColor : blackColor,
                          fixedSize: Size(MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height * 0.06),
                          shape: StadiumBorder(),
                          side: BorderSide(
                              color: appData.isDark ? whiteColor : blackColor,
                              width: 1)),
                      child: Icon(Icons.call_rounded /*message_rounded*/,
                          size: 20),
                      onPressed: () {
                        addToPhoneBook();
                      },
                    ),
                  ),
                  Space(16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.height * 0.06),
                        shape: StadiumBorder(),
                      ),
                      child: Text("Book"),
                      onPressed: () {
                        // sendDataToFirestore();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocationScreen(
                                      categoryName: widget.product.categoryName,
                                      providerId: widget.product.uid,
                                      providerImage:
                                          widget.product.providerImage,
                                      providerName: widget.product.providerName,
                                      providerPrice:
                                          widget.product.providerPrice,
                                      userId: userId!,
                                      userName: username!,
                                      userToken: userToken!,
                                      providerDes: widget.product.providerDes,
                                      providerToken: widget.product.deviceToken,
                                    )));
                      },
                    ),
                  ),
                ],
              ),
            );
          },
          onClosing: () {},
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  /*serviceProviders[widget.serviceIndex].serviceProviders[widget.index].name*/
                  widget.product.providerName,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                ),
              ),
              Space(8),
              Padding(
                padding: EdgeInsets.all(16),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        foregroundDecoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              blackColor,
                              transparent,
                              transparent,
                              transparent
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0, 0.2, 0.8, 1],
                          ),
                        ),
                        child: Image.network(
                          widget.product.providerImage,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 8,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text("share",
                                      style: TextStyle(
                                          color: whiteColor, fontSize: 14)),
                                  Space(4),
                                  Icon(
                                    Icons.share,
                                    color: whiteColor,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  /*serviceProviders[widget.serviceIndex].serviceProviders[widget.index].detailDescription*/
                  'Category Name : ${widget.product.categoryName}',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Space(12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.product.providerDes,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 6,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: subTitle, fontSize: 14),
                ),
              ),
              Space(70),
            ],
          ),
        ),
      ),
    );
  }
}
