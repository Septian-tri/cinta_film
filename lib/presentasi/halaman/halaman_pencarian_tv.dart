import 'package:cinta_film/common/state_enum.dart';
import 'package:cinta_film/presentasi/provider/tvls/tvls_search_notifier.dart';
import 'package:cinta_film/presentasi/widgets/tvls_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchTvlsPage extends StatelessWidget {
  static const ROUTE_NAME = '/pencarian-tv';

  @override
  Widget build(BuildContext context) {
    var cari = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menu Pencarian',
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                cari = true;
                Provider.of<TvlsSearchNotifier>(context, listen: false)
                    .cariSerialTv(query);
              },
              decoration: InputDecoration(
                hintText: 'Cari Serial Tv Disini',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            Consumer<TvlsSearchNotifier>(
              builder: (context, data, child) {
                switch (data.state) {
                  case RequestState.Loading:
                     return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
                  case RequestState.Loaded:
                    final result = data.searchTvResult;
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final tv = data.searchTvResult[index];
                          return TvlsCard(tv);
                        },
                        itemCount: result.length,
                      ),
                    );
                  default:
                    if (cari) {
                      cari = false;
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
