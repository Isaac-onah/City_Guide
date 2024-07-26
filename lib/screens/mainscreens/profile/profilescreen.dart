import 'package:cityguide/repositories/controllers/user_controller.dart';
import 'package:cityguide/repositories/repos/authentication_repository.dart';
import 'package:cityguide/screens/mainscreens/profile/edit_screen.dart';
import 'package:cityguide/screens/mainscreens/profile/widgets/circular_image.dart';
import 'package:cityguide/screens/mainscreens/profile/widgets/forward_button.dart';
import 'package:cityguide/screens/mainscreens/profile/widgets/setting_item.dart';
import 'package:cityguide/screens/mainscreens/profile/widgets/setting_switch.dart';
import 'package:cityguide/utils/constants/sizes.dart';
import 'package:cityguide/utils/popups/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';

class profileScreen extends StatelessWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    bool isDarkMode = false;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(221, 249, 247, 1),
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=>Get.back(),
          icon: const Icon(Iconsax.arrow_left,),
        ),
        leadingWidth: 80,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Obx(() {
                      final networkImage =
                          controller.userInfo.value.profilePicture;
                      final image = networkImage.isNotEmpty
                          ? networkImage
                          : "images/user_with_green_bg.png";
                      return controller.imageUploading.value ? const TShimmerEffect(width: 100, height: 100, radius: 100,) : Center(child: TCircularImage(image: image, width:100, height: 100, isNetworkImage:networkImage.isNotEmpty,padding: 0,));
                    }),
                    const SizedBox(width: TSizes.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.userInfo.value.fullName,

                              style: Theme.of(context).textTheme.headlineSmall!
                          ),
                          const SizedBox(height: TSizes.xs),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                    controller.userInfo.value.phoneNumber,
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12)
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: TSizes.xs),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  controller.userInfo.value.email,
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12)
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: TSizes.sm),
                    ForwardButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditAccountScreen(),
                          ),
                        );
                      },
                      iconData: Iconsax.edit,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Language",
                icon: Ionicons.earth,
                bgColor: Colors.orange.shade100,
                iconColor: Colors.orange,
                value: "English",
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Notifications",
                icon: Ionicons.notifications,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SettingSwitch(
                title: "Dark Mode",
                icon: Ionicons.moon,
                bgColor: Colors.purple.shade100,
                iconColor: Colors.purple,
                value: isDarkMode,
                onTap: (value) {
                  // setState(() {
                  //   isDarkMode = value;
                  // });
                },
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Help",
                icon: Ionicons.help,
                bgColor: Colors.red.shade100,
                iconColor: Colors.red,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Logout",
                icon: Ionicons.log_out,
                bgColor: Colors.red.shade100,
                iconColor: Colors.red,
                onTap: ()=>AuthenticationRepository.instance.logout(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
