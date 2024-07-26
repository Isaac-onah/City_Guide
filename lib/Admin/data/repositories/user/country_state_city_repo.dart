import 'dart:developer';
import 'package:cityguide/models/cities_model.dart';
import 'package:cityguide/models/country_state_model.dart';
import 'package:http/http.dart' as http;

class CountryStateCityRepo {
  static const countriesStateURL =
      'https://countriesnow.space/api/v0.1/countries/states';
  static const cityURL =
      'https://countriesnow.space/api/v0.1/countries/state/cities/q?country';

  Future<CountryStateModel> getCountriesStates() async {
    try {
      var url = Uri.parse(countriesStateURL);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final CountryStateModel responseModel =
        countryStateModelFromJson(response.body);
        return responseModel;
      } else {
        return CountryStateModel(
            error: true,
            msg: 'Something went wrong: ${response.statusCode}',
            data: []);
      }
    } catch (e) {
      log('Exception: ${e.toString()}');
      throw Exception(e.toString());
    }
  }

  Future<CitiesModel> getCities(
      {required String country, required String state}) async {
    try {
      var url = Uri.parse("$cityURL=$country&state=$state");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final CitiesModel responseModel = citiesModelFromJson(response.body);
        return responseModel;
      } else {
        return CitiesModel(
            error: true,
            msg: 'Something went wrong: ${response.statusCode}',
            data: []);
      }
    } catch (e) {
      log('Exception: ${e.toString()}');
      throw Exception(e.toString());
    }
  }
}