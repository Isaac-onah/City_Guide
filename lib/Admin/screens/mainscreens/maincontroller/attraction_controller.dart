import 'package:cityguide/Admin/comons/models/attractionmodel.dart';
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

class attractionController extends GetxController {
  static attractionController get instance => Get.find();

  ///variables

  Rx<AttractionModel> attractionmain = AttractionModel.empty().obs;
  final cityname = TextEditingController();
  final attractionName = TextEditingController();
  final attractionLocation = TextEditingController();
  final attractionLong = TextEditingController();
  final attractionLat = TextEditingController();
  final attractionWeb = TextEditingController();
  final attractionNumber = TextEditingController();
  final attractionAddress = TextEditingController();
  final attractionCountry = TextEditingController();
  final attractionState = TextEditingController();
  final attractionCity = TextEditingController();
  final category = TextEditingController();
  final rate = TextEditingController();
  final attractionDescription = TextEditingController();
  final attractionOpeningHour = TextEditingController();
  final imageUploading = false.obs;
  final entered = false.obs;
  RxBool isLoading = false.obs;
  final statecitycontroller = Get.put(CountryStateCityController());
  final attractRepository = Get.put(attractionRepository());
  GlobalKey<FormState> addCityFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> addAttractionFormKey = GlobalKey<FormState>();
  RxBool refreshData = true.obs;
  final searchController = TextEditingController();
  RxList<AttractionModel> attractionsgotten = <AttractionModel>[].obs;
  RxList<AttractionModel> filteredattractions = <AttractionModel>[].obs;

  var selectedCategory = ''.obs;
  var selectedRating = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAttractions();
  }


  /// Save user Record from any Registration Provider
  Future<void> addAttraction() async {
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

      // Validate dropdowns
      if (attractionCountry.text == 'Select Country' ||
          attractionCountry.text.isEmpty ||
          attractionState.text == 'Select State' ||
          attractionState.text.isEmpty ||
          attractionCity.text == 'Select City' ||
          attractionCity.text.isEmpty) {
        // Remove loader
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
            title: 'Validation Error',
            message: 'Please select valid options for all dropdowns');
        return;
      }

      ///CHECK IF IMAGE IS EMPTY
      if (attractionmain.value.profilePicture.isEmpty) {
        //remove Loader
        TFullScreenLoader.stopLoading();

        ///show generic error to user
        TLoaders.errorSnackBar(
            title: 'Oh Snap', message: 'Please select an Image');
        return;
      }

      ///Form validation
      if (!addAttractionFormKey.currentState!.validate()) {
        //remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      final attractId = Uuid().v4();

      /// Post attraction
      final attractionDetails = AttractionModel(
        attractionId: attractId,
        profilePicture: attractionmain.value.profilePicture,
        attractionName: attractionName.text,
        attractionLocation: attractionLocation.text,
        attractionLong: attractionLong.text,
        attractionLat: attractionLat.text,
        attractionWeb: attractionWeb.text,
        attractionNumber: attractionNumber.text,
        attractionAddress: attractionAddress.text,
        attractionCountry: attractionCountry.text,
        attractionState: attractionState.text,
        attractionCity: attractionCity.text,
        category: category.text,
        rating: double.parse(rate.text),
        attractionDescription: attractionDescription.text,
        attractionOpeningHour: attractionOpeningHour.text,
        available: false,
      );

      await attractRepository.addAttractionItem(attractionDetails, attractId);

      ///update the Rx User value
      attractionmain.value.profilePicture = '';

      ///remove Loader
      TFullScreenLoader.stopLoading();

      ///show success Message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your new attraction has been uploaded.');

      ///Refresh Address Data
      refreshData.toggle();
      ///update the Rx User value
      attractionmain.value.profilePicture = '';
      attractionmain.refresh();
      ///Reset fields
      resetFromFields();
      // Reset dropdown values
      statecitycontroller.selectedCountry.value = 'Select Country';
      statecitycontroller.selectedState.value = 'Select State';
      statecitycontroller.selectedCity.value = 'Select City';

      ///Reset fields
      resetFromFields();
    } catch (e) {
//remove Loader
      TFullScreenLoader.stopLoading();
      print('object');

      ///show generic error to user
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
  void fetchAttractions() async {
    isLoading(true);
    try {
      var result = await attractRepository.fetchAttractionList(true, 'Enugu');
      if (result != null) {
        attractionsgotten.assignAll(result);
        filteredattractions.assignAll(result);
      }
    } finally {
      isLoading(false);
    }
  }


  void filterByRating(int rating) {
    filteredattractions.assignAll(attractionsgotten.where((attraction) {
      return attraction.rating == rating;
    }).toList());
  }
  void filterByCategory(String category) {
    filteredattractions.assignAll(attractionsgotten.where((attraction) {
      return attraction.category == category;
    }).toList());
  }
  /// Fetch all user specific addresses
  Future<void> getAllAttractionsList(bool available, String stateName) async {
    print(stateName);
    try {
      isLoading.value = true; // Set loading state to true
      List<AttractionModel> allCityAttraction = await attractRepository.fetchAttractionList(available, stateName);
      attractionsgotten.assignAll(allCityAttraction);
      filteredattractions.assignAll(allCityAttraction);

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Attraction not found', message: e.toString());
      attractionsgotten.clear();
      filteredattractions.clear();
    }finally {
      isLoading.value = false; // Set loading state to false after fetching
    }
  }


  void filterAttraction(String searchText) {
    if (searchText.isEmpty) {
      filteredattractions.assignAll(attractionsgotten);
    } else {
      var filteredList = attractionsgotten.where((attractions) =>
          attractions.attractionName.toLowerCase().contains(searchText.toLowerCase()));
      filteredattractions.assignAll(filteredList.toList());
    }
  }

  void filterAttractioncategory(String searchText) {
    if (searchText.isEmpty || searchText == 'All') {

      filteredattractions.assignAll(attractionsgotten);
    } else {

      var filteredList = attractionsgotten.where((attractions) =>
          attractions.category.toLowerCase().contains(searchText.toLowerCase()));
      filteredattractions.assignAll(filteredList.toList());
    }
  }
  void setCategory(String category) {
    selectedCategory.value = category;
    filterAttractioncategory(selectedCategory.value);
  }

  void setRating(double rating) {
    selectedRating.value = rating;
    filterAttraction(searchController.text);
  }
  ///upload Profile Image
  uploadAttractionPicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;

        ///upload Image
        final imageUrl =
            await attractRepository.uploadingImage('Branch/Product/Attraction', image);

        ///update User Image Record
        attractionmain.value.profilePicture = imageUrl;
        TLoaders.successSnackBar(
            title: 'Congratulations',
            message: 'Your Profile Image has been updated');
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Oh!! Snap', message: 'Something went wrong');
    } finally {
      imageUploading.value = false;
    }
  }

  /// Fetch all user specific addresses
  Future<List<AttractionModel>> getAllAttractions(bool available) async {
    try {
      final allattractions = await attractRepository.fetchAttraction(available);
      return allattractions;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Attraction not found', message: e.toString());
      return [];
    }
  }


  Future<void> updateAttractionAvailability(String AttractionId, bool available) async {
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

      /// Update user's infomation in the Firebase
      Map<String, dynamic> details = {
        'Available': available,
      };
      await attractRepository.updateSingleField(details, AttractionId);

      //remove Loader
      TFullScreenLoader.stopLoading();

      ///show success Message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Attraction Details has been updated.');
    } catch (e) {
//remove Loader
      TFullScreenLoader.stopLoading();

      ///show generic error to user
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<void> deleteattraction(String attractionId) async {
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

      /// Update attraction's infomation in the Firebase
      await attractRepository.deleteattraction(attractionId);

      //remove Loader
      TFullScreenLoader.stopLoading();

      ///show success Message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your attraction has been deleted successfully.');

      ///Refresh Address Data
      refreshData.toggle();
    } catch (e) {
//remove Loader
      TFullScreenLoader.stopLoading();

      ///show generic error to user
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Function to reset form fields
  void resetFromFields() {
    cityname.clear();
    attractionName.clear();
    attractionLocation.clear();
    attractionLong.clear();
    attractionLat.clear();
    attractionWeb.clear();
    attractionNumber.clear();
    attractionAddress.clear();
    attractionState.clear();
    attractionCity.clear();
    attractionDescription.clear();
    attractionOpeningHour.clear();
    entered.value = false;
  }
}
