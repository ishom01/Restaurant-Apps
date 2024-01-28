import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_app/common/data_state.dart';
import 'package:resto_app/domain/entity/restaurant.dart';
import 'package:resto_app/domain/usecase/get_list_restaurant.dart';
import 'package:resto_app/presentation/bloc/restaurant_list/restaurant_list_event.dart';

class RestaurantListBloc
    extends Bloc<RestaurantListEvent, UiState<List<Restaurant>>> {

  final GetListRestaurant useCase;

  RestaurantListBloc(this.useCase):
        super(const LoadingUiState<List<Restaurant>>()) {

    on<RestaurantListEvent>((event, emit) async {
      emit(const LoadingUiState());
      final result = await useCase.execute();
      result.fold(
        (failed) {
          emit(ErrorUiState(failed.message));
        },
        (success) {
          emit(SuccessUiState(success));
        });
    });
  }
}