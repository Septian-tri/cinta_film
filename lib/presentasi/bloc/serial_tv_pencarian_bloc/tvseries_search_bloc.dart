import 'package:cinta_film/domain/usecases/tvls/search_tvls.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'tvseries_search_state.dart';
part 'tvseries_search_event.dart';

class TvseriesSearchBloc
    extends Bloc<TvseriesSearchEvent, TvseriesSearchState> {
  final SearchTvls _searchTvSeries;

  TvseriesSearchBloc(
    this._searchTvSeries,
  ) : super(TvseriesSearchEmpty()) {
    on<TvseriesSearchSetEmpty>((event, emit) => emit(TvseriesSearchEmpty()));

    on<TvseriesSearchQueryEvent>((event, emit) async {
      emit(TvseriesSearchLoading());

      final result = await _searchTvSeries.execute(event.query);

      result.fold(
        (failure) {
          emit(TvseriesSearchError(failure.message));
        },
        (data) {
          emit(TvseriesSearchLoaded(data));
        },
      );
    });
  }
}
