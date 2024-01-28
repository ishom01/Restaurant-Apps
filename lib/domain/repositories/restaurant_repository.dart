import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entity/restaurant.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, List<Restaurant>>> all();
  Future<Either<Failure, Restaurant>> detail(String id);
  Future<Either<Failure, List<Restaurant>>> search(String key);
}