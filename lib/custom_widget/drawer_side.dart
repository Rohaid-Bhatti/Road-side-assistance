import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:home_hub/controllers/auth_controller.dart';
import 'package:home_hub/custom_widget/space.dart';
import 'package:home_hub/fragments/account_fragment.dart';
import 'package:home_hub/fragments/bookings_fragment.dart';
import 'package:home_hub/main.dart';
import 'package:home_hub/providers/user_provider.dart';
import 'package:home_hub/screens/contact_us_screen.dart';
import 'package:home_hub/screens/help_center_screen.dart';
import 'package:home_hub/screens/sign_in_screen.dart';
import 'package:home_hub/utils/colors.dart';
import 'package:home_hub/utils/widgets.dart';

class DrawerSide extends StatefulWidget {
  UserProvider userProvider;

  DrawerSide({required this.userProvider, Key? key}) : super(key: key);

  @override
  State<DrawerSide> createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {

  Future<void> showLogOutDialog() async {
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
    var userData = widget.userProvider.currentUserData;
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Container(
              padding:
              EdgeInsets.only(left: 24, right: 24, top: 40, bottom: 24),
              color: appData.isDark ? Colors.black : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 16, left: 16, bottom: 12),
                    child: ProfilePicture(
                      name: userData.name,
                      radius: 30,
                      fontsize: 24,
                      // img: 'assets/'+userImage[index],
                      random: false,
                    ),
                  ),
                  Space(4),
                  Text(
                    userData.name,
                    style: TextStyle(
                        fontSize: 18,
                        color: appData.isDark ? whiteColor : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Space(4),
                  Text(userData.email, style: TextStyle(color: secondaryColor)),
                ],
              ),
            ),
            drawerWidget(
              drawerTitle: "My Profile",
              drawerIcon: Icons.person,
              drawerOnTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AccountFragment(fromProfile: true,)));
              },
            ),
            /*drawerWidget(
              drawerTitle: "Notifications",
              drawerIcon: Icons.notifications,
              drawerOnTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationScreen()));
              },
            ),*/
            drawerWidget(
              drawerTitle: "My bookings",
              drawerIcon: Icons.calendar_month,
              drawerOnTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BookingsFragment(fromProfile: true)),
                );
              },
            ),
            drawerWidget(
              drawerTitle: "Contact Us",
              drawerIcon: Icons.mail,
              drawerOnTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContactUsScreen()));
              },
            ),
            drawerWidget(
              drawerTitle: "Help Center",
              drawerIcon: Icons.question_mark_rounded,
              drawerOnTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HelpCenterPage()));
              },
            ),
            drawerWidget(
              drawerTitle: "Logout",
              drawerIcon: Icons.logout,
              drawerOnTap: () {
                Navigator.pop(context);
                showLogOutDialog();
              },
            ),
          ],
        ),
      ),
    );
  }
}
