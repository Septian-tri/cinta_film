import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/usecases/ambil_data_tayang_saat_ini.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'movie_now_playing_state.dart';
part 'movie_now_playing_event.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final ClasFilmTayangSaatIni getNowPlayingMovies;

  MovieNowPlayingBloc(
    this.getNowPlayingMovies,
  ) : super(MovieNowPlayingEmpty()) {
    on<MovieNowPlayingGetEvent>((event, emit) async {
      emit(MovieNowPlayingLoading());

      final result = await getNowPlayingMovies.execute();

      result.fold(
        (failure) {
          emit(MovieNowPlayingError(failure.message));
        },
        (data) {
          emit(MovieNowPlayingLoaded(data));
        },
      );
    });
  }
}
