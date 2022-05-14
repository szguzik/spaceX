import 'package:app_happy_movies/search.dart';
import 'package:flutter/material.dart';
// klasa do listowania odpowiedzi z api
class ListPage extends StatefulWidget {
  const ListPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  // Początkowa wartość wyszukiwania
  String _aliensList = '';

  void showAliens(aliensResult) {
    // Ustawianie stanu aplikacji
    setState(() {
      _aliensList = aliensResult.text;
    });
  }

  void getAliensFromSpace(String searchAlien) {
    // Budowanie adresu do api 
    String urlNasa = 'https://images-api.nasa.gov/search$searchAlien';

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Idz do wyszukiwarki',
            onPressed: () async {
              // Pytamy czy tak jak my - Ty też szukasz kosmotów :)
              // Oczekiwanie na odpowiedz z klasy SearchPage i przekazanie wartości na zdarzeniu onPressed (emitowanie danych)
              var aliensResult = await Navigator.push(context, MaterialPageRoute(
                // Przekazanie do SearchPage tytulu w formie parametru
                  builder: (context) => const SearchPage(title: 'Szukasz kosmitów ? a może ... :) ')));

              // Ponownie wywołanie funkcji - ale dopiero po await
              showAliens(aliensResult);
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: NetworkImage(
                // Pobieramy obraz z kosmosu :)
                'https://serwer1375189.home.pl/studia/interesujacy-kosmos/bg.jpg'),
          ),
        ),
        child: Column(
          // ustalenie pozycji wyszukiwarki
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(_aliensList),
            ),
          ],
        ),
      ),
    );
  }
}
