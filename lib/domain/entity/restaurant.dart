import 'package:equatable/equatable.dart';
import 'package:resto_app/domain/entity/menu.dart';

class Restaurant extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? pictureId;
  final String? city;
  final num? rating;
  final Menu? menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  String get smallImageUrl =>
      "https://restaurant-api.dicoding.dev/images/small/$pictureId";

  String get largeImageUrl =>
      "https://restaurant-api.dicoding.dev/images/large/$pictureId";

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    pictureId,
    city,
    rating,
    menus,
  ];
}