import 'package:get/get.dart';
import 'dart:convert';
import '../models/http-response.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  static const apiKey = 'c852fd68-fa45-4067-a9ce-11b0cb080c78';
  static const apiUrl = 'https://api.airvisual.com/v2';

  @override
  void onInit() async {
    super.onInit();
    getCountries();
    getStates();
  }

  //Variables, Setters, Getters
  RxList<String> _countries = <String>[''].obs;
  List<String> get countriesList => _countries.value;
  set appendToCountriesList(String value) => _countries.add(value);

  RxList<String> _states = <String>[''].obs;
  List<String> get statesList => _states;
  set appendToStatesList(String value) => _states.add(value);

  RxList<String> _cities = <String>[].obs;
  List<String> get citiesList => _cities;
  set appendToCitiesList(String value) => _cities.add(value);

  RxString _selectedCountry = 'Cyprus'.obs;
  String get selectedCountry => _selectedCountry.value;
  set setSelectedCountry(String value) => _selectedCountry.value = value;

  RxString _selectedState = ''.obs;
  String get selectedState => _selectedState.value;
  set setSelectedState(String value) => _selectedState.value = value;

  Future<void> getCountries() async {
    String url = "$apiUrl/countries?key=$apiKey";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      print('countries could not be retrieved');
      return;
    }
    var responseData = json.decode(response.body);
    var model = HttpResponse.fromJson(responseData);

    _countries.value = [];

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

    _states.value = [];

    for (Map state in model.data) {
      _states.add(state.values.single);
    }

    _selectedState.value = _states.value[0];
  }

  Future<void> getCities() async {
    String url =
        "$apiUrl/cities?state=$selectedState&country=$selectedCountry&key=$apiKey";
    var response = await http.get(Uri.parse(url));

    print(url);
    print(response.body);

    if (response.statusCode != 200) {
      print('countries could not be retrieved');
      return;
    }
    var responseData = json.decode(response.body);
    var model = HttpResponse.fromJson(responseData);

    _cities.value = [];

    for (Map city in model.data) {
      _cities.add(city.values.single);
    }
  }
}
