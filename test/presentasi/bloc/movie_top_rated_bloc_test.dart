import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cinta_film/presentasi/bloc/film_rating_terbaik_bloc/movie_top_rated_bloc.dart';
import 'package:cinta_film/common/failure.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockClassFilmRatingTerbaik mockGetTopRatedMovies;

  late MovieTopRatedBloc movieTopRatedBloc;

  setUp(() {
    mockGetTopRatedMovies = MockClassFilmRatingTerbaik();

    movieTopRatedBloc = MovieTopRatedBloc(mockGetTopRatedMovies);
  });

  test("MovieTopRatedBloc must be initial state should be empty", () {
    expect(movieTopRatedBloc.state, MovieTopRatedEmpty());
  });

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'MovieTopRatedBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));

      return movieTopRatedBloc;
    },
    act: (bloc) => bloc.add(MovieTopRatedGetEvent()),
    expect: () => [MovieTopRatedLoading(), MovieTopRatedLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'MovieTopRatedBloc must be emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return movieTopRatedBloc;
    },
    act: (bloc) => bloc.add(MovieTopRatedGetEvent()),
    expect: () =>
        [MovieTopRatedLoading(), MovieTopRatedError('Server Failure')],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
