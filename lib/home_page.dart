import 'package:cities/models/country.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './models/http-response.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var _countries = <String>[];
  var _cities = Set<String>();
  String selectedCountry = 'Cyprus';

  //GET Request
  getCountries() async {
    String url =
        "https://api.airvisual.com/v2/countries?key=c852fd68-fa45-4067-a9ce-11b0cb080c78";
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

  Widget _buildHomePage() {
    getCountries();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DropdownButton(
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
              });
            },
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: _buildHomePage());
  }
}
