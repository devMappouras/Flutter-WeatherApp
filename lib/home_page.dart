import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cities/controllers/favourited_cities.dart';
import 'package:cities/controllers/weather_api_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
        ),
        body: _buildHomePage());
  }

  Widget _buildHomePage() {
    WeatherController weatherController = Get.find();
    TextEditingController controller1 = TextEditingController(text: '');
    TextEditingController controller2 = TextEditingController(text: '');

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(() => CustomDropdown.search(
                hintText: 'Select Country',
                items: weatherController.countriesList,
                onChanged: (String? newValue) {
                  weatherController.setSelectedCountry = newValue!;
                  print(weatherController.selectedCountry);
                  weatherController.getStates();
                },
                controller: controller1,
              )),
          Obx(() => CustomDropdown(
                hintText: 'Select State',
                items: weatherController.statesList,
                onChanged: (String? newValue) {
                  weatherController.setSelectedState = newValue!;
                  print(weatherController.selectedState);
                  weatherController.getCities();
                },
                controller: controller2,
              )),
          Obx(() => Container(
                width: 600,
                height: 400,
                alignment: const Alignment(0.0, -0.9),
                child: _buildCitiesList(),
              )),
        ],
      ),
    );
  }

  Widget _buildCitiesList() {
    WeatherController weatherController = Get.find();

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: weatherController.citiesList.length,
      itemBuilder: (context, item) {
        // if (item.isOdd) return Divider();
        // final index = item ~/ 2;
        print(weatherController.citiesList[item]);
        return _buildRow(weatherController.citiesList[item]);
      },
    );
  }

  Widget _buildRow(String city) {
    FavouriteCitiesControllers favouriteCitiesControllers = Get.find();

    final alreadySaved =
        favouriteCitiesControllers.favouriteCities.contains(city);

    return ListTile(
        title: Text(city, style: TextStyle(fontSize: 18.0)),
        trailing: IconButton(
            icon: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border),
            color: alreadySaved ? Colors.red : null,
            onPressed: () => {
                  if (alreadySaved)
                    {
                      favouriteCitiesControllers.removeFromFavouriteCitiesList =
                          city
                    }
                  else
                    {
                      favouriteCitiesControllers.appendToFavouriteCitiesList =
                          city
                    }
                }),
        onTap: () {
          print(city);
          //_viewDetailsScreen(pair.asPascalCase.toString());
        });
  }
}
