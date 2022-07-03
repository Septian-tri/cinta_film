import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_terpopuler.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'movie_popular_state.dart';
part 'movie_popular_event.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final ClassFilmTerPopuler getPopularMovies;

  MoviePopularBloc(
    this.getPopularMovies,
  ) : super(MoviePopularEmpty()) {
    on<MoviePopularGetEvent>((event, emit) async {
      emit(MoviePopularLoading());

      final result = await getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(MoviePopularError(failure.message));
        },
        (data) {
          emit(MoviePopularLoaded(data));
        },
      );
    });
  }
}
