import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:resto_app/data/repositories/restaurant_repository_impl.dart';
import 'package:resto_app/data/source/remote/restaurant_remote_data_source.dart';
import 'package:resto_app/domain/repositories/restaurant_repository.dart';
import 'package:resto_app/domain/usecase/get_detail_restaurant.dart';
import 'package:resto_app/domain/usecase/get_list_restaurant.dart';
import 'package:resto_app/domain/usecase/get_search_restaurant.dart';
import 'package:resto_app/presentation/bloc/restaurant_detail/restaurant_detail_bloc.dart';
import 'package:resto_app/presentation/bloc/restaurant_list/restaurant_list_bloc.dart';
import 'package:resto_app/presentation/bloc/restaurant_search/restaurant_search_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory<RestaurantListBloc>(() =>
      RestaurantListBloc(locator())
  );
  locator.registerFactory<RestaurantDetailBloc>(() =>
      RestaurantDetailBloc(locator())
  );
  locator.registerFactory<RestaurantSearchBloc>(() =>
      RestaurantSearchBloc(locator())
  );

  // useCase
  locator.registerLazySingleton<GetListRestaurant>(() =>
      GetListRestaurant(repository: locator())
  );
  locator.registerLazySingleton<GetDetailRestaurant>(() =>
      GetDetailRestaurant(repository: locator())
  );
  locator.registerLazySingleton<GetSearchRestaurant>(() =>
      GetSearchRestaurant(repository: locator())
  );

  locator.registerLazySingleton<RestaurantRepository>(() =>
      RestaurantRepositoryImpl(remoteDataSource: locator())
  );
  locator.registerLazySingleton<RestaurantRemoteDataSource>(() =>
      RestaurantRemoteDataSourceImpl(client: locator())
  );
  locator.registerLazySingleton(() => http.Client());
}