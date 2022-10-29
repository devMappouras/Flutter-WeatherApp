import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var _countries = <String>[];
  var _cities = Set<String>();
  var selectedCountry = '';

  // Widget _buildList() {
  //   return ListView.builder(
  //     padding: const EdgeInsets.all(16.0),
  //     itemBuilder: (context, item) {
  //       if (item.isOdd) return Divider();

  //       final index = item ~/ 2;
  //       return _buildRow(_countries[index]);
  //     },
  //   );
  // }

  Widget _buildHomePage() {
    return Center(
      child: Container(
        alignment: const Alignment(0.0, -0.9),
        child: DropdownButton<String>(
          value: selectedCountry,
          //elevation: 5,
          style: TextStyle(color: Colors.black),
          items: <String>[
            'Android',
            'IOS',
            'Flutter',
            'Node',
            'Java',
            'Python',
            'PHP',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          hint: const Text(
            "Please choose a langauage",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          onChanged: (String? value) {
            setState(() {
              selectedCountry = value ?? '';
            });
          },
        ),
      ),
    );
  }

  // Widget _buildRow(WordPair pair) {
  //   final alreadySaved = _savedWordPairs.contains(pair);

  //   return ListTile(
  //       title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18.0)),
  //       trailing: IconButton(
  //         icon: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border),
  //         color: alreadySaved ? Colors.red : null,
  //         onPressed: () => {
  //           setState(() {
  //             if (alreadySaved) {
  //               _savedWordPairs.remove(pair);
  //             } else {
  //               _savedWordPairs.add(pair);
  //             }
  //           })
  //         },
  //       ),
  //       onTap: () {
  //         _viewDetailsScreen(pair.asPascalCase.toString());
  //       });
  // }

  // void _viewFavouritesScreen() {
  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (BuildContext context) {
  //     final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
  //       return ListTile(
  //           title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16.0)));
  //     });

  //     final List<Widget> divided =
  //         ListTile.divideTiles(context: context, tiles: tiles).toList();

  //     return Scaffold(
  //         appBar: AppBar(title: Text('Saved WordPairs')),
  //         body: ListView(children: divided));
  //   }));
  // }

  // void _viewDetailsScreen(String wordPair) {
  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (BuildContext context) {
  //     return Scaffold(
  //       appBar: AppBar(title: Text('$wordPair Details')),
  //       body: Center(
  //         child: Container(
  //           alignment: const Alignment(0.0, -0.9),
  //           child: Text(wordPair, style: TextStyle(fontSize: 35.0)),
  //         ),
  //       ),
  //     );
  //   }));
  // }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('WordPair Generator'),
          actions: <Widget>[
            //IconButton(icon: Icon(Icons.list), onPressed: _viewFavouritesScreen)
          ],
        ),
        body: _buildHomePage());
  }
}
