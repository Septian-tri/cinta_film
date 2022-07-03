import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_daftar_tonton_bloc/watchlist_tvseries_bloc.dart';
import 'package:cinta_film/common/failure.dart';
import '../../dummy_data/dummy_objects_tvls.dart';
import '../../helpers/test_helper_tvls.mocks.dart';

void main() {
  late MockGetwatchlistTvls mockGetWatchlistTvSeries;
  late MockClassStatusDaftarTontonTvls mockGetWatchListStatusTvSeries;
  late MockClassSimpanDaftarTontonTvls mockSaveWatchlistTvSeries;
  late MockClassHapusDaftarTontonTvls mockRemoveWatchlistTvSeries;
  late WatchlistTvseriesBloc watchlistTvseriesBloc;
  setUp(() {
    mockGetWatchlistTvSeries = MockGetwatchlistTvls();
    mockGetWatchListStatusTvSeries = MockClassStatusDaftarTontonTvls();
    mockSaveWatchlistTvSeries = MockClassSimpanDaftarTontonTvls();
    mockRemoveWatchlistTvSeries = MockClassHapusDaftarTontonTvls();
    watchlistTvseriesBloc = WatchlistTvseriesBloc(
        mockGetWatchlistTvSeries,
        mockGetWatchListStatusTvSeries,
        mockSaveWatchlistTvSeries,
        mockRemoveWatchlistTvSeries);
  });
  const revtvseriesId = 1;
  test("WatchlistTvseriesBloc must be initial state should be empty", () {
    expect(watchlistTvseriesBloc.state, WatchlistTvseriesEmpty());
  });
  blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
    'WatchlistTvseriesBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right(testTvList));
      return watchlistTvseriesBloc;
    },
    act: (bloc) => bloc.add(WatchlistTvseriesGetEvent()),
    expect: () =>
        [WatchlistTvseriesLoading(), WatchlistTvseriesLoaded(testTvList)],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );
  blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
    'WatchlistTvseriesBloc must be emit [Loading, Error] when get watchlist is unsuccessful',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure("Can't get data")));
      return watchlistTvseriesBloc;
    },
    act: (bloc) => bloc.add(WatchlistTvseriesGetEvent()),
    expect: () => [
      WatchlistTvseriesLoading(),
      const WatchlistTvseriesError("Can't get data")
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );
  blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
    'WatchlistTvseriesBloc must be emit [Loaded] when get status tv watchlist is successful',
    build: () {
      when(mockGetWatchListStatusTvSeries.execute(revtvseriesId))
          .thenAnswer((_) async => true);
      return watchlistTvseriesBloc;
    },
    act: (bloc) =>
        bloc.add(const WatchlistTvseriesGetStatusEvent(revtvseriesId)),
    expect: () => [const WatchlistTvseriesStatusLoaded(true)],
    verify: (bloc) {
      verify(mockGetWatchListStatusTvSeries.execute(revtvseriesId));
    },
  );
  blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
    'WatchlistTvseriesBloc must be emit [success] when add tv item to watchlist is successful',
    build: () {
      when(mockSaveWatchlistTvSeries.execute(testTvDetail))
          .thenAnswer((_) async => const Right("Success"));
      return watchlistTvseriesBloc;
    },
    act: (bloc) => bloc.add(WatchlistTvseriesTambahItemEvent(testTvDetail)),
    expect: () => [const WatchlistTvseriesSuccess("Success")],
    verify: (bloc) {
      verify(mockSaveWatchlistTvSeries.execute(testTvDetail));
    },
  );
  blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
    'WatchlistTvseriesBloc must be emit [success] when remove tv item to watchlist is successful',
    build: () {
      when(mockRemoveWatchlistTvSeries.execute(testTvDetail))
          .thenAnswer((_) async => const Right("Removed"));
      return watchlistTvseriesBloc;
    },
    act: (bloc) => bloc.add(WatchlistTvseriesHapusItemEvent(testTvDetail)),
    expect: () => [const WatchlistTvseriesSuccess("Removed")],
    verify: (bloc) {
      verify(mockRemoveWatchlistTvSeries.execute(testTvDetail));
    },
  );
  blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
    'WatchlistTvseriesBloc must be emit [error] when add tv item to watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlistTvSeries.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return watchlistTvseriesBloc;
    },
    act: (bloc) => bloc.add(WatchlistTvseriesTambahItemEvent(testTvDetail)),
    expect: () => [const WatchlistTvseriesError("Failed")],
    verify: (bloc) {
      verify(mockSaveWatchlistTvSeries.execute(testTvDetail));
    },
  );
  blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
    'WatchlistTvseriesBloc must be emit [error] when remove tv item to watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlistTvSeries.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return watchlistTvseriesBloc;
    },
    act: (bloc) => bloc.add(WatchlistTvseriesHapusItemEvent(testTvDetail)),
    expect: () => [const WatchlistTvseriesError("Failed")],
    verify: (bloc) {
      verify(mockRemoveWatchlistTvSeries.execute(testTvDetail));
    },
  );
}
