import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './models/http-response.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  static const apiKey = 'c852fd68-fa45-4067-a9ce-11b0cb080c78';
  static const apiUrl = 'https://api.airvisual.com/v2';
  var _countries = <String>[];
  var _states = <String>[];
  var _cities = <String>[];
  var _savedCities = <String>[];
  String selectedCountry = 'Cyprus';
  String selectedState = '';

  @override
  void initState() {
    getCountries();
    super.initState();
  }

  //HTTP GET Requests
  //TODO: Move HTTP requests to new service file
  Future<void> getCountries() async {
    String url = "$apiUrl/countries?key=$apiKey";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      print('countries could not be retrieved');
      return;
    }
    var responseData = json.decode(response.body);
    var model = HttpResponse.fromJson(responseData);

    _countries = [];

    for (Map country in model.data) {
      _countries.add(country.values.single);
    }
  }

  Future<void> getStates() async {
    String url = "$apiUrl/states?country=$selectedCountry&key=$apiKey";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      print('states could not be retrieved for the country $selectedCountry');
      return;
    }
    var responseData = json.decode(response.body);
    var model = HttpResponse.fromJson(responseData);

    _states = [];

    for (Map state in model.data) {
      _states.add(state.values.single);
    }

    selectedState = _states[0];
  }

  getCities() async {
    String url =
        "$apiUrl/cities?state=$selectedState&country=$selectedCountry&key=$apiKey";
    var response = await http.get(Uri.parse(url));

    print(response.body);

    if (response.statusCode != 200) {
      print('countries could not be retrieved');
      return;
    }
    var responseData = json.decode(response.body);
    var model = HttpResponse.fromJson(responseData);

    _cities = [];

    for (Map city in model.data) {
      _cities.add(city.values.single);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: _buildHomePage());
  }

  Widget _buildHomePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder(
              future: getCountries(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  return DropdownButton(
                    value: selectedCountry,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: _countries.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCountry = newValue!;
                        getStates();
                      });
                    },
                  );
                }
              }),
          FutureBuilder(
            future: getStates(),
            builder: (context, snapshot) {
              return DropdownButton(
                value: selectedState,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: _states.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      selectedState = newValue!;
                      getCities();
                    },
                  );
                },
              );
            },
          ),
          if (selectedState != '')
            Container(
              width: 600,
              height: 400,
              alignment: const Alignment(0.0, -0.9),
              child: _buildCitiesList(),
            ),
        ],
      ),
    );
  }

  Widget _buildCitiesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item) {
        if (item.isOdd) return Divider();
        final index = item ~/ 2;
        return _buildRow(_cities[index]);
      },
    );
  }

  Widget _buildRow(String city) {
    final alreadySaved = _savedCities.contains(city);

    return ListTile(
        title: Text(city, style: TextStyle(fontSize: 18.0)),
        trailing: IconButton(
          icon: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border),
          color: alreadySaved ? Colors.red : null,
          onPressed: () => {
            setState(() {
              if (alreadySaved) {
                _savedCities.remove(city);
              } else {
                _savedCities.add(city);
              }
            })
          },
        ),
        onTap: () {
          print(city);
          //_viewDetailsScreen(pair.asPascalCase.toString());
        });
  }
}
