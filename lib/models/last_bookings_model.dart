/*
import 'package:home_hub/utils/images.dart';

// import 'active_bookings_model.dart';

List<LastBookingsModel> lastBooking = getLastBooking();

class LastBookingsModel {
  int id;
  String serviceName;
  String name;
  String date;
  String time;
  String status;
  int price;

  //Todo add Image
  LastBookingsModel(this.id, this.serviceName, this.name, this.date, this.time, this.status, this.price);
}

List<LastBookingsModel> getLastBooking() {
  List<LastBookingsModel> list = List.empty(growable: true);
  list.add(
    LastBookingsModel(0, "Car Washing", "Jaylon Cleaning Services", "Jan 4,2022", "4am", "Completed", 2599),
  );
  list.add(
    LastBookingsModel(1, "Vehicle Towing", "Sj Cleaning Services", "Dec 4,2022", "6am", "Cancelled", 3000),
  );
  list.add(
    LastBookingsModel(2, "Fuel Delivery", "John Cleaning Services", "Feb 17,2022", "6am", "Completed", 2499),
  );
  return list;
}

void againBooking(int id) {
  int newId = activeBooking.last.id++;
  activeBooking.add(
    ActiveBookingsModel(
      newId,
      lastBooking[id].serviceName,
      home,
      lastBooking[id].name,
      lastBooking[id].date,
      lastBooking[id].time,
      "In Process",
      lastBooking[id].price,
    ),
  );
}*/

class LastBookingModel {
  String bookingId;
  String providerId;
  String categoryName;
  String providerPrice;
  String providerName;
  String providerImage;
  String bookingStatus;
  String userId;
  String userName;
  String bookingDate;
  String bookingTime;

  LastBookingModel({
    required this.bookingId,
    required this.providerId,
    required this.categoryName,
    required this.providerPrice,
    required this.providerName,
    required this.providerImage,
    required this.bookingStatus,
    required this.userId,
    required this.userName,
    required this.bookingDate,
    required this.bookingTime,
  });

  factory LastBookingModel.fromJson(json) => LastBookingModel(
    bookingId: json["bookingId"],
    providerId: json["providerId"],
    categoryName: json["categoryName"],
    providerPrice: json["providerPrice"],
    providerName: json["providerName"],
    providerImage: json["providerImage"],
    bookingStatus: json["bookingStatus"],
    userId: json["userId"],
    userName: json["userName"],
    bookingDate: json["bookingDate"],
    bookingTime: json["bookingTime"],
  );
}