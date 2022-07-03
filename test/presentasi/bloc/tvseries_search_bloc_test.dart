import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_pencarian_bloc/tvseries_search_bloc.dart';
import 'package:cinta_film/common/failure.dart';
import '../../dummy_data/dummy_objects_tvls.dart';
import '../../helpers/test_helper_tvls.mocks.dart';

void main() {
  late MockSearchTvls mockSearchTvSeries;
  late TvseriesSearchBloc tvseriesSearchBloc;

  setUp(() {
    mockSearchTvSeries = MockSearchTvls();
    tvseriesSearchBloc = TvseriesSearchBloc(mockSearchTvSeries);
  });
  const query = "originalTitle";

  test("TvseriesSearchBloc must be initial state should be empty", () {
    expect(tvseriesSearchBloc.state, TvseriesSearchEmpty());
  });

  blocTest<TvseriesSearchBloc, TvseriesSearchState>(
    'TvseriesSearchBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockSearchTvSeries.execute(query))
          .thenAnswer((_) async => Right(testTvList));
      return tvseriesSearchBloc;
    },
    act: (bloc) => bloc.add(const TvseriesSearchQueryEvent(query)),
    expect: () => [TvseriesSearchLoading(), TvseriesSearchLoaded(testTvList)],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(query));
    },
  );

  blocTest<TvseriesSearchBloc, TvseriesSearchState>(
    'TvseriesSearchBloc must be [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvSeries.execute(query))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvseriesSearchBloc;
    },
    act: (bloc) => bloc.add(const TvseriesSearchQueryEvent(query)),
    expect: () =>
        [TvseriesSearchLoading(), const TvseriesSearchError('Server Failure')],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(query));
    },
  );
}
