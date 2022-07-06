part of 'movie_watchlist_bloc.dart';

abstract class EventDaftarTontonFilm extends Equatable {
  const EventDaftarTontonFilm();

  @override
  List<Object> get props => [];
}

class GetListEvent extends EventDaftarTontonFilm {}

class GetStatusTvEvent extends EventDaftarTontonFilm {
  final int id;

  const GetStatusTvEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetStatusMovieEvent extends EventDaftarTontonFilm {
  final int id;

  const GetStatusMovieEvent(this.id);

  @override
  List<Object> get props => [id];
}

class RemoveItemMovieEvent extends EventDaftarTontonFilm {
  final MovieDetail movieDetail;

  const RemoveItemMovieEvent(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class AddItemMovieEvent extends EventDaftarTontonFilm {
  final MovieDetail movieDetail;

  const AddItemMovieEvent(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
