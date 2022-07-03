part of 'movie_top_rated_bloc.dart';

abstract class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();

  @override
  List<Object> get props => [];
}

class MovieTopRatedLoading extends MovieTopRatedState {}

class MovieTopRatedEmpty extends MovieTopRatedState {}

class MovieTopRatedLoaded extends MovieTopRatedState {
  final List<Film> result;

  const MovieTopRatedLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class MovieTopRatedError extends MovieTopRatedState {
  final String message;

  const MovieTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}
