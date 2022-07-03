import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_detail_bloc/tvseries_detail_bloc.dart';
import 'package:cinta_film/common/failure.dart';
import '../../dummy_data/dummy_objects_tvls.dart';
import '../../helpers/test_helper_tvls.mocks.dart';

void main() {
  late MockGetTvlsDetail mockGetTvSeriesDetail;

  late TvseriesDetailBloc tvseriesDetailBloc;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvlsDetail();

    tvseriesDetailBloc = TvseriesDetailBloc(mockGetTvSeriesDetail);
  });

  const revtvseriesId = 1;

  test("TvseriesDetailBloc must be initial state should be empty", () {
    expect(tvseriesDetailBloc.state, TvseriesDetailEmpty());
  });

  blocTest<TvseriesDetailBloc, TvseriesDetailState>(
    'TvseriesDetailBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTvSeriesDetail.execute(revtvseriesId))
          .thenAnswer((_) async => Right(testTvDetail));

      return tvseriesDetailBloc;
    },
    act: (bloc) => bloc.add(const TvseriesDetailGetEvent(revtvseriesId)),
    expect: () => [TvseriesDetailLoading(), TvseriesDetailLoaded(testTvDetail)],
    verify: (bloc) {
      verify(mockGetTvSeriesDetail.execute(revtvseriesId));
    },
  );

  blocTest<TvseriesDetailBloc, TvseriesDetailState>(
    'TvseriesDetailBloc must be emit [Loading, Error] when get detail is unsuccessful',
    build: () {
      when(mockGetTvSeriesDetail.execute(revtvseriesId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return tvseriesDetailBloc;
    },
    act: (bloc) => bloc.add(const TvseriesDetailGetEvent(revtvseriesId)),
    expect: () =>
        [TvseriesDetailLoading(), const TvseriesDetailError('Server Failure')],
    verify: (bloc) {
      verify(mockGetTvSeriesDetail.execute(revtvseriesId));
    },
  );
}
