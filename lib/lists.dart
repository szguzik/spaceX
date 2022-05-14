import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:app_happy_movies/search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Spaceelement{ //modal class for Person object
  String title, url;
  Spaceelement({required this.url, required this.title});
}

// klasa do listowania odpowiedzi z api
class ListPage extends StatefulWidget {
  const ListPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final List<Spaceelement> data = [];

  // Początkowa wartość wyszukiwania
  String _aliensList = '';

  void showAliens(aliensResult) {
    // getAliensFromSpace(aliensResult);
    // Ustawianie stanu aplikacji

    if (aliensResult != null) {
      setState(() {
        _aliensList = aliensResult.text;
        getAliensFromSpace(aliensResult.text);
      });
    }

  }

  void getAliensFromSpace(searchAlien) async {
    // Budowanie adresu do api
    var urlNasa = 'https://images-api.nasa.gov/search?q=$searchAlien';
    var url = Uri.parse(urlNasa);
    // Zapytanie za pomocą metody get
    var response = await http.get(url);
    // status zapytania
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var collectionLinks = jsonResponse['collection']['items'];

      setState(() {
        data.clear();
        for (var item in collectionLinks) {
          if (item['data'][0]['media_type'] == 'image') {
            var LinkHref = item['links'][0]['href'];
            var LinkTitle = item['data'][0]['title'];
            data.add(Spaceelement(title: LinkTitle, url: LinkHref));
          }
        }
      });

    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
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
              var aliensResult = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      // Przekazanie do SearchPage tytulu w formie parametru
                      builder: (context) => const SearchPage(
                          title: 'Szukasz kosmitów ? a może ... :) ')));

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
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 400),
                height: 300,
              ),
              items: data.map((item) {
                return GridTile(
                  footer: Container(
                      padding: const EdgeInsets.all(15),
                      color: Colors.black54,
                      child: Text(
                        item.title,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.right,
                      )),
                  child: Image.network(item.url, fit: BoxFit.cover),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            Text(_aliensList == '' ? '' : 'Wyszukiwana fraza to: $_aliensList',
              style: const TextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
