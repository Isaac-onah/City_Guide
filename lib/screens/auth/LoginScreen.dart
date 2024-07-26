import 'package:cityguide/repositories/controllers/logincontroller.dart';
import 'package:cityguide/screens/auth/Signup.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:cityguide/utils/constants/sizes.dart';
import 'package:cityguide/utils/constants/text_strings.dart';
import 'package:cityguide/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logincontroller = Get.put(LoginController());
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
                gradient: LinearGradient(colors: [
              Colors.black,
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.15),
              Colors.black.withOpacity(0.5),
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child:  SingleChildScrollView(
                child: Form(
                  key: logincontroller.loginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                          
                      ///email
                      TextFormField(
                        controller: logincontroller.email,
                        validator: (value) => TValidator.validateEmail(value),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: TColors.white.withOpacity(0.5),
                          prefixIcon: const Icon(Iconsax.direct_right),
                          labelText: TTexts.email,
                          floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                          
                      ///password
                      Obx(
                        () => TextFormField(
                          controller: logincontroller.password,
                          obscureText: logincontroller.hidePassword.value,
                          validator: (value) =>
                              TValidator.validateEmptyText('Password', value),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: TColors.white.withOpacity(0.5),
                            prefixIcon: const Icon(Iconsax.password_check),
                            labelText: TTexts.password,
                            floatingLabelStyle:
                                Theme.of(context).textTheme.bodyMedium,
                            suffixIcon: IconButton(
                                onPressed: () => logincontroller.hidePassword.value =
                                    !logincontroller.hidePassword.value,
                                icon: Icon(logincontroller.hidePassword.value
                                    ? Iconsax.eye_slash
                                    : Iconsax.eye)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields / 2,
                      ),
                          
                      /// Remember Me and Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///Remember Me
                          Row(
                            children: [
                              Obx(() => Checkbox(
                                activeColor: TColors.primary,
                                  value: logincontroller.rememberMe.value,
                                  onChanged: (value) => logincontroller.rememberMe
                                      .value = !logincontroller.rememberMe.value)),
                              Text(TTexts.rememberMe, style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: TColors.primary),),
                            ],
                          ),
                          
                          /// Forgot Password
                          // TextButton(onPressed: ()=>Get.to(()=> const ForgotPassword()), child: const Text(TTexts.forgetPassword)),
                          TextButton(
                              onPressed: () {
                          
                              },
                              child: Text(TTexts.forgetPassword, style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: TColors.primary),)),
                        ],
                      ),
                          
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                          
                      ///Sign In Button
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                  logincontroller.emailAndPasswordSignIn();},
                              child: const Text(
                                TTexts.signIn,
                              ))),
                          
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
                                borderRadius: BorderRadius.circular(5)),
                            child: const Icon(
                              Icons.g_mobiledata,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                color: const Color(0xff484848),
                                borderRadius: BorderRadius.circular(5)),
                            child: const Icon(
                              Icons.apple,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                color: const Color(0xff484848),
                                borderRadius: BorderRadius.circular(5)),
                            child: const Icon(
                              Icons.facebook,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?  ", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: TColors.grey),
                          ),
                          GestureDetector(
                            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const Signup())),
                            child: Text(
                              "Signup"
                                , style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: TColors.primary),
                            ),
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
