part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistLoading extends MovieWatchlistState {}

class MovieWatchlistEmpty extends MovieWatchlistState {}

class MovieWatchlistSuccess extends MovieWatchlistState {
  final String message;

  const MovieWatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistError extends MovieWatchlistState {
  final String message;

  const MovieWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistStatusLoaded extends MovieWatchlistState {
  final bool result;

  const MovieWatchlistStatusLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class MovieWatchlistLoaded extends MovieWatchlistState {
  final List<Film> result;

  const MovieWatchlistLoaded(this.result);

  @override
  List<Object> get props => [result];
}
