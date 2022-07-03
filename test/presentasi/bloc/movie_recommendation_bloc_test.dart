import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cinta_film/presentasi/bloc/film_rekomendasi_bloc/movie_recommendation_bloc.dart';
import 'package:cinta_film/common/failure.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockAmbilDataRekomendasiFilm mockGetMovieRecommendation;

  late MovieRecommendationBloc movieRecommendationBloc;

  setUp(() {
    mockGetMovieRecommendation = MockAmbilDataRekomendasiFilm();

    movieRecommendationBloc = MovieRecommendationBloc(
      getMovieRecommendations: mockGetMovieRecommendation,
    );
  });

  test("MovieRecommendationBloc must be initial state should be empty", () {
    expect(movieRecommendationBloc.state, MovieRecommendationEmpty());
  });

  const revId = 1;

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'MovieRecommendationBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendation.execute(revId))
          .thenAnswer((_) async => Right(testMovieList));

      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const GetMovieRecommendationEvent(revId)),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationLoaded(testMovieList)
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendation.execute(revId));
    },
  );

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'MovieRecommendationBloc must emit [Loading, Error] when get recommendation is unsuccessful',
    build: () {
      when(mockGetMovieRecommendation.execute(revId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const GetMovieRecommendationEvent(revId)),
    expect: () => [
      MovieRecommendationLoading(),
      const MovieRecommendationError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendation.execute(revId));
    },
  );
}
