class CategoryModel {
  String categoryId;
  String categoryName;
  String categoryImage;
  String categoryIcon;
  String categoryDes;

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
    required this.categoryIcon,
    required this.categoryDes,
  });

  factory CategoryModel.fromJson(json) => CategoryModel(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        categoryImage: json["categoryImage"],
        categoryIcon: json["categoryIcon"],
        categoryDes: json["categoryDes"],
      );
}
