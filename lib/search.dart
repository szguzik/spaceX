import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchValue,
                decoration: const InputDecoration(
                  hintText: '',
                  labelText: 'Napisz czego szukasz w kosmosie ?',

                ),
              ),
            ),
            ElevatedButton(
              child: const Text('Szukaj kosmitów'),
              onPressed: () {
                Navigator.pop(context, _searchValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}
