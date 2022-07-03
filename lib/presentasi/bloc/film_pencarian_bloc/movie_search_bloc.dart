import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/usecases/cari_film.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'movie_search_state.dart';
part 'movie_search_event.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final ClassCariFilm searchMovies;

  MovieSearchBloc({
    required this.searchMovies,
  }) : super(MovieSearchEmpty()) {
    on<MovieSearchSetEmpty>((event, emit) => emit(MovieSearchEmpty()));

    on<MovieSearchQueryEvent>((event, emit) async {
      emit(MovieSearchLoading());

      final result = await searchMovies.execute(event.query);

      result.fold(
        (failure) {
          emit(MovieSearchError(failure.message));
        },
        (data) {
          emit(MovieSearchLoaded(data));
        },
      );
    });
  }
}
