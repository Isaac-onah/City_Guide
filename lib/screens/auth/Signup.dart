import 'package:cityguide/repositories/controllers/signupcontroller.dart';
import 'package:cityguide/screens/auth/LoginScreen.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:cityguide/utils/constants/sizes.dart';
import 'package:cityguide/utils/constants/text_strings.dart';
import 'package:cityguide/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:animated_switch/animated_switch.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Scaffold(
      body: Stack(
        children: [
          const Image(
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              image: AssetImage('images/splashimg.jpg')),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.15),
                      Colors.black.withOpacity(0.5),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter
                )
            ),
          ),
          SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Form(
                  key: controller.signupFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: TSizes.appBarHeight,
                      ),
                      const Text('SignUp',style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,

                      ),),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      ///Email
                      TextFormField(
                        controller: controller.email,
                        validator: (value) => TValidator.validateEmail(value),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: TColors.white.withOpacity(0.5),
                          prefixIcon: Icon(Iconsax.direct_right),
                          labelText: TTexts.email,
                          floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      Row(
                        children: [
                          ///firstName
                          Expanded(
                            child: TextFormField(
                              expands: false,
                              controller: controller.firstName,
                              validator: (value) =>
                                  TValidator.validateEmptyText('First Name', value),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: TColors.white.withOpacity(0.5),
                                prefixIcon: const Icon(Iconsax.user),
                                labelText: TTexts.firstNome,
                                floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwInputFields,
                          ),

                          ///Last Name
                          Expanded(
                            child: TextFormField(
                              expands: false,
                              controller: controller.lastName,
                              validator: (value) => TValidator.validateEmptyText('Last Name', value),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: TColors.white.withOpacity(0.5),
                                prefixIcon: const Icon(Iconsax.user),
                                labelText: TTexts.lastName,
                                floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      ///PhoneNumber
                      TextFormField(
                        controller: controller.phoneNumber,
                        keyboardType: TextInputType.phone,
                        validator: (value) => TValidator.validatePhoneNumber(value),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: TColors.white.withOpacity(0.5),
                          prefixIcon: const Icon(Iconsax.call),
                          labelText: TTexts.phoneNo,
                          floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),

                      ///password
                      Obx (()=>TextFormField(
                        controller: controller.password,
                        obscureText: controller.hidePassword.value,
                        validator: (value) => TValidator.validatePassword(value),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: TColors.white.withOpacity(0.5),
                          prefixIcon: const Icon(Iconsax.password_check),
                          labelText: TTexts.password,
                          floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
                          suffixIcon: IconButton(
                              onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                              icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye)),
                        ),
                      )),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),

                      ///confirm password
                      TextFormField(
                        controller: controller.confirmpassword,
                        obscureText: controller.hidePassword.value,
                        validator: (value) => TValidator.validatePasswordConfirmation(value, controller.password.text),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: TColors.white.withOpacity(0.5),
                          prefixIcon: const Icon(Iconsax.password_check),
                          labelText: TTexts.confirmpassword,
                          floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
                          suffixIcon: const Icon(Iconsax.eye_slash),
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      Row(
                        children: [
                          Obx(
                          ()=> AnimatedSwitch(
                              colorOff: Color(0xffA09F99),
                            value: controller.privacyPolicy.value,
                            onChanged: (value) => controller.privacyPolicy.value = value,

                          ),
                          ),
                          SizedBox(width: 5,),
                          Text('Remember me',style: TextStyle(
                            color: Colors.grey,
                          ),),
                          Spacer(),
                          Text("Forgot Password",style: TextStyle(
                            color: Colors.grey,
                          ),),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      ///Sign In Button
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () => controller.signup(),
                              child: const Text(TTexts.LoginSurTitle))),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                     const Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         Expanded(child: Divider(height: 1,color: TColors.white,)),
                         Padding(
                           padding: EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems/2),
                           child: Text('Or Login With',style: TextStyle(color: Colors.white,),),
                         ),
                         Expanded(child: Divider(height: 1,color: TColors.white,)),
                       ],
                     ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                color: const Color(0xff484848),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: const Icon(Icons.g_mobiledata,color: Colors.white,size: 40,),
                          ),
                          Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                color: const Color(0xff484848),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: const Icon(Icons.apple,color: Colors.white,size: 40,),
                          ),
                          Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                color: const Color(0xff484848),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: const Icon(Icons.facebook,color: Colors.white,size: 40,),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Alredy have an accont?",style: TextStyle(
                            color: Colors.grey,
                          ),),
                          const SizedBox(width: 5,),
                          GestureDetector(
                            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen())),
                            child: const Text("Login",style: TextStyle(///done thhav
                              ///chsdcjsb,BSJnkyoyyuusfhsdfhdfgejfw
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
