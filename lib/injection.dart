import 'package:cinta_film/data/datasources/db/database_helper.dart';
import 'package:cinta_film/data/datasources/db/database_helper_tvls.dart';
import 'package:cinta_film/data/datasources/film/movie_local_data_source.dart';
import 'package:cinta_film/data/datasources/film/movie_remote_data_source.dart';
import 'package:cinta_film/data/datasources/tvls/tvls_local_data_source.dart';
import 'package:cinta_film/data/datasources/tvls/tvls_remote_data_source.dart';
import 'package:cinta_film/data/repositories/movie_repository_impl.dart';
import 'package:cinta_film/data/repositories/tvls_repository_impl.dart';
import 'package:cinta_film/domain/repositories/movie_repository.dart';
import 'package:cinta_film/domain/repositories/tvls_repository.dart';
import 'package:cinta_film/domain/usecases/ambil_data_detail_film.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_rekomendasi.dart';
import 'package:cinta_film/domain/usecases/ambil_data_tayang_saat_ini.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_terpopuler.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_rating_terbaik.dart';
import 'package:cinta_film/domain/usecases/ambil_daftar_tonton_film.dart';
import 'package:cinta_film/domain/usecases/ambil_status_daftar_tonton.dart';
import 'package:cinta_film/domain/usecases/hapus_daftar_tonton.dart';
import 'package:cinta_film/domain/usecases/daftar_tonton.dart';
import 'package:cinta_film/domain/usecases/cari_film.dart';
import 'package:cinta_film/domain/usecases/tvls/get_now_playing_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_popular_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_top_rated_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_tvls_detail.dart';
import 'package:cinta_film/domain/usecases/tvls/get_tvls_recomendations.dart';
import 'package:cinta_film/domain/usecases/tvls/get_watchlist_status_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_watchlist_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/remove_watchlist_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/save_watchlist_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/search_tvls.dart';
import 'package:cinta_film/presentasi/bloc/film_detail_bloc/movie_detail_bloc.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_daftar_tonton_bloc/watchlist_tvseries_bloc.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_rating_terbaik_bloc/top_rated_tvseries_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:cinta_film/common/ssl_pinning.dart';
import 'package:cinta_film/presentasi/bloc/film_daftar_tonton_bloc/movie_watchlist_bloc.dart';
import 'package:cinta_film/presentasi/bloc/film_pencarian_bloc/movie_search_bloc.dart';
import 'package:cinta_film/presentasi/bloc/film_rating_terbaik_bloc/movie_top_rated_bloc.dart';
import 'package:cinta_film/presentasi/bloc/film_rekomendasi_bloc/movie_recommendation_bloc.dart';
import 'package:cinta_film/presentasi/bloc/film_saat_ini_tayang_bloc/movie_now_playing_bloc.dart';
import 'package:cinta_film/presentasi/bloc/film_terpopuler_bloc/movie_popular_bloc.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_detail_bloc/tvseries_detail_bloc.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_pencarian_bloc/tvseries_search_bloc.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_rekomendasi_bloc/tvseries_recommendations_bloc.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_saat_ini_tayang_bloc/on_the_air_tvseries_bloc.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_terpopuler_bloc/popular_tvseries_bloc.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(() => 
    DetailFilmBloc(
      getMovieDetail: locator(),
    )
  );
  locator.registerFactory(() =>
    MovieNowPlayingBloc(
      locator()
    ),
  );
  locator.registerFactory(() => 
    MoviePopularBloc(
      locator()
    ),
  );
  locator.registerFactory(() => 
    MovieRecommendationBloc(
      getMovieRecommendations: locator(),
    )
  );
  locator.registerFactory(() => 
    MovieSearchBloc(
      searchMovies: locator(),
    )
  );
  locator.registerFactory(() => 
    MovieTopRatedBloc(
      locator()
    ),
  );
  locator.registerFactory(() => 
    DaftarTontonFilmBloc(
      getWatchlistMovies: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    )
  );
  locator.registerFactory(() => 
    TvseriesDetailBloc(
      locator(),
    )
  );
  locator.registerFactory(() => 
    OnTheAirTvseriesBloc(
      locator()
    ),
  );
  locator.registerFactory(() => 
    PopularTvseriesBloc(
      locator()
    ),
  );
  locator.registerFactory(() => 
    TvseriesRecommendationsBloc(
      locator(),
    )
  );
  locator.registerFactory(() => 
    TvseriesSearchBloc(
        locator(),
    )
  );
  locator.registerFactory(() => 
    TopRatedTvseriesBloc(
      locator()
    ),
  );
  locator.registerFactory(() => 
    WatchlistTvseriesBloc(
        locator(),
        locator(),
        locator(),
        locator(),
    )
  );

  // use case
  locator.registerLazySingleton(() => ClasFilmTayangSaatIni(locator()));
  locator.registerLazySingleton(() => ClassFilmTerPopuler(locator()));
  locator.registerLazySingleton(() => ClassFilmRatingTerbaik(locator()));
  locator.registerLazySingleton(() => AmbilDataDetailFilm(locator()));
  locator.registerLazySingleton(() => AmbilDataRekomendasiFilm(locator()));
  locator.registerLazySingleton(() => ClassCariFilm(locator()));
  locator.registerLazySingleton(() => ClassStatusDaftarTonton(locator()));
  locator.registerLazySingleton(() => ClassSimpanDaftarTonton(locator()));
  locator.registerLazySingleton(() => ClassHapusDaftarTonton(locator()));
  locator.registerLazySingleton(() => ClassDaftarTontonFilm(locator()));

  locator.registerLazySingleton(() => GetserialTvSaatIniDiPutarls(locator()));
  locator.registerLazySingleton(() => GetPopularTvls(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvls(locator()));
  locator.registerLazySingleton(() => GetTvlsDetail(locator()));
  locator.registerLazySingleton(() => GetTvlsRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvls(locator()));
  locator.registerLazySingleton(() => ClassStatusDaftarTontonTvls(locator()));
  locator.registerLazySingleton(() => ClassSimpanDaftarTontonTvls(locator()));
  locator.registerLazySingleton(() => ClassHapusDaftarTontonTvls(locator()));
  locator.registerLazySingleton(() => GetwatchlistTvls(locator()));

  locator.registerLazySingleton<RepositoryFilm>(
    () => RepositoryFilmImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvlsRepository>(
    () => TvlsRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvlsRemoteDataSource>(
      () => TvlsRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvlsLocalDataSource>(
      () => TvlsLocalDataSourceImpl(databaseHelpertvls: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperTvls>(() => DatabaseHelperTvls());

  // external
  locator.registerLazySingleton(() => ClassSSLPinning.client);
}
