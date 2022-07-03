import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_rating_terbaik_bloc/top_rated_tvseries_bloc.dart';
import 'package:cinta_film/common/failure.dart';
import '../../dummy_data/dummy_objects_tvls.dart';
import '../../helpers/test_helper_tvls.mocks.dart';

void main() {
  late MockGetTopRatedTvls mockGetTopRatedTvSeries;

  late TopRatedTvseriesBloc topRatedTvseriesBloc;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvls();

    topRatedTvseriesBloc = TopRatedTvseriesBloc(mockGetTopRatedTvSeries);
  });

  test("TopRatedTvseriesBloc must be initial state should be empty", () {
    expect(topRatedTvseriesBloc.state, TopRatedTvseriesEmpty());
  });

  blocTest<TopRatedTvseriesBloc, TopRatedTvseriesState>(
    'TopRatedTvseriesBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(testTvList));

      return topRatedTvseriesBloc;
    },
    act: (bloc) => bloc.add(TopRatedTvseriesGetEvent()),
    expect: () =>
        [TopRatedTvseriesLoading(), TopRatedTvseriesLoaded(testTvList)],
    verify: (bloc) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );

  blocTest<TopRatedTvseriesBloc, TopRatedTvseriesState>(
    'TopRatedTvseriesBloc must be emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return topRatedTvseriesBloc;
    },
    act: (bloc) => bloc.add(TopRatedTvseriesGetEvent()),
    expect: () => [
      TopRatedTvseriesLoading(),
      const TopRatedTvseriesError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );
}
