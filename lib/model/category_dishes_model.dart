class CategoryDish {
  String dishName;
  double dishPrice;

  CategoryDish({required this.dishName, required this.dishPrice});

  factory CategoryDish.fromJson(Map<String, dynamic> json) => CategoryDish(
        dishName: json['dish_name'],
        dishPrice: json["dish_price"],
      );
}
