
import 'package:cityguide/Admin/screens/mainscreens/maincontroller/categories_controller.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:cityguide/utils/constants/sizes.dart';
import 'package:cityguide/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TReferralCode extends StatelessWidget {
  const TReferralCode({
    Key? key,
    required this.dark,
  }) : super(key: key);

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoriesController());
    return Form(
      key: controller.categoryFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TextField
              Expanded(
                child: TextFormField(
                  controller: controller.category,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // Auto validate on user interaction
                  validator: (value) =>
                      TValidator.validateEmptyText('Attraction', value),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, // Adjust border color as needed
                        width: 2.0, // Adjust border width as needed
                      ),
                      borderRadius: BorderRadius.circular(TSizes.md), // Adjust border radius as needed
                    ),
                    fillColor: dark ? TColors.dark : TColors.white,
                    hintText: 'Add Attraction Category',
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    suffixIcon: Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(80, 70),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(TSizes.md),
                              // Adjust the value as needed
                              bottomRight: Radius.circular(TSizes.md),
                              // Adjust the value as needed
                            ),
                          ),
                        ),
                        child: Text("Add"),

                        onPressed: () => controller.addCategories(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Validation error message
          Padding(
            padding: const EdgeInsets.only(left: TSizes.md),
            child: Text('',
              style: TextStyle(color: Colors.red),
              // Adjust color as needed
            ),
          ),
        ],
      ),
    );
  }
}
