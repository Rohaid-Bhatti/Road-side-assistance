import 'package:flutter/material.dart';
import 'package:home_hub/custom_widget/space.dart';
import 'package:home_hub/main.dart';
import 'package:home_hub/providers/booking_provider.dart';
import 'package:home_hub/screens/cancel_booking_screen.dart';
import 'package:home_hub/utils/colors.dart';
import 'package:provider/provider.dart';

class ActiveBookingsScreen extends StatefulWidget {
  final String userId;

  const ActiveBookingsScreen({Key? key, required this.userId})
      : super(key: key);

  @override
  State<ActiveBookingsScreen> createState() => _ActiveBookingsScreenState();
}

class _ActiveBookingsScreenState extends State<ActiveBookingsScreen> {
  BookingProvider? bookingProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BookingProvider provider = Provider.of(context, listen: false);
    provider.getActiveBookingData(widget.userId);
  }

  /*@override
  void initState() {
    BookingProvider provider = Provider.of(context, listen: false);
    provider.getActiveBookingData();
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    bookingProvider = Provider.of(context);

    return Scaffold(
      body: bookingProvider!.activeList.isEmpty
          ? Center(child: Text("No Active Bookings"))
          : ListView.builder(
              padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 16),
              itemCount: bookingProvider!.activeList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CancelBookingScreen(
                                categoryName: bookingProvider!
                                    .activeList[index].categoryName,
                                providerImage: bookingProvider!
                                    .activeList[index].providerImage,
                                providerName: bookingProvider!
                                    .activeList[index].providerName,
                                bookingDate: bookingProvider!
                                    .activeList[index].bookingDate,
                                bookingTime: bookingProvider!
                                    .activeList[index].bookingTime,
                                providerPrice: bookingProvider!
                                    .activeList[index].providerPrice,
                                bookingId: bookingProvider!
                                    .activeList[index].bookingId,
                                providerToken: bookingProvider!
                                    .activeList[index].providerToken,
                                userToken: bookingProvider!
                                    .activeList[index].userToken,
                                providerId: bookingProvider!
                                    .activeList[index].providerId,
                              )),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Card(
                      color: appData.isDark ? cardColorDark : cardColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  bookingProvider!
                                      .activeList[index].categoryName,
                                  // activeBookingsModel!.serviceName,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18),
                                ),
                                Text(
                                  bookingProvider!
                                      .activeList[index].bookingStatus,
                                  // activeBookingsModel!.status,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: bookingProvider!.activeList[index]
                                                .bookingStatus ==
                                            "Pending"
                                        ? orangeColor
                                        : blueColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Space(4),
                            Divider(color: dividerColor, thickness: 1),
                            Space(2),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width: MediaQuery.of(context).size.height *
                                        0.06,
                                    child: Image.network(
                                        bookingProvider!
                                            .activeList[index].providerImage,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Space(8),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        /*activeBookingsModel!.name*/
                                        bookingProvider!
                                            .activeList[index].providerName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18)),
                                    Space(4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.watch_later_outlined,
                                            color: orangeColor, size: 16),
                                        Space(2),
                                        Text(
                                            /*activeBookingsModel!.date*/
                                            bookingProvider!
                                                .activeList[index].bookingDate,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14)),
                                        Space(2),
                                        Text("at",
                                            style: TextStyle(
                                                color: orangeColor,
                                                fontSize: 12)),
                                        Space(2),
                                        Text(
                                            /*activeBookingsModel!.time*/
                                            bookingProvider!
                                                .activeList[index].bookingTime,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14)),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            Space(4),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                /*"₹${activeBookingsModel!.price}"*/
                                "\$${bookingProvider!.activeList[index].providerPrice}",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 20),
                              ),
                            ),
                            Space(4),
                            Divider(color: dividerColor, thickness: 1),
                            Space(4),
                            Text(
                              "Cancel",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: blueColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
