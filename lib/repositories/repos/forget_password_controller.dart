import 'package:cityguide/repositories/repos/authentication_repository.dart';
import 'package:cityguide/screens/auth/reset_password.dart';
import 'package:cityguide/utils/constants/image_strings.dart';
import 'package:cityguide/utils/helpers/network_manager.dart';
import 'package:cityguide/utils/popups/full_screen_loader.dart';
import 'package:cityguide/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  ///variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  ///send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      //start Loading
      TFullScreenLoader.openLoadingDialog(
          'Processing your request ....', TImages.decorAnimation);

      //check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Form validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      
      // send Email to reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());
      
      //remove Loader
      TFullScreenLoader.stopLoading();
      
      //show success Screen
      TLoaders.successSnackBar(title: 'Email sent', message: 'Email Link Sent to Reset your Password'.tr);

      //Redirect
      Get.to(()=> ResetPasswordScreen(email: email.text.trim(),));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  ///resend Reset Password Email
  resendPasswordResetEmail(String email) async {
    try {
      //start Loading
      TFullScreenLoader.openLoadingDialog(
          'Processing your request ....', TImages.decorAnimation);

      //check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // send Email to reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      //remove Loader
      TFullScreenLoader.stopLoading();

      //show success Screen
      TLoaders.successSnackBar(title: 'Email sent', message: 'Email Link Sent to Reset your Password'.tr);

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
