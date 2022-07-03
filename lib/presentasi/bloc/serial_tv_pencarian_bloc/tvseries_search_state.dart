part of 'tvseries_search_bloc.dart';

abstract class TvseriesSearchState extends Equatable {
  const TvseriesSearchState();

  @override
  List<Object> get props => [];
}

class TvseriesSearchLoading extends TvseriesSearchState {}

class TvseriesSearchEmpty extends TvseriesSearchState {}

class TvseriesSearchLoaded extends TvseriesSearchState {
  final List<Tvls> result;

  const TvseriesSearchLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class TvseriesSearchError extends TvseriesSearchState {
  final String message;

  const TvseriesSearchError(this.message);

  @override
  List<Object> get props => [message];
}
