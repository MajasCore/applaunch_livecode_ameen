import 'category_dishes_model.dart';

class TableMenu {
  String menuCategoryName;
  List<CategoryDish> categoryDishes;

  TableMenu({
    required this.menuCategoryName,
    required this.categoryDishes,
  });

  factory TableMenu.fromJson(Map<String, dynamic> json) => TableMenu(
        menuCategoryName: json['menu_category'],
        categoryDishes: List<CategoryDish>.from(
            json["category_dishes"].map((x) => CategoryDish.fromJson(x))),
      );
}
