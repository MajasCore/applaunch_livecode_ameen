import 'dart:convert';

import 'package:livecode/model/category_dishes_model.dart';
import 'package:livecode/model/menu_category_model.dart';

List<Model> modelFromJson(String str) =>
    List<Model>.from(json.decode(str).map((x) => Model.fromJson(x)));

class Model {
  String restaurantName;
  List<TableMenu>? menuCategory;

  Model({required this.restaurantName, this.menuCategory});

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        restaurantName: json["restaurant_name"],
        menuCategory: List<TableMenu>.from(
            json["table_menu_list"].map((x) => TableMenu.fromJson(x))),
      );
}
