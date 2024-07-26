import 'package:cityguide/Admin/data/repositories/user/country_state_city_repo.dart';
import 'package:cityguide/models/cities_model.dart';
import 'package:cityguide/models/country_state_model.dart' as cs_model;
import 'package:get/get.dart';

class CountryStateCityController extends GetxController {
  final CountryStateCityRepo _countryStateCityRepo = CountryStateCityRepo();

  var countries = <String>[].obs;
  var states = <String>[].obs;
  var cities = <String>[].obs;

  var countryStateModel = cs_model.CountryStateModel(error: false, msg: '', data: []).obs;
  var citiesModel = CitiesModel(error: false, msg: '', data: []).obs;

  var selectedCountry = 'Select Country'.obs;
  var selectedState = 'Select State'.obs;
  var selectedCity = 'Select City'.obs;
  var isDataLoaded = false.obs;

  var finalTextToBeDisplayed = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getCountries();
  }

  void getCountries() async {
    countryStateModel.value = await _countryStateCityRepo.getCountriesStates();
    countries.add('Select Country');
    states.add('Select State');
    cities.add('Select City');
    for (var element in countryStateModel.value.data) {
      countries.add(element.name);
    }
    isDataLoaded.value = true;
  }

  void getStates() {
    for (var element in countryStateModel.value.data) {
      if (selectedCountry.value == element.name) {
        resetStates();
        resetCities();
        for (var state in element.states) {
          states.add(state.name);
        }
      }
    }
  }

  void getCities() async {
    isDataLoaded.value = false;
    citiesModel.value = await _countryStateCityRepo.getCities(
      country: selectedCountry.value,
      state: selectedState.value,
    );
    resetCities();
    for (var city in citiesModel.value.data) {
      cities.add(city);
    }
    isDataLoaded.value = true;
  }

  void resetCities() {
    cities.clear();
    cities.add('Select City');
    selectedCity.value = 'Select City';
    finalTextToBeDisplayed.value = '';
  }

  void resetStates() {
    states.clear();
    states.add('Select State');
    selectedState.value = 'Select State';
    finalTextToBeDisplayed.value = '';
  }
}
