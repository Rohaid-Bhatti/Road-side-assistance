import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:home_hub/const/firebase_const.dart';
import 'package:home_hub/custom_widget/space.dart';
import 'package:home_hub/main.dart';
import 'package:home_hub/screens/payment_screen.dart';
import 'package:home_hub/services/notification_services.dart';
import 'package:home_hub/utils/colors.dart';
import 'package:http/http.dart' as http;

class LocationScreen extends StatefulWidget {
  String categoryName;
  String providerId;
  String providerImage;
  String providerName;
  String providerPrice;
  String userId;
  String userName;
  String providerDes;
  String providerToken;
  String userToken;

  LocationScreen({
    Key? key,
    required this.categoryName,
    required this.providerId,
    required this.providerImage,
    required this.providerName,
    required this.providerPrice,
    required this.userId,
    required this.userName,
    required this.providerDes,
    required this.providerToken,
    required this.userToken,
  }) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  NotificationServices notificationServices = NotificationServices();
  GoogleMapController? _mapController;
  Position? _currentPosition;

  LatLng? currentLocation; // Variable to store the current location

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.forgroundMessage();
  }

  // for storing booking data into the firestore
  void sendDataToFirestore() {
    // Get the current date and time
    DateTime currentDateTime = DateTime.now();

    // Extract individual date and time components
    int year = currentDateTime.year;
    int month = currentDateTime.month;
    int day = currentDateTime.day;
    int hour = currentDateTime.hour;
    int minute = currentDateTime.minute;

    // Define the data to be sent
    Map<String, dynamic> data = {
      'bookingStatus': 'Pending',
      'categoryName': widget.categoryName,
      'providerId': widget.providerId,
      'providerImage': widget.providerImage,
      'providerName': widget.providerName,
      'providerPrice': widget.providerPrice,
      'latitude': currentLocation?.latitude.toString(),
      'longitude': currentLocation?.longitude.toString(),
      'userId': widget.userId,
      'userName': widget.userName,
      'providerDes': widget.providerDes,
      'providerToken': widget.providerToken,
      'userToken': widget.userToken,
      'bookingDate': '$day-$month-$year', // Save date as a string in 'DD-MM-YYYY' format
      'bookingTime': '$hour:$minute', // Save time as a string in 'HH:mm:ss' format
    };

    // Add the document to Firestore
    CollectionReference activeBookingRef =
    firestore.collection(activeBookingCollection);
    DocumentReference docRef = activeBookingRef.doc();
    data['bookingId'] =
        docRef.id; // Assign the document ID as 'bookingId' field
    docRef
        .set(data)
        .then((value) => print('Data sent to Firestore successfully.'))
        .catchError((error) => print('Failed to send data: $error'));
    Fluttertoast.showToast(msg: 'Request Sent');
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, show an error dialog or ask the user to enable it.
      return;
    }

    // Request location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return;
    }

    if (permission == LocationPermission.denied) {
      // Permissions are denied, ask for permission.
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        // Permissions are denied, handle appropriately.
        return;
      }
    }

    // Get the current position
    Position currentPosition = await Geolocator.getCurrentPosition();
    if (!mounted) return;

    setState(() {
      _currentPosition = currentPosition;
      //again for the location saving
      currentLocation = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title: Text(
          "Location",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
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
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
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
                      sendDataToFirestore();

                      // testing code for the notifications
                      notificationServices
                          .getDeviceTokenFromFirestore(widget.providerId)
                          .then((value) async {
                        var data = {
                          'to': value.toString(),
                          'priority': 'high',
                          'notification': {
                            'title': 'New Booking',
                            'body':
                            'Someone booked your service.',
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

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentScreen()));
                    },
                  ),
                ),
              ],
            ),
          );
        },
        onClosing: () {},
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            _mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0), // Center the map at (0, 0) initially
          zoom: 16.0,
        ),
        myLocationEnabled: true,
        compassEnabled: true,
        markers: (_currentPosition != null)
            ? {
          Marker(
            markerId: MarkerId("currentLocation"),
            position: LatLng(
              _currentPosition!.latitude,
              _currentPosition!.longitude,
            ),
            infoWindow: InfoWindow(
              title: "Current Location",
            ),
          ),
        }
            : {},
      ),
    );
  }
}
