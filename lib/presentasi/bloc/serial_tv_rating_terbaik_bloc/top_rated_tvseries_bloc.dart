import 'package:cinta_film/domain/usecases/tvls/get_top_rated_tvls.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'top_rated_tvseries_state.dart';
part 'top_rated_tvseries_event.dart';

class TopRatedTvseriesBloc
    extends Bloc<TopRatedTvseriesEvent, TopRatedTvseriesState> {
  final GetTopRatedTvls _getTopRatedTvseries;

  TopRatedTvseriesBloc(
    this._getTopRatedTvseries,
  ) : super(TopRatedTvseriesEmpty()) {
    on<TopRatedTvseriesGetEvent>((event, emit) async {
      emit(TopRatedTvseriesLoading());

      final result = await _getTopRatedTvseries.execute();

      result.fold(
        (failure) {
          emit(TopRatedTvseriesError(failure.message));
        },
        (data) {
          emit(TopRatedTvseriesLoaded(data));
        },
      );
    });
  }
}
