import 'package:equatable/equatable.dart';
import 'package:resto_app/domain/entity/food.dart';

class Menu extends Equatable {

  final List<Food>? foods;
  final List<Food>? drinks;

  Menu({
    this.foods,
    this.drinks
  });

  @override
  List<Object?> get props => [
    foods,
    drinks
  ];
}