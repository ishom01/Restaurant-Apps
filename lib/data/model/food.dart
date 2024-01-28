import '../../domain/entity/food.dart';

class FoodResponse {
  String? name;

  FoodResponse({this.name});

  FoodResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Food toEntity() {
    return Food(
      name: name
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}