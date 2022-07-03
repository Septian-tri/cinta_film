import 'package:cinta_film/data/datasources/db/database_helper_tvls.dart';
import 'package:cinta_film/data/datasources/tvls/tvls_local_data_source.dart';
import 'package:cinta_film/data/datasources/tvls/tvls_remote_data_source.dart';
import 'package:cinta_film/domain/repositories/tvls_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:cinta_film/domain/usecases/tvls/search_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/save_watchlist_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/remove_watchlist_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_watchlist_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_watchlist_status_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_tvls_recomendations.dart';
import 'package:cinta_film/domain/usecases/tvls/get_tvls_detail.dart';
import 'package:cinta_film/domain/usecases/tvls/get_top_rated_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_popular_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_now_playing_tvls.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_terpopuler_bloc/popular_tvseries_bloc.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_saat_ini_tayang_bloc/on_the_air_tvseries_bloc.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_rekomendasi_bloc/tvseries_recommendations_bloc.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_rating_terbaik_bloc/top_rated_tvseries_bloc.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_pencarian_bloc/tvseries_search_bloc.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_detail_bloc/tvseries_detail_bloc.dart';
import 'package:cinta_film/presentasi/bloc/serial_tv_daftar_tonton_bloc/watchlist_tvseries_bloc.dart';

@GenerateMocks([
  TvlsRepository,
  TvlsRemoteDataSource,
  TvlsLocalDataSource,
  DatabaseHelperTvls,
  WatchlistTvseriesBloc,
  TvseriesDetailBloc,
  TvseriesSearchBloc,
  TopRatedTvseriesBloc,
  TvseriesRecommendationsBloc,
  OnTheAirTvseriesBloc,
  PopularTvseriesBloc,
  GetserialTvSaatIniDiPutarls,
  GetPopularTvls,
  GetTopRatedTvls,
  GetTvlsDetail,
  GetTvlsRecommendations,
  ClassStatusDaftarTontonTvls,
  GetwatchlistTvls,
  ClassHapusDaftarTontonTvls,
  ClassSimpanDaftarTontonTvls,
  SearchTvls
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
