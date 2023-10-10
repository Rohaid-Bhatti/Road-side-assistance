import 'package:flutter/material.dart';
import 'package:home_hub/custom_widget/space.dart';
import 'package:home_hub/main.dart';
import 'package:home_hub/providers/booking_provider.dart';
import 'package:home_hub/utils/colors.dart';
import 'package:provider/provider.dart';

class BookingHistoryScreen extends StatefulWidget {
  final String userId;

  const BookingHistoryScreen({Key? key, required this.userId})
      : super(key: key);

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  BookingProvider? bookingProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BookingProvider provider = Provider.of(context, listen: false);
    provider.getLastBookingData(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    bookingProvider = Provider.of(context);

    return Scaffold(
      body: bookingProvider!.lastList.isEmpty
          ? Center(child: Text("No Bookings History"))
          : ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: /*lastBooking.length*/ bookingProvider!
                  .lastList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // showAlertDialog(context, index: index);
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
                                  bookingProvider!.lastList[index].categoryName,
                                  // lastBooking[index].serviceName,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18),
                                ),
                                Text(
                                  bookingProvider!
                                      .lastList[index].bookingStatus,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: /*lastBooking[index].status*/ bookingProvider!
                                                .lastList[index]
                                                .bookingStatus ==
                                            "Completed"
                                        ? greenColor
                                        : redColor,
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
                                        0.07,
                                    width: MediaQuery.of(context).size.height *
                                        0.07,
                                    child: Image.network(bookingProvider!.lastList[index].providerImage /*home*/,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Space(8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(bookingProvider!.lastList[index].providerName/*lastBooking[index].name*/,
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
                                        Text(/*lastBooking[index].date*/bookingProvider!.lastList[index].bookingDate,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14)),
                                        Space(2),
                                        Text("at",
                                            style: TextStyle(
                                                color: orangeColor,
                                                fontSize: 12)),
                                        Space(2),
                                        Text(/*lastBooking[index].time*/ bookingProvider!.lastList[index].bookingTime,
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
                                /*"₹${lastBooking[index].price}"*/
                                "\$${bookingProvider!.lastList[index].providerPrice}",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 20),
                              ),
                            ),
                            Space(4),
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
