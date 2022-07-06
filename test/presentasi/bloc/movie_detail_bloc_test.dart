import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cinta_film/presentasi/bloc/film_detail_bloc/movie_detail_bloc.dart';
import 'package:cinta_film/common/failure.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockAmbilDataDetailFilm mockAmbilDataDetailFilm;

  late DetailFilmBloc movieDetailBloc;

  const revId = 1;

  setUp(() {
    mockAmbilDataDetailFilm = MockAmbilDataDetailFilm();

    movieDetailBloc = DetailFilmBloc(getMovieDetail: mockAmbilDataDetailFilm);
  });

  test("DetailFilmBloc must be initial state should be empty", () {
    expect(movieDetailBloc.state, DataDetailFilmKosong());
  });

  blocTest<DetailFilmBloc, StateDetailFilm>(
    'DetailFilmBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockAmbilDataDetailFilm.execute(revId))
          .thenAnswer((_) async => Right(testMovieDetail));

      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(const GetEventDetailFilm(revId)),
    expect: () => [MovieDetailLoading(), MovieDetailLoaded(testMovieDetail)],
    verify: (bloc) {
      verify(mockAmbilDataDetailFilm.execute(revId));
    },
  );

  blocTest<DetailFilmBloc, StateDetailFilm>(
    'DetailFilmBloc must be emit [Loading, Error] when get detail is unsuccessful',
    build: () {
      when(mockAmbilDataDetailFilm.execute(revId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(const GetEventDetailFilm(revId)),
    expect: () =>
        [MovieDetailLoading(), const MovieDetailError('Server Failure')],
    verify: (bloc) {
      verify(mockAmbilDataDetailFilm.execute(revId));
    },
  );
}
