part of 'movie_detail_bloc.dart';

abstract class EventDetailFilm extends Equatable {
  const EventDetailFilm();

  @override
  List<Object> get props => [];
}

class GetEventDetailFilm extends EventDetailFilm {
  final int id;

  const GetEventDetailFilm(this.id);

  @override
  List<Object> get props => [];
}
