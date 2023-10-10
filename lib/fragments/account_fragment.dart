import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_hub/const/firebase_const.dart';
import 'package:home_hub/controllers/auth_controller.dart';
import 'package:home_hub/fragments/bookings_fragment.dart';
import 'package:home_hub/screens/contact_us_screen.dart';
import 'package:home_hub/screens/help_center_screen.dart';
import 'package:home_hub/screens/my_profile_screen.dart';
import 'package:home_hub/screens/sign_in_screen.dart';
import 'package:home_hub/services/firestore_services.dart';
import 'package:home_hub/utils/colors.dart';
import 'package:home_hub/utils/images.dart';

import '../custom_widget/space.dart';

class AccountFragment extends StatefulWidget {
  final bool fromProfile;

  const AccountFragment({Key? key, required this.fromProfile}) : super(key: key);

  @override
  State<AccountFragment> createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {
  @override
  void initState() {
    super.initState();
    // _getDataFromFirestore();
  }

  Future<void> _showLogOutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Are you sure you want to Logout?',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
          ),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                await Get.put(AuthController()).signoutMethod();
                Get.offAll(() => SignInScreen());
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        leading: Visibility(
          visible: widget.fromProfile ? true : false,
          child: IconButton(
            icon: Icon(Icons.arrow_back, size: 20, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          "Account",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getUser(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.black),
              ),
            );
          } else {
            final data = snapshot.data!.docs[0];

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 90,
                    width: 90,
                    child: data['image'] == ''
                        ? CircleAvatar(
                            backgroundImage: AssetImage(userImage),
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(data['image']),
                          ),
                  ),
                  Space(8),
                  Text("${data['name']}",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                  Space(4),
                  Text("${data['email']}",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: secondaryColor, fontSize: 12)),
                  Space(16),
                  ListTile(
                    horizontalTitleGap: 4,
                    leading: Icon(Icons.person, size: 20),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    title: Text("My Profile"),
                    trailing: Icon(Icons.edit, size: 16),
                    onTap: () {
                      Get.to(() => MyProfileScreen(
                            data: data,
                          ));
                    },
                  ),
                  /*ListTile(
                    horizontalTitleGap: 4,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    leading: Icon(Icons.notifications, size: 20),
                    title: Text("Notifications"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationScreen()));
                    },
                  ),*/
                  ListTile(
                    horizontalTitleGap: 4,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    leading: Icon(Icons.calendar_month, size: 20),
                    title: Text("My bookings"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BookingsFragment(fromProfile: true)));
                    },
                  ),
                  ListTile(
                    horizontalTitleGap: 4,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    leading: Icon(Icons.mail, size: 20),
                    title: Text("Contact Us"),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsScreen()));
                    },
                  ),
                  ListTile(
                    horizontalTitleGap: 4,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    leading: Icon(Icons.question_mark, size: 20),
                    title: Text("Help Center"),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HelpCenterPage()));
                    },
                  ),
                  ListTile(
                    horizontalTitleGap: 4,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    leading: Icon(Icons.logout, size: 20),
                    title: Text("Logout"),
                    onTap: () {
                      _showLogOutDialog();
                    },
                  ),
                  Space(16),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
