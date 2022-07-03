import 'package:cinta_film/domain/usecases/tvls/get_tvls_detail.dart';
import 'package:cinta_film/domain/entities/tvls/tvls_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'tvseries_detail_state.dart';
part 'tvseries_detail_event.dart';

class TvseriesDetailBloc
    extends Bloc<TvseriesDetailEvent, TvseriesDetailState> {
  final GetTvlsDetail _getTvseriesDetail;

  TvseriesDetailBloc(
    this._getTvseriesDetail,
  ) : super(TvseriesDetailEmpty()) {
    on<TvseriesDetailGetEvent>((event, emit) async {
      emit(TvseriesDetailLoading());

      final result = await _getTvseriesDetail.execute(event.id);

      result.fold((failure) => emit(TvseriesDetailError(failure.message)),
          (data) => emit(TvseriesDetailLoaded(data)));
    });
  }
}
