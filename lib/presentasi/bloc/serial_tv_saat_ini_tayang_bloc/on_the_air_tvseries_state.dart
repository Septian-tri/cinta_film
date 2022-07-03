part of 'on_the_air_tvseries_bloc.dart';

abstract class OnTheAirTvseriesState extends Equatable {
  const OnTheAirTvseriesState();

  @override
  List<Object> get props => [];
}

class OnTheAirTvseriesLoading extends OnTheAirTvseriesState {}

class OnTheAirTvseriesEmpty extends OnTheAirTvseriesState {}

class OnTheAirTvseriesLoaded extends OnTheAirTvseriesState {
  final List<Tvls> result;

  const OnTheAirTvseriesLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class OnTheAirTvseriesError extends OnTheAirTvseriesState {
  final String message;

  const OnTheAirTvseriesError(this.message);

  @override
  List<Object> get props => [message];
}
