import 'package:cityguide/repositories/controllers/verify_email_controller.dart';
import 'package:cityguide/repositories/repos/authentication_repository.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:cityguide/utils/constants/image_strings.dart';
import 'package:cityguide/utils/constants/sizes.dart';
import 'package:cityguide/utils/constants/text_strings.dart';
import 'package:cityguide/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key,  this.email});
final String? email;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: ()=> AuthenticationRepository.instance.logout(), icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        //padding to give default equal space on all sides in all screens
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            ///image
            Lottie.asset(TImages.emailverify, width: MediaQuery.of(context).size.width * 0.8),
            const SizedBox(height: TSizes.spaceBtwSections,),
            ///Title and subtitle
            Text(TTexts.confirmEmail, style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
            const SizedBox(height: TSizes.spaceBtwItems,),
            Text(email ?? '', style: Theme.of(context).textTheme.labelLarge,textAlign: TextAlign.center,),
            const SizedBox(height: TSizes.spaceBtwItems,),
            Text(TTexts.confirmEmailSubTitle, style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
            const SizedBox(height: TSizes.spaceBtwSections,),

            ///buttons
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: ()=>controller.checkEmailVerificationStatus(), child: const Text(TTexts.tContinue))),
            const SizedBox(height: TSizes.spaceBtwItems,),
            SizedBox(
                width: double.infinity,
                child: TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(TColors.primary.withOpacity(0.5)), // Change the splash color here
                    ),
                    onPressed: ()=>controller.sendEmailVerification(), child: const Text(TTexts.resendEmail, style: TextStyle(color:TColors.primary, fontWeight: FontWeight.w600),))),

          ],
        ),
        ),
      ),
    );
  }
}
