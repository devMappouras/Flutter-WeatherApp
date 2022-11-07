import 'package:get/get.dart';

class FavouriteCitiesControllers extends GetxController {
  //Variables, Setters, Getters
  RxList<String> _favouriteCities = <String>[''].obs;
  List<String> get favouriteCities => _favouriteCities.value;
  set appendToFavouriteCitiesList(String value) => _favouriteCities.add(value);
  set removeFromFavouriteCitiesList(String value) =>
      _favouriteCities.remove(value);
}
