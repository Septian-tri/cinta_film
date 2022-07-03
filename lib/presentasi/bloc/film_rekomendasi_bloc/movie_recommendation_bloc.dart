import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_rekomendasi.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'movie_recommendation_state.dart';
part 'movie_recommendation_event.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final AmbilDataRekomendasiFilm getMovieRecommendations;

  MovieRecommendationBloc({
    required this.getMovieRecommendations,
  }) : super(MovieRecommendationEmpty()) {
    on<GetMovieRecommendationEvent>((event, emit) async {
      emit(MovieRecommendationLoading());

      final result = await getMovieRecommendations.execute(event.id);

      result.fold(
        (failure) {
          emit(MovieRecommendationError(failure.message));
        },
        (data) {
          emit(MovieRecommendationLoaded(data));
        },
      );
    });
  }
}
