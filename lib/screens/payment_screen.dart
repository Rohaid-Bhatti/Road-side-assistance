import 'package:flutter/material.dart';
import 'package:home_hub/components/payment_container.dart';
import 'package:home_hub/screens/last_booking_screen.dart';

import '../custom_widget/space.dart';
import '../main.dart';
import '../utils/colors.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title: Text(
          "Payment",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      bottomSheet: BottomSheet(
        elevation: 10,
        enableDrag: false,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LastBookingScreen(
                      /*cancel: false,
                      weekday: "Monday",
                      date: "01-03-2023",
                      time: "9:24 am",*/
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: appData.isDark
                      ? bottomContainerDark
                      : bottomContainerBorder,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                      color: appData.isDark
                          ? bottomContainerTextDark
                          : bottomContainerText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        onClosing: () {},
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
            Space(10),
            PaymentContainer(
                title: "Cash On Delivery", icon: Icons.delivery_dining),
            Space(16),
            Divider(height: 10, color: Colors.grey, thickness: 1,),
            Space(16),
            Text(
              'Up Coming',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            ),
            Space(10),
            PaymentContainer(title: "Net Banking", icon: Icons.food_bank),
            Space(16),
            PaymentContainer(
                title: "Credit & Debit Cards", icon: Icons.credit_card),
            Space(16),
            PaymentContainer(title: "Wallets", icon: Icons.wallet),
            /*Space(16),
            PaymentContainer(
                title: "UPIs", icon: Icons.book_online_rounded, isUpi: true),*/
            Space(55),
          ],
        ),
      ),
    );
  }
}
