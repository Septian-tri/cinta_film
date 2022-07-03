import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_terpopuler_bloc/popular_tvseries_bloc.dart';
import 'package:cinta_film/common/failure.dart';
import '../../dummy_data/dummy_objects_tvls.dart';
import '../../helpers/test_helper_tvls.mocks.dart';

void main() {
  late MockGetPopularTvls mockGetPopularTvSeries;

  late PopularTvseriesBloc popularTvseriesBloc;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvls();

    popularTvseriesBloc = PopularTvseriesBloc(mockGetPopularTvSeries);
  });

  test("PopularTvseriesBloc must be initial state should be empty", () {
    expect(popularTvseriesBloc.state, PopularTvseriesEmpty());
  });

  blocTest<PopularTvseriesBloc, PopularTvseriesState>(
    'PopularTvseriesBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(testTvList));

      return popularTvseriesBloc;
    },
    act: (bloc) => bloc.add(PopularTvseriesGetEvent()),
    expect: () => [PopularTvseriesLoading(), PopularTvseriesLoaded(testTvList)],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );

  blocTest<PopularTvseriesBloc, PopularTvseriesState>(
    'PopularTvseriesBloc must be emit [Loading, Error] when get popular is unsuccessful',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return popularTvseriesBloc;
    },
    act: (bloc) => bloc.add(PopularTvseriesGetEvent()),
    expect: () =>
        [PopularTvseriesLoading(), PopularTvseriesError('Server Failure')],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );
}
