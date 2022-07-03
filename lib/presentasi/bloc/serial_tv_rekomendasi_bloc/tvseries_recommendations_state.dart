part of 'tvseries_recommendations_bloc.dart';

abstract class TvseriesRecommendationsState extends Equatable {
  const TvseriesRecommendationsState();

  @override
  List<Object> get props => [];
}

class TvseriesRecommendationsLoading extends TvseriesRecommendationsState {}

class TvseriesRecommendationsEmpty extends TvseriesRecommendationsState {}

class TvseriesRecommendationsLoaded extends TvseriesRecommendationsState {
  final List<Tvls> tvSeries;

  const TvseriesRecommendationsLoaded(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class TvseriesRecommendationsError extends TvseriesRecommendationsState {
  final String message;

  const TvseriesRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}
