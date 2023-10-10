class UserModel {
  String uid;
  String email;
  String name;
  String phoneNumber;
  String password;
  String image;
  String deviceToken;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.password,
    required this.image,
    required this.deviceToken,
  });
}