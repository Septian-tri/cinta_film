import 'package:cinta_film/data/datasources/db/database_helper.dart';
import 'package:cinta_film/data/datasources/film/movie_local_data_source.dart';
import 'package:cinta_film/data/datasources/film/movie_remote_data_source.dart';
import 'package:cinta_film/domain/repositories/movie_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:cinta_film/domain/usecases/cari_film.dart';
import 'package:cinta_film/domain/usecases/daftar_tonton.dart';
import 'package:cinta_film/domain/usecases/hapus_daftar_tonton.dart';
import 'package:cinta_film/domain/usecases/ambil_daftar_tonton_film.dart';
import 'package:cinta_film/domain/usecases/ambil_status_daftar_tonton.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_rekomendasi.dart';
import 'package:cinta_film/domain/usecases/ambil_data_detail_film.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_rating_terbaik.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_terpopuler.dart';
import 'package:cinta_film/domain/usecases/ambil_data_tayang_saat_ini.dart';
import 'package:cinta_film/presentasi/bloc/film_terpopuler_bloc/movie_popular_bloc.dart';
import 'package:cinta_film/presentasi/bloc/film_saat_ini_tayang_bloc/movie_now_playing_bloc.dart';
import 'package:cinta_film/presentasi/bloc/film_rekomendasi_bloc/movie_recommendation_bloc.dart';
import 'package:cinta_film/presentasi/bloc/film_rating_terbaik_bloc/movie_top_rated_bloc.dart';
import 'package:cinta_film/presentasi/bloc/film_pencarian_bloc/movie_search_bloc.dart';
import 'package:cinta_film/presentasi/bloc/film_detail_bloc/movie_detail_bloc.dart';
import 'package:cinta_film/presentasi/bloc/film_daftar_tonton_bloc/movie_watchlist_bloc.dart';

@GenerateMocks([
  RepositoryFilm,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  ClassDaftarTontonFilm,
  AmbilDataDetailFilm,
  ClassFilmRatingTerbaik,
  AmbilDataRekomendasiFilm,
  ClassFilmTerPopuler,
  ClasFilmTayangSaatIni,
  ClassStatusDaftarTonton,
  ClassCariFilm,
  ClassSimpanDaftarTonton,
  ClassHapusDaftarTonton,
  MoviePopularBloc,
  MovieNowPlayingBloc,
  MovieRecommendationBloc,
  MovieTopRatedBloc,
  MovieSearchBloc,
  DetailFilmBloc,
  DaftarTontonFilmBloc
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
