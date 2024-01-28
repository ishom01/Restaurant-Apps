import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_app/common/data_state.dart';
import 'package:resto_app/domain/entity/restaurant.dart';
import 'package:resto_app/domain/usecase/get_search_restaurant.dart';
import 'package:resto_app/presentation/bloc/restaurant_search/restaurant_search_event.dart';

class RestaurantSearchBloc
    extends Bloc<RestaurantSearchEvent, UiState<List<Restaurant>>> {

  final GetSearchRestaurant useCase;

  RestaurantSearchBloc(this.useCase):
        super(const LoadingUiState<List<Restaurant>>()) {

    on<RestaurantSearchEvent>((event, emit) async {
      if (event.key.isEmpty) {
        emit(const ErrorUiState("Masukan nama restaurant untuk mencari"));
      }
      else {
        emit(const LoadingUiState());
        final result = await useCase.execute(event.key);
        result.fold(
          (failed) {
            emit(ErrorUiState(failed.message));
          },
          (success) {
            emit(SuccessUiState(success));
          });
      }
    });
  }
}