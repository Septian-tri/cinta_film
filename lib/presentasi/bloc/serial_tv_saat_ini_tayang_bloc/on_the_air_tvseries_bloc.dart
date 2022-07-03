import 'package:cinta_film/domain/usecases/tvls/get_now_playing_tvls.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'on_the_air_tvseries_state.dart';
part 'on_the_air_tvseries_event.dart';

class OnTheAirTvseriesBloc
    extends Bloc<OnTheAirTvseriesEvent, OnTheAirTvseriesState> {
  final GetserialTvSaatIniDiPutarls _getOnAirTvseries;

  OnTheAirTvseriesBloc(
    this._getOnAirTvseries,
  ) : super(OnTheAirTvseriesEmpty()) {
    on<OnTheAirTvseriesGetEvent>((event, emit) async {
      emit(OnTheAirTvseriesLoading());

      final result = await _getOnAirTvseries.execute();

      result.fold((failure) => emit(OnTheAirTvseriesError(failure.message)),
          (data) => emit(OnTheAirTvseriesLoaded(data)));
    });
  }
}
