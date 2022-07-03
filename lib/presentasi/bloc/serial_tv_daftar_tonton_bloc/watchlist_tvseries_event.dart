part of 'watchlist_tvseries_bloc.dart';

abstract class WatchlistTvseriesEvent extends Equatable {
  const WatchlistTvseriesEvent();

  @override
  List<Object> get props => [];
}

class WatchlistTvseriesGetStatusEvent extends WatchlistTvseriesEvent {
  final int id;

  const WatchlistTvseriesGetStatusEvent(this.id);

  @override
  List<Object> get props => [id];
}

class WatchlistTvseriesGetEvent extends WatchlistTvseriesEvent {}

class WatchlistTvseriesHapusItemEvent extends WatchlistTvseriesEvent {
  final TvlsDetail tvSeriesDetail;

  const WatchlistTvseriesHapusItemEvent(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class WatchlistTvseriesTambahItemEvent extends WatchlistTvseriesEvent {
  final TvlsDetail tvSeriesDetail;

  const WatchlistTvseriesTambahItemEvent(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}
