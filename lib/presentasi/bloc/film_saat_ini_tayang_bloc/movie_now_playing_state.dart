part of 'movie_now_playing_bloc.dart';

abstract class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();

  @override
  List<Object> get props => [];
}

class MovieNowPlayingLoading extends MovieNowPlayingState {}

class MovieNowPlayingEmpty extends MovieNowPlayingState {}

class MovieNowPlayingLoaded extends MovieNowPlayingState {
  final List<Film> result;

  const MovieNowPlayingLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class MovieNowPlayingError extends MovieNowPlayingState {
  final String message;

  const MovieNowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}
