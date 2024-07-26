import 'package:cityguide/Admin/screens/mainscreens/navigatescreens/edit/edit_screen.dart';
import 'package:cityguide/Admin/screens/mainscreens/navigatescreens/home/homeScreen.dart';
import 'package:cityguide/Admin/screens/mainscreens/navigatescreens/upload/upload_screen.dart';
import 'package:cityguide/screens/mainscreens/profile/profilescreen.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:cityguide/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        ()=>NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.black : Colors.white,
          indicatorColor: darkMode ? TColors.white.withOpacity(0.1):TColors.black.withOpacity(0.1),
          destinations: [
            NavigationDestination(
              icon: Icon(Iconsax.home, color: controller.selectedIndex.value == 0 ? TColors.primary : null),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.document_upload, color: controller.selectedIndex.value == 1 ? TColors.primary : null),
              label: 'Upload',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.edit, color: controller.selectedIndex.value == 2 ? TColors.primary : null),
              label: 'Edit',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.user, color: controller.selectedIndex.value == 3 ? TColors.primary : null),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: Obx(()=>controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex =0.obs;
  final screens = [const HomeScreen(), const UploadScreen(), const EditProductScreen(), const profileScreen()];
}