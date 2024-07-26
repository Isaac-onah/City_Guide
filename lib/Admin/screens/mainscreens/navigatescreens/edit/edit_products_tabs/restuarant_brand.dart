import 'package:flutter/material.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:cityguide/utils/constants/enums.dart';
import 'package:cityguide/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class TBrandTitleWithVerifiedIcon extends StatelessWidget {
  const TBrandTitleWithVerifiedIcon({super.key, required this.title, this.maxLines = 1, this.textColor, this.iconColor = TColors.primary, this.brandTextSize = TextSizes.small, this.textAlign = TextAlign.center});

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text(title,
          maxLines: maxLines,
          textAlign:textAlign,
        )),
        const SizedBox(
          width: TSizes.xs,
        ),
        Icon(Iconsax.verify5, color: iconColor, size: TSizes.xs,)
      ],
    );
  }
}
