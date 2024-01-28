import 'package:equatable/equatable.dart';

class RestaurantDetailEvent extends Equatable {

  final String id;

  const RestaurantDetailEvent(this.id);

  @override
  List<Object?> get props => [
    id
  ];
}