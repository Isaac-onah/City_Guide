import 'dart:async';

import 'package:cityguide/repositories/repos/authentication_repository.dart';
import 'package:cityguide/utils/constants/image_strings.dart';
import 'package:cityguide/utils/constants/text_strings.dart';
import 'package:cityguide/utils/popups/loader.dart';
import 'package:cityguide/utils/popups/success_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class VerifyEmailController extends GetxController{
  static VerifyEmailController get instance => Get.find();

  ///send Email whenever Verify Screen appears abd set timer for auto redirect.
 @override
  void onInit(){
   sendEmailVerification();
   super.onInit();
 }

 ///send Email Verification link
 sendEmailVerification() async {
  try{
   await AuthenticationRepository.instance.sendEmailVerification();
   TLoaders.successSnackBar(title: 'Email Sent', message: 'Please Check your inbox and verify your email.');
  }catch(e){
   TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
  }
 }

 ///Timer to automatically redirect on Email Vrification
 setTimerForAutoRedirect(){
  Timer.periodic(const Duration(seconds: 1), (timer) async{
   final user = FirebaseAuth.instance.currentUser;
   user!.reload();
   if(user!.emailVerified){
    timer.cancel();
    Get.off(()=>SuccessScreen(image: TImages.successfullyRegisterAnimation, title: TTexts.yourAccountCreated, subTitle: TTexts.yourAccountCreadtedSubTitle, onPressed: ()=>AuthenticationRepository.instance.screenRedirect()));
   }
  });
 }
 
 
 ///manually check if email verified
 checkEmailVerificationStatus() async{
  final currentUser = FirebaseAuth.instance.currentUser;
  print(currentUser);
  currentUser!.reload();
  if(currentUser != null && currentUser.emailVerified){
   Get.off(()=>SuccessScreen(image: TImages.successfullyRegisterAnimation, title: TTexts.yourAccountCreated, subTitle: TTexts.yourAccountCreadtedSubTitle, onPressed: ()=>AuthenticationRepository.instance.screenRedirect()));
  }
}
}