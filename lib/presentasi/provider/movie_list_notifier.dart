import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/usecases/ambil_data_tayang_saat_ini.dart';
import 'package:cinta_film/common/state_enum.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_terpopuler.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_rating_terbaik.dart';
import 'package:flutter/material.dart';

class MovieListNotifier extends ChangeNotifier {
  var _nowPlayingMovies = <Film>[];
  var _popularMovies = <Film>[];
  var _topRatedMovies = <Film>[];

  final ClasFilmTayangSaatIni filmTayangSaatIni;
  final ClassFilmTerPopuler getPopularMovies;
  final ClassFilmRatingTerbaik ambilFilmRatingTerbaik;

  String _message = '';
  String get message => _message;

  List<Film> get nowPlayingMovies => _nowPlayingMovies;
  List<Film> get popularMovies => _popularMovies;
  List<Film> get topRatedMovies => _topRatedMovies;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;
  RequestState _popularMoviesState = RequestState.Empty;
  RequestState get popularMoviesState => _popularMoviesState;
  RequestState _topRatedMoviesState = RequestState.Empty;
  RequestState get topRatedMoviesState => _topRatedMoviesState;

  MovieListNotifier({
    required this.filmTayangSaatIni,
    required this.getPopularMovies,
    required this.ambilFilmRatingTerbaik,
  });

  Future<void> ambilDataFilmTerPopuler() async {
    _popularMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularMovies.execute();
    result.fold(
      (failure) {
        _popularMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _popularMoviesState = RequestState.Loaded;
        _popularMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedMovies() async {
    _topRatedMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await ambilFilmRatingTerbaik.execute();
    result.fold(
      (failure) {
        _topRatedMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _topRatedMoviesState = RequestState.Loaded;
        _topRatedMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchNowPlayingMovies() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();
    final result = await filmTayangSaatIni.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingMovies = moviesData;
        notifyListeners();
      },
    );
  }
}
