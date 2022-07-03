part of 'top_rated_tvseries_bloc.dart';

abstract class TopRatedTvseriesState extends Equatable {
  const TopRatedTvseriesState();

  @override
  List<Object> get props => [];
}

class TopRatedTvseriesLoading extends TopRatedTvseriesState {}

class TopRatedTvseriesEmpty extends TopRatedTvseriesState {}

class TopRatedTvseriesLoaded extends TopRatedTvseriesState {
  final List<Tvls> result;

  const TopRatedTvseriesLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class TopRatedTvseriesError extends TopRatedTvseriesState {
  final String message;

  const TopRatedTvseriesError(this.message);

  @override
  List<Object> get props => [message];
}
