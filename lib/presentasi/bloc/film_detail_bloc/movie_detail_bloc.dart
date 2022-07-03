import 'package:cinta_film/domain/entities/movie_detail.dart';
import 'package:cinta_film/domain/usecases/ambil_data_detail_film.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'movie_detail_state.dart';
part 'movie_detail_event.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc({
    required this.getMovieDetail,
  }) : super(MovieDetailEmpty()) {
    on<GetMovieDetailEvent>((event, emit) async {
      emit(MovieDetailLoading());

      final result = await getMovieDetail.execute(event.id);

      result.fold(
        (failure) {
          emit(MovieDetailError(failure.message));
        },
        (data) {
          emit(MovieDetailLoaded(data));
        },
      );
    });
  }
}
