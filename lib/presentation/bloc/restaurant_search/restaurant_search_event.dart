import 'package:equatable/equatable.dart';

class RestaurantSearchEvent extends Equatable {

  String key = "";

  RestaurantSearchEvent(this.key);

  @override
  List<Object?> get props => [
    key
  ];
}