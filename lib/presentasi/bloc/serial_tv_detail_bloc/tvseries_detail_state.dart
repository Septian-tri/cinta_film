part of 'tvseries_detail_bloc.dart';

abstract class TvseriesDetailState extends Equatable {
  const TvseriesDetailState();

  @override
  List<Object> get props => [];
}

class TvseriesDetailLoading extends TvseriesDetailState {}

class TvseriesDetailEmpty extends TvseriesDetailState {}

class TvseriesDetailLoaded extends TvseriesDetailState {
  final TvlsDetail tvSeriesDetail;

  const TvseriesDetailLoaded(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class TvseriesDetailError extends TvseriesDetailState {
  final String message;

  const TvseriesDetailError(this.message);

  @override
  List<Object> get props => [message];
}
