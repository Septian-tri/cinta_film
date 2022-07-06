import 'package:cinta_film/common/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinta_film/presentasi/widgets/movie_card_list.dart';
import 'package:cinta_film/presentasi/bloc/film_daftar_tonton_bloc/movie_watchlist_bloc.dart';
import 'package:flutter/material.dart';

class ClassHalamanDaftarTontonFilm extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-film';

  @override
  _ClassHalamanDaftarTontonFilmState createState() =>
      _ClassHalamanDaftarTontonFilmState();
}

class _ClassHalamanDaftarTontonFilmState
    extends State<ClassHalamanDaftarTontonFilm> with RouteAware {
  @override
  void initState() {
    super.initState();
     Future.microtask(() {
      context.read<DaftarTontonFilmBloc>().add(GetListEvent());
    });
  }

  void didPopNext() {
   context.read<DaftarTontonFilmBloc>().add(GetListEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tonton'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<DaftarTontonFilmBloc, StateDaftarTontonFilm>(
          builder: (context, data) {
           if(data is MovieWatchlistLoading) {
                 return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
              } else if (data is MovieWatchlistLoaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final film = data.result[index];
                    return MovieCard(film);
                  },
                  itemCount: data.result.length,
                );
              } else {
                return Center(
                  key: Key('error_message'),
                  child: Text("Failed"),
                );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
