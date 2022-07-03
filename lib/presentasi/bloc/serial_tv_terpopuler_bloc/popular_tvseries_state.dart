part of 'popular_tvseries_bloc.dart';

abstract class PopularTvseriesState extends Equatable {
  const PopularTvseriesState();

  @override
  List<Object> get props => [];
}

class PopularTvseriesLoading extends PopularTvseriesState {}

class PopularTvseriesEmpty extends PopularTvseriesState {}

class PopularTvseriesLoaded extends PopularTvseriesState {
  final List<Tvls> result;

  const PopularTvseriesLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class PopularTvseriesError extends PopularTvseriesState {
  final String message;

  const PopularTvseriesError(this.message);

  @override
  List<Object> get props => [message];
}
