import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:home_hub/const/firebase_const.dart';
import 'package:home_hub/screens/last_booking_screen.dart';
import 'package:home_hub/services/notification_services.dart';
import 'package:home_hub/utils/colors.dart';
import 'package:http/http.dart' as http;

import '../custom_widget/space.dart';
import '../main.dart';
// import '../models/active_bookings_model.dart';

class CancelBookingScreen extends StatefulWidget {
  String categoryName;
  String providerImage;
  String providerName;
  String bookingDate;
  String bookingTime;
  String providerPrice;
  String bookingId;
  String providerToken;
  String userToken;
  String providerId;

  CancelBookingScreen(
      {Key? key,
      required this.categoryName,
      required this.providerImage,
      required this.providerName,
      required this.bookingDate,
      required this.bookingTime,
      required this.bookingId,
      required this.providerToken,
      required this.userToken,
      required this.providerId,
      required this.providerPrice,})
      : super(key: key);

  @override
  State<CancelBookingScreen> createState() => _CancelBookingScreenState();
}

class _CancelBookingScreenState extends State<CancelBookingScreen> {
  NotificationServices notificationServices = NotificationServices();
  // String? refundMethod;
  String? reasonForCancel;
  int itemCount = 1;

  @override
  void initState() {
    super.initState();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.forgroundMessage();
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Please select valid details'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // for cancelling the booking
  void moveDataToLastBooking(String documentId) async {
    try {
      final DocumentSnapshot snapshot =
      await firestore.collection(activeBookingCollection).doc(documentId).get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;

        // Update the 'bookingStatus' field to 'Cancelled'
        data['bookingStatus'] = 'Cancelled';

        // Move the document to the 'lastBooking' collection
        final CollectionReference lastBookingCollections =
        firestore.collection(lastBookingCollection);
        await lastBookingCollections.doc(documentId).set(data);

        // Delete the document from the 'activeBooking' collection
        await firestore.collection(activeBookingCollection).doc(documentId).delete();
      }
    } catch (error) {
      print('Error moving data to last booking: $error');
    }
  }

  // for showing alert box for cancellation
  void showCancelConfirmationDialog(String documentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Cancel Booking'),
        content: const Text('Are you sure you want to cancel this booking?'),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop();
              moveDataToLastBooking(documentId);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title: Text(
          "Cancel Booking",
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
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, 45),
                shape: StadiumBorder(),
              ),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Cancel Service")),
              onPressed: () {
                /*if (refundMethod == null) {
                  _showAlertDialog();
                } else */
                if (reasonForCancel == null) {
                  _showAlertDialog();
                } else {
                  // cancelBooking(widget.activeId);
                  showCancelConfirmationDialog(widget.bookingId);
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LastBookingScreen()),
                  );*/

                  // testing code for the notifications
                  notificationServices
                      .getDeviceTokenFromFirestore(widget.providerId)
                      .then((value) async {
                    var data = {
                      'to': value.toString(),
                      'priority': 'high',
                      'notification': {
                        'title': 'Cancel Booking',
                        'body':
                        'Client has changed their mind and no longer need service.',
                        "sound":
                        "jetsons_doorbell.mp3"
                      },
                      'android': {
                        'notification': {
                          'notification_count': 23,
                        },
                      },
                      'data' : {
                        'type' : 'msj' ,
                        'id' : '123456'
                      }
                    };
                    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
                        body: jsonEncode(data),
                        headers: {
                          'Content-Type': 'application/json; charset=UTF-8',
                          'Authorization' : 'key=AAAA-cJPiX4:APA91bHNB-AV_UHvuiraRHkDfxMNPVcO9khkuOFUTFOqQ75cjY2MS7-z3EOxuh52Z3-4sH9Y4FY5kufrFEieV-4OIRgsW6DSO-FHwu89ZPfBPDzZA9T8dQIL_0i4MLkUUT3DilIFCpb8'
                        }
                    ).then((value){
                      if (kDebugMode) {
                        print(value.body.toString());
                      }
                    }).onError((error, stackTrace){
                      if (kDebugMode) {
                        print(error);
                      }
                    });
                  });

                }
              },
            ),
          );
        },
        onClosing: () {},
      ),
      body: SingleChildScrollView(
        //padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(
                    color: appData.isDark ? cardColorDark : cardColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      child: Image.network(
                                          widget.providerImage,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Space(16),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.categoryName,
                                        // activeBooking[widget.activeId].serviceName,
                                        maxLines: 1,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 16),
                                      ),
                                      Space(4),
                                      Text(
                                        widget.providerName,
                                        // activeBooking[widget.activeId].name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: greyColor, fontSize: 12),
                                      ),
                                      Space(4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.watch_later_outlined,
                                              color: greyColor, size: 14),
                                          Space(2),
                                          Text(
                                            widget.bookingTime,
                                            // activeBooking[widget.activeId].time,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          ),
                                          Space(2),
                                          Text("on",
                                              style: TextStyle(
                                                  color: greyColor,
                                                  fontSize: 8)),
                                          Space(2),
                                          Text(widget.bookingDate,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10)),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Space(42),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              /*IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Text("1590 Sqft",
                                        style: TextStyle(
                                            color: greyColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                    VerticalDivider(
                                        thickness: 2, color: greyColor),
                                    Text("3BHK",
                                        style: TextStyle(
                                            color: greyColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),*/
                              Text(
                                '\$${widget.providerPrice}',
                                // "₹${activeBooking[widget.activeId].price.toString()}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Space(32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Summary",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 18),
                      ),
                    ],
                  ),
                  Space(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: greyColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      Text(
                        '\$${widget.providerPrice}',
                        // "₹${activeBooking[widget.activeId].price.toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  /*Space(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "GST",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: greyColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      Text("₹160",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Space(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Coupon Discount",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: greyColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      Text("- ₹160",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),*/
                  Space(8),
                  Divider(indent: 8, endIndent: 8, color: greyColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20)),
                      Text(
                        '\$${widget.providerPrice}',
                        // "₹${activeBooking[widget.activeId].price.toString()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                    ],
                  ),
                  Space(42),
                ],
              ),
            ),
            /*Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Refund Method",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
              ),
            ),
            Space(16),
            RadioListTile(
              title: Text("Refund to Original Payment Method",
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
              value: "OriginalPayment",
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              activeColor: orangeColor,
              contentPadding: EdgeInsets.symmetric(horizontal: 4),
              groupValue: refundMethod,
              onChanged: (value) {
                refundMethod = value.toString();
                setState(() {});
              },
            ),
            RadioListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text("Add to My Wallet",
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
              contentPadding: EdgeInsets.symmetric(horizontal: 4),
              activeColor: orangeColor,
              value: "MyWallet",
              groupValue: refundMethod,
              onChanged: (value) {
                refundMethod = value.toString();
                setState(() {});
              },
            ),
            Space(32),*/
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Why are you cancelling this service",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
              ),
            ),
            Space(8),
            RadioListTile(
              title: Text("Booked by mistake"),
              value: "mistake",
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              contentPadding: EdgeInsets.symmetric(horizontal: 4),
              activeColor: orangeColor,
              groupValue: reasonForCancel,
              onChanged: (value) {
                reasonForCancel = value.toString();
                setState(() {});
              },
            ),
            RadioListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text("Not available on the date of service"),
              activeColor: orangeColor,
              value: "noAvailable",
              contentPadding: EdgeInsets.symmetric(horizontal: 4),
              groupValue: reasonForCancel,
              onChanged: (value) {
                setState(() {
                  reasonForCancel = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("No longer needed"),
              activeColor: orangeColor,
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              value: "noNeeded",
              contentPadding: EdgeInsets.symmetric(horizontal: 4),
              groupValue: reasonForCancel,
              onChanged: (value) {
                reasonForCancel = value.toString();
                setState(() {});
              },
            ),
            Space(80),
          ],
        ),
      ),
    );
  }
}
