import 'package:cityguide/Admin/comons/models/attractionmodel.dart';
import 'package:cityguide/Admin/screens/mainscreens/maincontroller/attraction_controller.dart';
import 'package:cityguide/Admin/screens/mainscreens/navigatescreens/edit/edit_products_tabs/product_title_text.dart';
import 'package:cityguide/Admin/screens/mainscreens/navigatescreens/edit/edit_products_tabs/restuarant_brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:cityguide/utils/constants/sizes.dart';
import 'package:cityguide/utils/helpers/cloud_helper_functions.dart';
import 'package:cityguide/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class UnPublishedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(attractionController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Obx(
          () => FutureBuilder(
            key: Key(controller.refreshData.value.toString()),
            future: controller.getAllAttractions(false),
            builder: (context, snapshot) {
              final response = TCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot);
              if (response != null) return response;

              final addresses = snapshot.data!;
              return ListView.separated(
                shrinkWrap: true,
                itemCount: addresses.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: TSizes.spaceBtwItems),
                itemBuilder: (_, index) => Slidable(
                    child: TSingleAddress(
                      attractionmodel: addresses[index], ),
                    // Specify a key if the Slidable is dismissible.
                    key: const ValueKey(0),

                    // The start action pane is the one at the left or the top side.
                    startActionPane: ActionPane(
                      // A motion is a widget used to control how the pane animates.
                      motion: const ScrollMotion(),

                      // A pane can dismiss the Slidable.

                      // All actions are defined in the children parameter.
                      children: [
                        // A SlidableAction can have an icon and/or a label.

                        CustomSlidableAction(
                          padding: const EdgeInsets.all(5),
                          onPressed: (context){
                            controller.updateAttractionAvailability(addresses[index].attractionId, true);},
                          foregroundColor: Colors.white,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(TSizes.md),
                              color: const Color(0xFF2196F3),
                            ),
                            child: Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Iconsax.eye,),
                                      const SizedBox(height: 5,),
                                      Text(
                                        'available',
                                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white),
                                        overflow:TextOverflow.ellipsis,

                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        CustomSlidableAction(
                          padding: const EdgeInsets.all(5),
                          onPressed: (context)=>controller.deleteattraction(addresses[index].attractionId),
                          foregroundColor: Colors.white,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(TSizes.md),
                              color: const Color(0xFFB71C1C),
                            ),
                            child: Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Iconsax.bag,),
                                      const SizedBox(height: 5,),
                                      Text(
                                        'Delete',
                                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white),
                                        overflow:TextOverflow.ellipsis,

                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class TSingleAddress extends StatelessWidget {
  const TSingleAddress(
      {Key? key, required this.attractionmodel});

  final AttractionModel attractionmodel;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          border:Border.all(color:  dark ? TColors.darkGrey : TColors.grey)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ///image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: THelperFunctions.isDarkMode(context) ? TColors.darkerGrey : TColors.light,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(TSizes.md), bottomLeft:Radius.circular(TSizes.md) ),
            ),
            child: ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(TSizes.md), bottomLeft:Radius.circular(TSizes.md)),
                child: Image(image: NetworkImage(attractionmodel.profilePicture), fit: BoxFit.cover, )),
          ),
          const SizedBox(width: TSizes.spaceBtwItems/1.5,),
          ///Title, amount and item variation
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TBrandTitleWithVerifiedIcon(title: attractionmodel.attractionState,),
               Flexible(
                  child: TProductTitleText(
                    title: attractionmodel.attractionName, maxLines: 1,
                  ),
                ),
                Flexible(
                  child: TProductTitleText(
                    title: attractionmodel.attractionNumber, maxLines: 1,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
