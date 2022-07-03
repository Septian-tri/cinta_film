import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:cinta_film/domain/entities/tvls/tvls_detail.dart';
import 'package:cinta_film/domain/usecases/tvls/get_watchlist_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_watchlist_status_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/remove_watchlist_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/save_watchlist_tvls.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'watchlist_tvseries_state.dart';
part 'watchlist_tvseries_event.dart';

class WatchlistTvseriesBloc
    extends Bloc<WatchlistTvseriesEvent, WatchlistTvseriesState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  final ClassStatusDaftarTontonTvls _getWatchListStatusTvseries;
  final GetwatchlistTvls _getWatchlistTvseries;
  final ClassHapusDaftarTontonTvls _removeWatchlistTvseries;
  final ClassSimpanDaftarTontonTvls _saveWatchlistTvseries;

  WatchlistTvseriesBloc(
    this._getWatchlistTvseries,
    this._getWatchListStatusTvseries,
    this._saveWatchlistTvseries,
    this._removeWatchlistTvseries,
  ) : super(WatchlistTvseriesEmpty()) {
    on<WatchlistTvseriesGetEvent>((event, emit) async {
      emit(WatchlistTvseriesLoading());

      final result = await _getWatchlistTvseries.execute();

      result.fold(
        (failure) {
          emit(WatchlistTvseriesError(failure.message));
        },
        (data) {
          emit(WatchlistTvseriesLoaded(data));
        },
      );
    });

    on<WatchlistTvseriesGetStatusEvent>((event, emit) async {
      final id = event.id;

      final result = await _getWatchListStatusTvseries.execute(id);

      emit(WatchlistTvseriesStatusLoaded(result));
    });

    on<WatchlistTvseriesTambahItemEvent>((event, emit) async {
      final tvSeriesDetail = event.tvSeriesDetail;

      final result = await _saveWatchlistTvseries.execute(tvSeriesDetail);

      result.fold(
        (failure) {
          emit(WatchlistTvseriesError(failure.message));
        },
        (successMessage) {
          emit(WatchlistTvseriesSuccess(successMessage));
        },
      );
    });

    on<WatchlistTvseriesHapusItemEvent>((event, emit) async {
      final tvSeriesDetail = event.tvSeriesDetail;

      final result = await _removeWatchlistTvseries.execute(tvSeriesDetail);

      result.fold(
        (failure) {
          emit(WatchlistTvseriesError(failure.message));
        },
        (successMessage) {
          emit(WatchlistTvseriesSuccess(successMessage));
        },
      );
    });
  }
}
