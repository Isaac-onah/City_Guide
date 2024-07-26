import 'package:cityguide/repositories/controllers/update_details_controller.dart';
import 'package:cityguide/repositories/controllers/user_controller.dart';
import 'package:cityguide/screens/mainscreens/profile/widgets/circular_image.dart';
import 'package:cityguide/screens/mainscreens/profile/widgets/edit_item.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:cityguide/utils/constants/image_strings.dart';
import 'package:cityguide/utils/constants/sizes.dart';
import 'package:cityguide/utils/constants/text_strings.dart';
import 'package:cityguide/utils/popups/shimmer.dart';
import 'package:cityguide/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  String gender = "man";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    final updatecontroller = Get.put(UpdateDetailsController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "Photo",
                widget: Column(
                  children: [
                    Obx(() {
                      final networkImage =
                          controller.userInfo.value.profilePicture;
                      final image = networkImage.isNotEmpty
                          ? networkImage
                          : "images/user.png";
                      return controller.imageUploading.value ? const TShimmerEffect(width: 120, height: 120, radius: 100,) : Center(child: TCircularImage(image: image, width:120, height: 120, isNetworkImage:networkImage.isNotEmpty));
                    }),
                    TextButton(
                      onPressed: ()=> controller.uploadUserProfilePicture(),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.lightBlueAccent,
                      ),
                      child: const Text("Upload Image", style: TextStyle(color:TColors.primary, fontWeight: FontWeight.w600),),
                    )
                  ],
                ),
              ),
              Form(
                key: updatecontroller.updateUserDetailsFormKey,
                child: Column(
                  children: [
                    const SizedBox(height: TSizes.spaceBtwInputFields,),
                    /// First NAME
                    TextFormField(
                      controller: updatecontroller.firstName,
                      validator: (value) => TValidator.validateEmptyText('First Name',value),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.user),
                        labelText: TTexts.firstNome,
                        floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields,),
                    /// Last Name
                    TextFormField(
                      controller: updatecontroller.lastName,
                      validator: (value) => TValidator.validateEmptyText('Last Name',value),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.user),
                        labelText: TTexts.lastName,
                        floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields,),
                    ///Phone Number
                    TextFormField(
                      controller: updatecontroller.phoneNumber,
                      keyboardType: TextInputType.phone,
                      validator: (value) => TValidator.validatePhoneNumber(value),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.call),
                        labelText: TTexts.phoneNo,
                        floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),

                    const SizedBox(height: TSizes.spaceBtwSections,),
                    ///Sign In Button
                    SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=>updatecontroller.updateUserDetails(), child: const Text(TTexts.updateProfile,))),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
