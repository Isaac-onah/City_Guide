import 'package:flutter/material.dart';
import 'package:cityguide/utils/constants/image_strings.dart';
import 'package:cityguide/utils/constants/sizes.dart';
import 'package:cityguide/utils/helpers/helper_functions.dart';
import 'package:cityguide/utils/constants/color.dart';

class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key, required this.image, required this.title, this.textColors = TColors.white, this.backgroundColor = TColors.white, this.onTap,
  });

  final String image, title;
  final Color textColors;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
          children: [
            ///circular icon
            Container(
              width: 56,
              height: 56,
              padding: EdgeInsets.all(TSizes.sm),
              decoration: BoxDecoration(
                  color: backgroundColor ?? (dark? TColors.black:TColors.white),
                  borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ///Text
            const SizedBox(height: TSizes.spaceBtwItems/4,),
            SizedBox(
              width: 55,
              child: Center(child: Text(title, style: Theme.of(context).textTheme.labelMedium!.apply(color: dark? TColors.white:TColors.black),maxLines: 2, overflow: TextOverflow.ellipsis,)),
            )
          ],
        ),
      ),
    );
  }
}