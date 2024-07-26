
import 'package:cityguide/repositories/controllers/countryandcity_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final CountryStateCityController controller = Get.put(CountryStateCityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Country State City'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(() {
          return !controller.isDataLoaded.value
              ? const CircularProgressIndicator()
              : Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                DropdownButton(
                  isExpanded: true,
                  value: controller.selectedCountry.value,
                  items: controller.countries
                      .map((String country) => DropdownMenuItem(
                      value: country, child: Text(country)))
                      .toList(),
                  onChanged: (selectedValue) {
                    controller.selectedCountry.value = selectedValue!;
                    if (controller.selectedCountry.value != 'Select Country') {
                      controller.getStates();
                    }
                  },
                ),
                const SizedBox(height: 20),
                DropdownButton(
                  isExpanded: true,
                  value: controller.selectedState.value,
                  items: controller.states
                      .map((String state) => DropdownMenuItem(
                      value: state, child: Text(state)))
                      .toList(),
                  onChanged: (selectedValue) {
                    controller.selectedState.value = selectedValue!;
                    if (controller.selectedState.value != 'Select State') {
                      controller.getCities();
                    }
                  },
                ),
                const SizedBox(height: 20),
                DropdownButton(
                  isExpanded: true,
                  value: controller.selectedCity.value,
                  items: controller.cities
                      .map((String city) => DropdownMenuItem(
                      value: city, child: Text(city)))
                      .toList(),
                  onChanged: (selectedValue) {
                    controller.selectedCity.value = selectedValue!;
                    if (controller.selectedCity.value != 'Select City') {
                      controller.finalTextToBeDisplayed.value =
                      "Country: ${controller.selectedCountry.value}\nState: ${controller.selectedState.value}\nCity: ${controller.selectedCity.value}";
                    }
                  },
                ),
                Text(
                  controller.finalTextToBeDisplayed.value,
                  style: const TextStyle(fontSize: 22),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
