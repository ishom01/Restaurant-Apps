import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_app/common/data_state.dart';
import 'package:resto_app/domain/entity/restaurant.dart';
import 'package:resto_app/domain/usecase/get_detail_restaurant.dart';
import 'package:resto_app/presentation/bloc/restaurant_detail/restaurant_detail_event.dart';

class RestaurantDetailBloc
    extends Bloc<RestaurantDetailEvent, UiState<Restaurant>> {

  final GetDetailRestaurant useCase;

  RestaurantDetailBloc(this.useCase):
        super(const LoadingUiState<Restaurant>()) {

    on<RestaurantDetailEvent>((event, emit) async {
      emit(const LoadingUiState());
      final result = await useCase.execute(event.id);
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