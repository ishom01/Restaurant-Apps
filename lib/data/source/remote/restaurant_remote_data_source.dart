import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:resto_app/common/constant.dart';
import 'package:resto_app/common/response.dart';
import 'package:resto_app/data/model/restaurant.dart';

import '../../../common/exceptions.dart';

abstract class RestaurantRemoteDataSource {
  Future<List<RestaurantResponse>> all();
  Future<RestaurantResponse> detail(String id);
  Future<List<RestaurantResponse>> search(String key);
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  
  final http.Client client;

  RestaurantRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RestaurantResponse>> all() async {
    final result = await client.get(Uri.parse("$BASE_URL/list"));
    if (result.statusCode == 200) {
      GeneralResponse response = GeneralResponse.fromJson(
          jsonDecode(result.body));
      if (!response.isError) {
        List restaurants = jsonDecode(result.body)["restaurants"];
        return restaurants.map((e) => RestaurantResponse.fromJson(e)).toList();
      } else {
        throw ServerException(response.message);
      }
    } else {
      throw ServerException('');
    }
  }

  @override
  Future<RestaurantResponse> detail(String id) async {
    final result = await client.get(Uri.parse("$BASE_URL/detail/$id"));
    if (result.statusCode == 200) {
      GeneralResponse response = GeneralResponse.fromJson(
          jsonDecode(result.body));
      if (!response.isError) {
        return RestaurantResponse.fromJson(jsonDecode(result.body)["restaurant"]);
      } else {
        throw ServerException(response.message);
      }
    } else {
      throw ServerException('');
    }
  }

  @override
  Future<List<RestaurantResponse>> search(String key) async {
    log("Debug search $key");
    final result = await client.get(Uri.parse("$BASE_URL/search?q=$key"));
    if (result.statusCode == 200) {
      GeneralResponse response = GeneralResponse.fromJson(
          jsonDecode(result.body));
      log("Debug search ${jsonDecode(result.body)}");
      if (!response.isError) {
        List restaurants = jsonDecode(result.body)["restaurants"];
        return restaurants.map((e) => RestaurantResponse.fromJson(e)).toList();
      } else {
        throw ServerException(response.message);
      }
    } else {
      throw ServerException('');
    }
  }
}