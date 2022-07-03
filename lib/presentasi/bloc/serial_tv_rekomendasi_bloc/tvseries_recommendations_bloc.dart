import 'package:cinta_film/domain/usecases/tvls/get_tvls_recomendations.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'tvseries_recommendations_state.dart';
part 'tvseries_recommendations_event.dart';

class TvseriesRecommendationsBloc
    extends Bloc<TvseriesRecommendationsEvent, TvseriesRecommendationsState> {
  final GetTvlsRecommendations _getTvseriesRecommendations;

  TvseriesRecommendationsBloc(
    this._getTvseriesRecommendations,
  ) : super(TvseriesRecommendationsEmpty()) {
    on<TvseriesRecommendationsGetEvent>((event, emit) async {
      emit(TvseriesRecommendationsLoading());

      final result = await _getTvseriesRecommendations.execute(event.id);

      result.fold(
        (failure) {
          emit(TvseriesRecommendationsError(failure.message));
        },
        (data) {
          emit(TvseriesRecommendationsLoaded(data));
        },
      );
    });
  }
}
