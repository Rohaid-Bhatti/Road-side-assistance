class ProviderModel {
  String uid;
  String providerName;
  String providerImage;
  String providerPrice;
  String providerNumber;
  String providerDes;
  String categoryName;
  String providerEmail;
  String providerPassword;
  String providerExperience;
  String deviceToken;

  ProviderModel({
    required this.uid,
    required this.providerName,
    required this.providerImage,
    required this.providerPrice,
    required this.providerNumber,
    required this.providerDes,
    required this.categoryName,
    required this.providerEmail,
    required this.providerPassword,
    required this.providerExperience,
    required this.deviceToken,
  });

  factory ProviderModel.fromJson(json) => ProviderModel(
    uid: json["uid"],
    providerName: json["providerName"],
    providerImage: json["providerImage"],
    providerPrice: json["providerPrice"],
    providerDes: json["providerDes"],
    categoryName: json["categoryName"],
    providerNumber: json["providerNumber"],
    providerEmail: json["providerEmail"],
    providerPassword: json["providerPassword"],
    providerExperience: json["providerExperience"],
    deviceToken: json["deviceToken"],
  );
}
