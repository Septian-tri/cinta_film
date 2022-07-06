part of 'movie_watchlist_bloc.dart';

abstract class StateDaftarTontonFilm extends Equatable {
  const StateDaftarTontonFilm();

  @override
  List<Object> get props => [];
}

class MovieWatchlistLoading extends StateDaftarTontonFilm {}

class MovieWatchlistEmpty extends StateDaftarTontonFilm {}

class MovieWatchlistSuccess extends StateDaftarTontonFilm {
  final String message;

  const MovieWatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistError extends StateDaftarTontonFilm {
  final String message;

  const MovieWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistStatusLoaded extends StateDaftarTontonFilm {
  final bool result;

  const MovieWatchlistStatusLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class MovieWatchlistLoaded extends StateDaftarTontonFilm {
  final List<Film> result;

  const MovieWatchlistLoaded(this.result);

  @override
  List<Object> get props => [result];
}
