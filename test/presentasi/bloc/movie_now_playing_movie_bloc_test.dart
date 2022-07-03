import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cinta_film/presentasi/bloc/film_saat_ini_tayang_bloc/movie_now_playing_bloc.dart';
import 'package:cinta_film/common/failure.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockClasFilmTayangSaatIni mockGetNowPlayingMovies;

  late MovieNowPlayingBloc movieNowPlayingBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockClasFilmTayangSaatIni();

    movieNowPlayingBloc = MovieNowPlayingBloc(mockGetNowPlayingMovies);
  });

  test("MovieNowPlayingBloc must be initial state should be empty", () {
    expect(movieNowPlayingBloc.state, MovieNowPlayingEmpty());
  });

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    'MovieNowPlayingBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));

      return movieNowPlayingBloc;
    },
    act: (bloc) => bloc.add(MovieNowPlayingGetEvent()),
    expect: () =>
        [MovieNowPlayingLoading(), MovieNowPlayingLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    'MovieNowPlayingBloc must be emit [Loading, Error] when get now playing is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return movieNowPlayingBloc;
    },
    act: (bloc) => bloc.add(MovieNowPlayingGetEvent()),
    expect: () => [
      MovieNowPlayingLoading(),
      const MovieNowPlayingError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}
