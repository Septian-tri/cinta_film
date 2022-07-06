part of 'movie_detail_bloc.dart';

abstract class StateDetailFilm extends Equatable {
  const StateDetailFilm();

  @override
  List<Object> get props => [];
}

class MovieDetailLoading extends StateDetailFilm {}

class DataDetailFilmKosong extends StateDetailFilm {}

class MovieDetailError extends StateDetailFilm {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailLoaded extends StateDetailFilm {
  final MovieDetail movieDetail;

  const MovieDetailLoaded(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
