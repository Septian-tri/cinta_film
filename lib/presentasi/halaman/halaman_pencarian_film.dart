import 'package:cinta_film/common/state_enum.dart';
import 'package:cinta_film/presentasi/provider/movie_search_notifier.dart';
import 'package:cinta_film/presentasi/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
    var cari = false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                cari = true;
                Provider.of<MovieSearchNotifier>(context, listen: false)
                    .fetchMovieSearch(query);
              },
              decoration: InputDecoration(
                hintText: 'Cari Film Disini',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            Consumer<MovieSearchNotifier>(
              builder: (context, data, child) {
                switch (data.state) {
                  case RequestState.Loading:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  case RequestState.Loaded:
                    final result = data.searchResult;
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final film = data.searchResult[index];
                          return MovieCard(film);
                        },
                        itemCount: result.length,
                      ),
                    );
                  default:
                    if (cari) {
                      return Center(
                        child: Text(
                          'Upss..Maaf Film Belum Tersedia',
                          style:
                              TextStyle(fontSize: 20, color: Colors.blueAccent),
                        ),
                      );
                    } else {
                      return Center();
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
