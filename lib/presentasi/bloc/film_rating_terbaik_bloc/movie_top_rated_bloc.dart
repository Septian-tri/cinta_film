import 'package:cinta_film/domain/usecases/ambil_data_film_rating_terbaik.dart';
import 'package:cinta_film/domain/entities/film.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'movie_top_rated_state.dart';
part 'movie_top_rated_event.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final ClassFilmRatingTerbaik getTopRatedMovies;

  MovieTopRatedBloc(
    this.getTopRatedMovies,
  ) : super(MovieTopRatedEmpty()) {
    on<MovieTopRatedGetEvent>((event, emit) async {
      emit(MovieTopRatedLoading());

      final result = await getTopRatedMovies.execute();

      result.fold(
        (failure) {
          emit(MovieTopRatedError(failure.message));
        },
        (data) {
          emit(MovieTopRatedLoaded(data));
        },
      );
    });
  }
}
