import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/entities/movie_detail.dart';
import 'package:cinta_film/domain/usecases/ambil_status_daftar_tonton.dart';
import 'package:cinta_film/domain/usecases/ambil_daftar_tonton_film.dart';
import 'package:cinta_film/domain/usecases/hapus_daftar_tonton.dart';
import 'package:cinta_film/domain/usecases/daftar_tonton.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'movie_watchlist_state.dart';
part 'movie_watchlist_event.dart';


class DaftarTontonFilmBloc
    extends Bloc<EventDaftarTontonFilm, StateDaftarTontonFilm> {
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  static const watchlistAddSuccessMessage = 'Added to Watchlist';

  final ClassStatusDaftarTonton getWatchListStatus;
  final ClassDaftarTontonFilm getWatchlistMovies;
  final ClassHapusDaftarTonton removeWatchlist;
  final ClassSimpanDaftarTonton saveWatchlist;

  DaftarTontonFilmBloc({
    required this.getWatchlistMovies,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieWatchlistEmpty()) {
    on<GetListEvent>((event, emit) async {
      emit(MovieWatchlistLoading());

      final result = await getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(MovieWatchlistError(failure.message));
        },
        (data) {
          emit(MovieWatchlistLoaded(data));
        },
      );
    });

    on<GetStatusMovieEvent>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);

      emit(MovieWatchlistStatusLoaded(result));
    });

    on<AddItemMovieEvent>((event, emit) async {
      final movieDetail = event.movieDetail;

      final result = await saveWatchlist.execute(movieDetail);

      result.fold(
        (failure) {
          emit(MovieWatchlistError(failure.message));
        },
        (successMessage) {
          emit(MovieWatchlistSuccess(successMessage));
        },
      );
    });

    on<RemoveItemMovieEvent>((event, emit) async {
      final movieDetail = event.movieDetail;

      final result = await removeWatchlist.execute(movieDetail);

      result.fold(
        (failure) {
          emit(MovieWatchlistError(failure.message));
        },
        (successMessage) {
          emit(MovieWatchlistSuccess(successMessage));
        },
      );
    });
  }
}
