import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:resto_app/common/exceptions.dart';
import 'package:resto_app/common/failure.dart';
import 'package:resto_app/data/source/remote/restaurant_remote_data_source.dart';
import 'package:resto_app/domain/entity/restaurant.dart';
import 'package:resto_app/domain/repositories/restaurant_repository.dart';

class RestaurantRepositoryImpl extends RestaurantRepository {

  final RestaurantRemoteDataSource remoteDataSource;

  RestaurantRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Restaurant>>> all() async {
    try {
      var result = await remoteDataSource.all();
      return Right(result.map((e) => e.toEntity()).toList());
    }
    on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
    on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, Restaurant>> detail(String id) async {
    try {
      var result = await remoteDataSource.detail(id);
      return Right(result.toEntity());
    }
    on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
    on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Restaurant>>> search(String key) async{
    try {
      var result = await remoteDataSource.search(key);
      if (result.isEmpty) {
        return Left(DataFailure('Data restaurant tidak ditemukan'));
      }
      else {
        return Right(result.map((e) => e.toEntity()).toList());
      }
    }
    on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
    on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}