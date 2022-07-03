part of 'movie_popular_bloc.dart';

abstract class MoviePopularState extends Equatable {
  const MoviePopularState();

  @override
  List<Object> get props => [];
}

class MoviePopularLoading extends MoviePopularState {}

class MoviePopularEmpty extends MoviePopularState {}

class MoviePopularLoaded extends MoviePopularState {
  final List<Film> result;

  const MoviePopularLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class MoviePopularError extends MoviePopularState {
  final String message;

  const MoviePopularError(this.message);

  @override
  List<Object> get props => [message];
}
