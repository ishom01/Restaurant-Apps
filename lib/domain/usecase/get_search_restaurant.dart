import 'package:dartz/dartz.dart';
import 'package:resto_app/common/failure.dart';
import 'package:resto_app/domain/entity/restaurant.dart';
import 'package:resto_app/domain/repositories/restaurant_repository.dart';

class GetSearchRestaurant {
  final RestaurantRepository repository;

  GetSearchRestaurant({required this.repository});

  Future<Either<Failure, List<Restaurant>>> execute(String key) =>
      repository.search(key);
}