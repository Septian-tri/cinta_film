import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cinta_film/presentasi/bloc/film_pencarian_bloc/movie_search_bloc.dart';
import 'package:cinta_film/common/failure.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockClassCariFilm mockSearchMovies;

  late MovieSearchBloc movieSearchBloc;

  setUp(() {
    mockSearchMovies = MockClassCariFilm();

    movieSearchBloc = MovieSearchBloc(
      searchMovies: mockSearchMovies,
    );
  });

  const query = "originalTitle";

  test("MovieSearchBloc must be initial state should be empty", () {
    expect(movieSearchBloc.state, MovieSearchEmpty());
  });

  blocTest<MovieSearchBloc, MovieSearchState>(
    'MovieSearchBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(query))
          .thenAnswer((_) async => Right(testMovieList));

      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(const MovieSearchQueryEvent(query)),
    expect: () => [MovieSearchLoading(), MovieSearchLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockSearchMovies.execute(query));
    },
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'MovieSearchBloc must be emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(query))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(const MovieSearchQueryEvent(query)),
    expect: () =>
        [MovieSearchLoading(), const MovieSearchError('Server Failure')],
    verify: (bloc) {
      verify(mockSearchMovies.execute(query));
    },
  );
}
