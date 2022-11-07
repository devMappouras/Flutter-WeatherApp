import 'package:cities/controllers/favourited_cities.dart';
import 'package:cities/controllers/weather_api_controller.dart';
import 'package:get/get.dart';

class InitDep implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeatherController());
    Get.lazyPut(() => FavouriteCitiesControllers());
  }
}
