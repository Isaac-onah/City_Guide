import 'package:cityguide/Admin/screens/mainscreens/maincontroller/categories_controller.dart';
import 'package:cityguide/Admin/screens/mainscreens/navigatescreens/upload/upload_widget/referalcode.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:cityguide/utils/constants/sizes.dart';
import 'package:cityguide/utils/helpers/cloud_helper_functions.dart';
import 'package:cityguide/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class categoriesScreen extends StatelessWidget {
  const categoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoriesController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
        child: Column(
          children: [
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            TReferralCode(dark: dark),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Expanded(
              child: Obx(
                    () => FutureBuilder(
                  // use to trigger refresh
                  key: Key(controller.refreshData.value.toString()),
                  future: controller.getAllbranchCategories(),
                  builder: (context, snapshot) {
                    /// Helper Function: Handle loader, No Record, or Error Message
                    final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                    if (response != null) return response;

                    final cate = snapshot.data!;
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Number of columns
                        childAspectRatio: 3, // Aspect ratio for the child items
                        crossAxisSpacing: 10, // Horizontal spacing between items
                        mainAxisSpacing: 10, // Vertical spacing between items
                      ),
                      itemCount: cate.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: TColors.grey,
                          ),
                          child:Center(child: Text(cate[index].category)),

                        );
                      },
                    );
                  },
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
