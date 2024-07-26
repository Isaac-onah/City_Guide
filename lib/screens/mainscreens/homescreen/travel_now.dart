import 'package:cityguide/Admin/comons/models/citymodel.dart';
import 'package:cityguide/Admin/screens/mainscreens/maincontroller/attraction_controller.dart';
import 'package:cityguide/models/recommended_places_model.dart';
import 'package:cityguide/repositories/controllers/user_controller.dart';
import 'package:cityguide/screens/mainscreens/detailscreen/tourist_details_page.dart';
import 'package:cityguide/screens/mainscreens/homescreen/homewidgets/tourist_places.dart';
import 'package:cityguide/screens/mainscreens/profile/widgets/circular_image.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:cityguide/utils/constants/sizes.dart';
import 'package:cityguide/utils/helpers/cloud_helper_functions.dart';
import 'package:cityguide/utils/helpers/helper_functions.dart';
import 'package:cityguide/utils/popups/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';

class TravelNowScreen extends StatelessWidget {
  final CityModel cityModel;

  const TravelNowScreen({Key? key, required this.cityModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    final attractController = Get.put(attractionController());

    // Fetch attractions when the screen is built
    attractController.getAllAttractionsList(true, cityModel.stateName);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(221, 249, 247, 1),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Good Morning"),
            Obx(
                  () => Text(
                controller.userInfo.value.fullName,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "The Now Lets Travel Store specializes in great deals on holidays",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            TSearchContainer(
              searchController: attractController.searchController,
              showBorder: true,
              showBackground: false,
              onChanged: (value) {
                attractController.filterAttraction(value);
              },
              text: 'Search for city',
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            TouristPlaces(
              onCategorySelected: (category) {
                print(category);
                attractController.setCategory(category);
              },
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            RatingFilter(
              onRatingSelected: (rating) {
                attractController.setRating(rating);
              },
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Attraction Listings",
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            SizedBox(height: 20),
            Flexible(
              child: Container(
                height: 250,
                child: Obx(() {
                  if (attractController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else if (attractController.filteredattractions.isEmpty) {
                    return Center(child: Text('No Attraction found'));
                  } else {
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: attractController.filteredattractions.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 220,
                          child: Card(
                            elevation: 0.4,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TouristDetailsPage(
                                      attractionModel: attractController.filteredattractions[index],
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        attractController.filteredattractions[index].profilePicture,
                                        width: double.maxFinite,
                                        fit: BoxFit.cover,
                                        height: 150,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          attractController.filteredattractions[index].attractionName,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow.shade700,
                                          size: 14,
                                        ),
                                        Text(
                                          attractController.filteredattractions[index].rating.toString(),
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(
                                          Ionicons.location,
                                          color: Theme.of(context).primaryColor,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          attractController.filteredattractions[index].attractionLocation,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.only(right: 10),
                      ),
                    );
                  }
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key, required this.searchController, this.icon = Iconsax
        .search_normal, this.showBackground = true, this.showBorder = true, this.onChanged, required this.text,
  });

  final TextEditingController searchController;
  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
          hintText: text,
          border: InputBorder.none,
          prefixIcon: Icon(
              icon, color: dark ? TColors.lightGrey : TColors.darkGrey)
      ),
      onChanged: onChanged,
    );
  }
}

class RatingFilter extends StatelessWidget {
  final void Function(double rating) onRatingSelected;

  const RatingFilter({Key? key, required this.onRatingSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (index) {
        final rating = index + 1.0;
        return GestureDetector(
          onTap: () => onRatingSelected(rating),
          child: Icon(
            Icons.star,
            color: Colors.yellow.shade700,
            size: 30,
          ),
        );
      }),
    );
  }
}
