import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_saat_ini_tayang_bloc/on_the_air_tvseries_bloc.dart';
import 'package:cinta_film/common/failure.dart';
import '../../dummy_data/dummy_objects_tvls.dart';
import '../../helpers/test_helper_tvls.mocks.dart';

void main() {
  late MockGetserialTvSaatIniDiPutarls mockGetNowPlayingTvSeries;

  late OnTheAirTvseriesBloc onTheAirTvseriesBloc;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetserialTvSaatIniDiPutarls();

    onTheAirTvseriesBloc = OnTheAirTvseriesBloc(mockGetNowPlayingTvSeries);
  });

  test("OnTheAirTvseriesBloc must be initial state should be empty", () {
    expect(onTheAirTvseriesBloc.state, OnTheAirTvseriesEmpty());
  });

  blocTest<OnTheAirTvseriesBloc, OnTheAirTvseriesState>(
    'OnTheAirTvseriesBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(testTvList));

      return onTheAirTvseriesBloc;
    },
    act: (bloc) => bloc.add(OnTheAirTvseriesGetEvent()),
    expect: () =>
        [OnTheAirTvseriesLoading(), OnTheAirTvseriesLoaded(testTvList)],
    verify: (bloc) {
      verify(mockGetNowPlayingTvSeries.execute());
    },
  );

  blocTest<OnTheAirTvseriesBloc, OnTheAirTvseriesState>(
    'OnTheAirTvseriesBloc must be emit [Loading, Error] when get now playing is unsuccessful',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return onTheAirTvseriesBloc;
    },
    act: (bloc) => bloc.add(OnTheAirTvseriesGetEvent()),
    expect: () => [
      OnTheAirTvseriesLoading(),
      const OnTheAirTvseriesError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvSeries.execute());
    },
  );
}
