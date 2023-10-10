/*
import 'package:home_hub/utils/images.dart';

List<ActiveBookingsModel> activeBooking = getActiveBooking();

class ActiveBookingsModel {
  int id;
  String serviceName;
  String serviceImage;
  String name;
  String date;
  String time;
  String status;
  int price;

  ActiveBookingsModel(this.id, this.serviceName, this.serviceImage, this.name, this.date, this.time, this.status, this.price);
}

List<ActiveBookingsModel> getActiveBooking() {
  List<ActiveBookingsModel> list = List.empty(growable: true);
  list.add(
    ActiveBookingsModel(0, "Battery Jump Up", home, "Jaylon Cleaning Services", "Jan 4,2022", "4am", "In Process", 2599),
  );
  list.add(
    ActiveBookingsModel(1, "Removal of Junk Vehicle", home, "Sj Cleaning Services", "Dec 4,2022", "6am", "Assigned", 3000),
  );
  list.add(
    ActiveBookingsModel(2, "Car Wash", home, "John Cleaning Services", "Feb 17,2022", "6am", "Assigned", 2499),
  );
  return list;
}

void cancelBooking(int id) {
  activeBooking.removeAt(id);
}
*/

class ActiveBookingModel {
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
  String providerToken;
  String userToken;

  ActiveBookingModel({
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
    required this.providerToken,
    required this.userToken,
  });

  factory ActiveBookingModel.fromJson(json) => ActiveBookingModel(
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
        providerToken: json["providerToken"],
        userToken: json["userToken"],
      );
}
