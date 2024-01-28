import 'package:dartz/dartz.dart';
import 'package:resto_app/common/failure.dart';
import 'package:resto_app/domain/entity/restaurant.dart';
import 'package:resto_app/domain/repositories/restaurant_repository.dart';

class GetDetailRestaurant {
  final RestaurantRepository repository;

  GetDetailRestaurant({required this.repository});

  Future<Either<Failure, Restaurant>> execute(String id) =>
      repository.detail(id);
}