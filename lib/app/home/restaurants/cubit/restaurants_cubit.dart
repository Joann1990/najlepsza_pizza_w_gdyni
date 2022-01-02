import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'restaurants_state.dart';

class RestaurantsCubit extends Cubit<RestaurantsState> {
  RestaurantsCubit()
      : super(
          const RestaurantsState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  Future<void> start() async {
    emit(
      const RestaurantsState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    await Future.delayed(const Duration(seconds: 5));

    emit(
      const RestaurantsState(
        documents: [],
        errorMessage: 'Błąd połączenia',
        isLoading: false,
      ),
    );
  }
}
