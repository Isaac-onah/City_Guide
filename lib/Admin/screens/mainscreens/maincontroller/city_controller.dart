import 'package:cityguide/Admin/comons/models/citymodel.dart';
import 'package:cityguide/Admin/data/repositories/user/attraction_repository.dart';
import 'package:cityguide/repositories/controllers/countryandcity_controller.dart';
import 'package:flutter/material.dart';
import 'package:cityguide/utils/constants/image_strings.dart';
import 'package:cityguide/utils/helpers/network_manager.dart';
import 'package:cityguide/utils/popups/full_screen_loader.dart';
import 'package:cityguide/utils/popups/loader.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class CityController extends GetxController {
  static CityController get instance => Get.find();

  ///variables;
  Rx<CityModel> citymain = CityModel.empty().obs;
  final categorystatus = false.obs;
  final country = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final imageUploading = false.obs;
  final attractRepository = Get.put(attractionRepository());
  final statecitycontroller = Get.put(CountryStateCityController());
  GlobalKey<FormState> cityFormKey = GlobalKey<FormState>();
  RxBool refreshData = true.obs;
  final searchController = TextEditingController();
  // Observable list of branches
  RxList<CityModel> cities = <CityModel>[].obs;
  RxList<CityModel> filteredBranches = <CityModel>[].obs;
  RxBool isLoading = false.obs; // Observable for loading state


  @override
  void onInit() {
    super.onInit();
  }

  /// Save user Record from any Registration Provider
  Future<void> addCity() async {
    try {
      ///start loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information ...', TImages.decorAnimation);

      ///check internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      ///Form validation
      if (!cityFormKey.currentState!.validate()) {
        //remove Loader
        categorystatus.value = true;
        TFullScreenLoader.stopLoading();
        return;
      }

      ///CHECK IF IMAGE IS EMPTY
      if (citymain.value.cityPicture.isEmpty) {
        //remove Loader
        TFullScreenLoader.stopLoading();

        ///show generic error to user
        TLoaders.errorSnackBar(
            title: 'Oh Snap', message: 'Please select an Image');
        return;
      }

      // Validate dropdowns
      if (country.text == 'Select Country' ||
          country.text.isEmpty ||
          state.text == 'Select State' ||
          state.text.isEmpty ||
          city.text == 'Select City' ||
          city.text.isEmpty) {
        // Remove loader
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
            title: 'Validation Error',
            message: 'Please select valid options for all dropdowns');
        return;
      }
      final cityId = Uuid().v4();

      /// Save Address Data
      final cityDetails = CityModel(
        cityid: cityId,
        cityPicture: citymain.value.cityPicture,
        countryName: country.text.trim(),
        stateName: state.text.trim(),
        cityName: city.text.trim(),
      );

      await attractRepository.addCityItem(cityDetails, cityId);


      //remove Loader
      TFullScreenLoader.stopLoading();

      ///show success Message
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your new City created.');

      ///Refresh category Data
      refreshData.toggle();
      ///update the Rx User value
      citymain.value.cityPicture = '';
      citymain.refresh();
      ///Reset fields
      resetFromFields();
      // Reset dropdown values
      statecitycontroller.selectedCountry.value = 'Select Country';
      statecitycontroller.selectedState.value = 'Select State';
      statecitycontroller.selectedCity.value = 'Select City';
    } catch (e) {
//remove Loader
      TFullScreenLoader.stopLoading();

      ///show generic error to user
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Fetch all user specific addresses
  Future<void> getAllCity() async {
    try {
      isLoading.value = true; // Set loading state to true
      List<CityModel> mainCategories = await attractRepository.fetchCity();
      print(mainCategories.length);
      cities.assignAll(mainCategories);
      filteredBranches.assignAll(mainCategories); // Initialize filtered city
    } catch (e) {
      TLoaders.errorSnackBar(title: 'City not found', message: e.toString());
      cities.clear();
      filteredBranches.clear();
    }finally {
      isLoading.value = false; // Set loading state to false after fetching
    }
  }

  void filterBranches(String searchText) {
    if (searchText.isEmpty) {
      filteredBranches.assignAll(cities);
    } else {
      var filteredList = cities.where((city) =>
          city.cityName.toLowerCase().contains(searchText.toLowerCase()));
      filteredBranches.assignAll(filteredList.toList());
    }
  }

  ///upload City Image
  uploadCityPicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;

        ///upload Image
        final imageUrl = await attractRepository.uploadingImage('City', image);

        ///update User Image Record
        citymain.value.cityPicture = imageUrl;
        TLoaders.successSnackBar(
            title: 'Congratulations',
            message: 'Your City Image has been updated');
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Oh!! Snap', message: 'Something went wrong');
    } finally {
      imageUploading.value = false;
    }
  }

  /// Function to reset form fields
  void resetFromFields() {
    city.clear();
    ///update the Rx User value
    citymain.value.cityPicture = '';
    cityFormKey.currentState?.reset();
  }

  @override
  void onClose() {
    // Clean up resources when the controller is closed
    searchController.dispose();
    super.onClose();
  }
}
