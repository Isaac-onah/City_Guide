
import 'package:cityguide/Admin/data/repositories/user/attraction_repository.dart';
import 'package:cityguide/models/cities_model.dart';
import 'package:cityguide/utils/constants/image_strings.dart';
import 'package:cityguide/utils/helpers/network_manager.dart';
import 'package:cityguide/utils/popups/full_screen_loader.dart';
import 'package:cityguide/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  static CategoriesController get instance => Get.find();

  ///variables;
  final categorystatus = false.obs;
  final category = TextEditingController();
  GlobalKey<FormState> categoryFormKey = GlobalKey<FormState>();

  final attractRepository = Get.put(attractionRepository());
  RxBool refreshData = true.obs;

  @override
  void onInit() {
    super.onInit();
  }



  /// Save user Record from any Registration Provider
  Future<void> addCategories() async {
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
      if (!categoryFormKey.currentState!.validate()) {
        //remove Loader
        categorystatus.value = true;
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Save Address Data
      final addedcategory = CategoryModel(
        id: '',
        category: category.text.trim(),
      );
      /// Add new category in the branch
      final id = await attractRepository.addcategory(addedcategory);


      //remove Loader
      TFullScreenLoader.stopLoading();

      ///show success Message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your new Category created.');

      ///Refresh category Data
      refreshData.toggle();

      ///Reset fields
      resetFromFields();

    } catch (e) {
//remove Loader
      TFullScreenLoader.stopLoading();

      ///show generic error to user
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Fetch all user specific addresses
  Future<List<CategoryModel>> getAllbranchCategories() async {
    try {
      final mainCategories = await attractRepository.fetchAllCategories();

      return mainCategories;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }
  /// Function to reset form fields
  void resetFromFields(){
    category.clear();
    categoryFormKey.currentState?.reset();
  }
}
