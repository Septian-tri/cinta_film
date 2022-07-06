import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cinta_film/presentasi/bloc/film_daftar_tonton_bloc/movie_watchlist_bloc.dart';
import 'package:cinta_film/common/failure.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockClassDaftarTontonFilm mockGetWatchlistMovies;
  late MockClassStatusDaftarTonton mockGetWatchListStatus;
  late MockClassSimpanDaftarTonton mockSaveWatchlist;
  late MockClassHapusDaftarTonton mockRemoveWatchlist;
  late DaftarTontonFilmBloc movieWatchlistBloc;

  setUp(() {
    mockGetWatchlistMovies = MockClassDaftarTontonFilm();
    mockGetWatchListStatus = MockClassStatusDaftarTonton();
    mockSaveWatchlist = MockClassSimpanDaftarTonton();
    mockRemoveWatchlist = MockClassHapusDaftarTonton();

    movieWatchlistBloc = DaftarTontonFilmBloc(
      getWatchlistMovies: mockGetWatchlistMovies,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const revId = 1;

  test("DaftarTontonFilmBloc must be initial state should be empty", () {
    expect(movieWatchlistBloc.state, MovieWatchlistEmpty());
  });

  blocTest<DaftarTontonFilmBloc, StateDaftarTontonFilm>(
    'DaftarTontonFilmBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));

      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(GetListEvent()),
    expect: () =>
        [MovieWatchlistLoading(), MovieWatchlistLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<DaftarTontonFilmBloc, StateDaftarTontonFilm>(
    'DaftarTontonFilmBloc must be emit [Loading, Error] when get watchlist is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure("Can't get data")));

      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(GetListEvent()),
    expect: () =>
        [MovieWatchlistLoading(), const MovieWatchlistError("Can't get data")],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<DaftarTontonFilmBloc, StateDaftarTontonFilm>(
    'DaftarTontonFilmBloc must emit [Loaded] when get status movie watchlist is successful',
    build: () {
      when(mockGetWatchListStatus.execute(revId)).thenAnswer((_) async => true);

      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(const GetStatusMovieEvent(revId)),
    expect: () => [const MovieWatchlistStatusLoaded(true)],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(revId));
    },
  );

  blocTest<DaftarTontonFilmBloc, StateDaftarTontonFilm>(
    'DaftarTontonFilmBloc must be emit [success] when add movie item to watchlist is successful',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right("Success"));

      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(AddItemMovieEvent(testMovieDetail)),
    expect: () => [const MovieWatchlistSuccess("Success")],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<DaftarTontonFilmBloc, StateDaftarTontonFilm>(
    'DaftarTontonFilmBloc must be emit [success] when remove movie item to watchlist is successful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right("Removed"));

      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveItemMovieEvent(testMovieDetail)),
    expect: () => [const MovieWatchlistSuccess("Removed")],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<DaftarTontonFilmBloc, StateDaftarTontonFilm>(
    'DaftarTontonFilmBloc must be emit [error] when add movie item to watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));

      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(AddItemMovieEvent(testMovieDetail)),
    expect: () => [const MovieWatchlistError("Failed")],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<DaftarTontonFilmBloc, StateDaftarTontonFilm>(
    'DaftarTontonFilmBloc must be emit [error] when remove movie item to watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));

      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveItemMovieEvent(testMovieDetail)),
    expect: () => [const MovieWatchlistError("Failed")],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );
}
