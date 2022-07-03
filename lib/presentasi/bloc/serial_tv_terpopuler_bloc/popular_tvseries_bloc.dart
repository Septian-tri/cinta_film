import 'package:cinta_film/domain/usecases/tvls/get_popular_tvls.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'popular_tvseries_state.dart';
part 'popular_tvseries_event.dart';

class PopularTvseriesBloc
    extends Bloc<PopularTvseriesEvent, PopularTvseriesState> {
  final GetPopularTvls _getPopularTvseries;

  PopularTvseriesBloc(
    this._getPopularTvseries,
  ) : super(PopularTvseriesEmpty()) {
    on<PopularTvseriesGetEvent>((event, emit) async {
      emit(PopularTvseriesLoading());

      final result = await _getPopularTvseries.execute();

      result.fold(
        (failure) {
          emit(PopularTvseriesError(failure.message));
        },
        (data) {
          emit(PopularTvseriesLoaded(data));
        },
      );
    });
  }
}
