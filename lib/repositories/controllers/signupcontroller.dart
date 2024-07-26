import 'package:cityguide/models/usermodel.dart';
import 'package:cityguide/repositories/repos/authentication_repository.dart';
import 'package:cityguide/repositories/repos/user_repository.dart';
import 'package:cityguide/screens/auth/verify_email.dart';
import 'package:cityguide/utils/constants/image_strings.dart';
import 'package:cityguide/utils/helpers/network_manager.dart';
import 'package:cityguide/utils/popups/full_screen_loader.dart';
import 'package:cityguide/utils/popups/loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // Register Users
  Future<void> signup() async {
    print(privacyPolicy.value);
    TFullScreenLoader.openLoadingDialog(
        'We are processing your information ...', TImages.decorAnimation);

    try {
      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'No Internet Connection',
            message: 'Please check your internet connection and try again.');
        return;
      }

      // Form validation
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Email is in the correct format, check if email already exists
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('Email', isEqualTo: email.text.trim())
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'Email Already Exists',
            message: 'An account has been created with this email. Please try registering with another email.');
        return;
      }

      // Register users in Firebase Authentication and save user data in Firestore
      final userCredentials = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
          email.text.trim(), password.text.trim());

      // Save authenticated user data in Firestore
      final newUser = UserModel(
          id: userCredentials.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          wallet: 0.0,
          profilePicture: '');

      // Save user record
      final userRepository = Get.put(UserRepository());
      userRepository.saveUserRecord(newUser);

      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! Verify email to continue.');

      // Move to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
