import 'package:cityguide/Admin/comons/widgets/appbar/appbar.dart';
import 'package:cityguide/Admin/comons/widgets/loaders/shimmer.dart';
import 'package:cityguide/repositories/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:cityguide/utils/constants/text_strings.dart';
import 'package:get/get.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TTexts.homeAppbarTitle,
              style: Theme.of(context).textTheme.labelMedium!),
          Obx(() {
            if (controller.profileLoading.value) {
              //Display a shimmer loader while user profile is beign loaded
              return const TShimmerEffect(width: 80, height: 15);
            }else {
            return Text('Isaac Onah',
                style: Theme.of(context).textTheme.headlineSmall!);}
          }),
        ],
      ),
    );
  }
}
