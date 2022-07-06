import 'package:cinta_film/domain/entities/movie_detail.dart';
import 'package:cinta_film/domain/usecases/ambil_data_detail_film.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'movie_detail_state.dart';
part 'movie_detail_event.dart';

class DetailFilmBloc extends Bloc<EventDetailFilm, StateDetailFilm> {
  final AmbilDataDetailFilm getMovieDetail;

  DetailFilmBloc({
    required this.getMovieDetail,
  }) : super(DataDetailFilmKosong()) {
    on<GetEventDetailFilm>((event, emit) async {
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
