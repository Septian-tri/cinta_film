import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_rekomendasi_bloc/tvseries_recommendations_bloc.dart';
import 'package:cinta_film/common/failure.dart';
import '../../dummy_data/dummy_objects_tvls.dart';
import '../../helpers/test_helper_tvls.mocks.dart';

void main() {
  late MockGetTvlsRecommendations mockGetTvSeriesRecommendations;

  late TvseriesRecommendationsBloc tvseriesRecommendationsBloc;

  setUp(() {
    mockGetTvSeriesRecommendations = MockGetTvlsRecommendations();
    tvseriesRecommendationsBloc =
        TvseriesRecommendationsBloc(mockGetTvSeriesRecommendations);
  });

  test("TvseriesRecommendationsBloc must be initial state should be empty", () {
    expect(tvseriesRecommendationsBloc.state, TvseriesRecommendationsEmpty());
  });

  const revtvseriesId = 1;

  blocTest<TvseriesRecommendationsBloc, TvseriesRecommendationsState>(
    'TvseriesRecommendationsBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(revtvseriesId))
          .thenAnswer((_) async => Right(testTvList));

      return tvseriesRecommendationsBloc;
    },
    act: (bloc) =>
        bloc.add(const TvseriesRecommendationsGetEvent(revtvseriesId)),
    expect: () => [
      TvseriesRecommendationsLoading(),
      TvseriesRecommendationsLoaded(testTvList)
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendations.execute(revtvseriesId));
    },
  );

  blocTest<TvseriesRecommendationsBloc, TvseriesRecommendationsState>(
    'TvseriesRecommendationsBloc must be emit [Loading, Error] when get recommendation is unsuccessful',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(revtvseriesId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return tvseriesRecommendationsBloc;
    },
    act: (bloc) =>
        bloc.add(const TvseriesRecommendationsGetEvent(revtvseriesId)),
    expect: () => [
      TvseriesRecommendationsLoading(),
      const TvseriesRecommendationsError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendations.execute(revtvseriesId));
    },
  );
}
