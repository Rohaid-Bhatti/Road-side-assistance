import 'package:flutter/material.dart';
import 'package:home_hub/screens/dashboard_screen.dart';
import 'package:home_hub/utils/colors.dart';

import '../custom_widget/space.dart';
import '../main.dart';

class LastBookingScreen extends StatelessWidget {
  const LastBookingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BottomSheet(
        elevation: 10,
        enableDrag: false,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.06),
                shape: StadiumBorder(),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("Go Back Home", style: TextStyle(fontSize: 16)),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => DashBoardScreen()),
                  (route) => false,
                );
              },
            ),
          );
        },
        onClosing: () {},
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 0.6, spreadRadius: 1),
                  ],
                  color: appData.isDark ? Colors.black : whiteColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.done, size: 80, color: appData.isDark ? whiteColor : blackColor),
              ),
              Space(16),
              Text(/*cancel ? "Cancelled!!" :*/ "Confirmed", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
              Space(32),
              Text(
                /*cancel ? "Your booking has been cancelled successfully" : */"Your booking has been confirmed"/*$date*/,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: greyColor),
              ),
              /*Visibility(
                visible: cancel ? false : true,
                child: Column(
                  children: [
                    Space(8),
                    Text(
                      "You will get an email with the booking details",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Space(32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.timer_outlined, color: greyColor),
                        Space(4),
                        Text(time, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                        Space(4),
                        Text("on", style: TextStyle(color: greyColor, fontSize: 13)),
                        Space(4),
                        Text(weekday, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                      ],
                    )
                  ],
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
