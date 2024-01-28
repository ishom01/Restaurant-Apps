import 'package:resto_app/domain/entity/food.dart';

import '../../domain/entity/menu.dart';
import 'food.dart';

class MenuResponse {
  List<FoodResponse>? foods;
  List<FoodResponse>? drinks;

  MenuResponse({this.foods, this.drinks});

  MenuResponse.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = <FoodResponse>[];
      json['foods'].forEach((v) {
        foods!.add(FoodResponse.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      drinks = <FoodResponse>[];
      json['drinks'].forEach((v) {
        drinks!.add(FoodResponse.fromJson(v));
      });
    }
  }

  Menu toEntity() {
    return Menu(
      foods: foods?.map((e) => e.toEntity()).toList(),
      drinks: drinks?.map((e) => e.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (foods != null) {
      data['foods'] = foods?.map((v) => v.toJson()).toList();
    }
    if (drinks != null) {
      data['drinks'] = drinks?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
