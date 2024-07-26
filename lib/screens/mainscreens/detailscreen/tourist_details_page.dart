// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cityguide/Admin/comons/models/attractionmodel.dart';
import 'package:cityguide/screens/mainscreens/detailscreen/detailwidget/circular_icon.dart';
import 'package:cityguide/screens/mainscreens/detailscreen/detailwidget/distance.dart';
import 'package:cityguide/screens/mainscreens/homescreen/location.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:cityguide/utils/constants/sizes.dart';
import 'package:cityguide/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class TouristDetailsPage extends StatelessWidget {
  const TouristDetailsPage({
    Key? key,
    required this.attractionModel,
  }) : super(key: key);
  final AttractionModel attractionModel;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            SizedBox(
              height: size.height * 0.38,
              width: double.maxFinite,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(20)),
                      image: DecorationImage(
                        image: NetworkImage(attractionModel.profilePicture),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 0,
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(15)),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            iconSize: 20,
                            icon: const Icon(Ionicons.chevron_back),
                          ),
                          IconButton(
                            iconSize: 20,
                            onPressed: () {},
                            icon: const Icon(Ionicons.heart_outline),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attractionModel.attractionName,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height:  TSizes.xs/2),
                    Text(
                      attractionModel.attractionLocation,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12),
                    )
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: IconButton(
                    onPressed: () {},
                    iconSize: 26,
                    icon: const Icon(Ionicons.chatbubble_ellipses_outline),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      attractionModel.rating.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Icon(
                      Ionicons.star,
                      color: Colors.yellow[800],
                      size: 20,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      attractionModel.attractionOpeningHour,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            color: TColors.primary,
                          ),
                    ),
                    const SizedBox(height: TSizes.xs/2),
                    Text(
                      "Started in",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(TTexts.attractionDescriptionTitle, style: Theme.of(context).textTheme.headlineSmall!),
            const SizedBox(
              height: TSizes.spaceBtwItems/2,
            ),
            Text(attractionModel.attractionDescription, style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: TSizes.spaceBtwItems*2),
            Row(
              children: [
              GestureDetector(
                onTap: ()=>Get.to(locationScreen(lat: double.parse(attractionModel.attractionLat),lng:  double.parse(attractionModel.attractionLong))),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: TColors.primary),
                    borderRadius:
                    BorderRadius.circular(TSizes.sm),
                  ),
                  child: Image.asset(
                  'images/map.png',
                  width: 50,
                    height: 50,
                              ),
                ),
              ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 8.0,
                      ),
                    ),
                    child: const Text("Join this tour"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
