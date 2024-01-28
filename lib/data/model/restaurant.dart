import 'dart:convert';

import 'package:resto_app/domain/entity/restaurant.dart';

import 'menu.dart';

class RestaurantResponse {
  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  num? rating;
  MenuResponse? menus;

  RestaurantResponse(
      {this.id,
        this.name,
        this.description,
        this.pictureId,
        this.city,
        this.rating,
        this.menus});

  RestaurantResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    pictureId = json['pictureId'];
    city = json['city'];
    rating = json['rating'];
    menus = json['menus'] != null ? MenuResponse.fromJson(json['menus']) : null;
  }

  Restaurant toEntity() {
    return Restaurant(
      id: id,
      name: name,
      description: description,
      pictureId: pictureId,
      city: city,
      rating: rating,
      menus: menus?.toEntity()
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['pictureId'] = pictureId;
    data['city'] = city;
    data['rating'] = rating;
    if (menus != null) {
      data['menus'] = menus?.toJson();
    }
    return data;
  }
}

