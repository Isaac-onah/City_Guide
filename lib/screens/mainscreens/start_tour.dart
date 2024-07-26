import 'package:cityguide/Admin/comons/widgets/loaders/shimmer.dart';
import 'package:cityguide/Admin/navigation_menu.dart';
import 'package:cityguide/Admin/screens/mainscreens/maincontroller/city_controller.dart';
import 'package:cityguide/repositories/controllers/user_controller.dart';
import 'package:cityguide/screens/mainscreens/homescreen/homewidgets/location_card.dart';
import 'package:cityguide/screens/mainscreens/homescreen/travel_now.dart';
import 'package:cityguide/screens/mainscreens/profile/profilescreen.dart';
import 'package:cityguide/screens/mainscreens/profile/widgets/circular_image.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:cityguide/utils/constants/sizes.dart';
import 'package:cityguide/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class StartTourScreen extends StatelessWidget {
  const StartTourScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CityController());
    String searchText = '';
    controller.getAllCity();
    return Scaffold(
        body: Stack(children: [
          _backgroundImage(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  _headerView(() {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => profileScreen()));
                  }),
                  SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),

                  ///LOCATION CARD
                  const LocationCard(),
                  SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "We focus a lot on helping the first time or inexperienced traveler head out",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TSearchContainer(
                    searchController: controller.searchController,
                    showBorder: true,
                    showBackground: false,
                    onChanged: (value) {
                      controller.filterBranches(value);
                    },
                    text: 'Search for city',
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  Obx(
                          () {
                        if (controller.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (controller.filteredBranches.isEmpty) {
                          return Center(
                            child: Text('No City found'),
                          );
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.filteredBranches.length,
                            itemBuilder: (_, index) {
                              final addresses = controller
                                  .filteredBranches[index];
                              return GestureDetector(
                                onTap: ()=>Get.to(TravelNowScreen(cityModel: addresses)),
                                child: _cardDetailView(
                                    addresses.cityPicture,
                                    addresses.cityName,
                                    addresses.countryName),
                              );

                            },);
                        }
                      }
                  ),
                ],
              ),
            ),
          ),
          _bottomView(context),
        ]));
  }

  Widget _backgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/start_tour_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _cardDetailView(String imagePath, String title, String description) {
    return Card(
      color: const Color.fromRGBO(254, 246, 218, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 90,
              width: 90,
              child: Image.network(
                imagePath,
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              width: TSizes.spaceBtwItems / 2,
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        description,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bottomView(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "images/pagination.png",
                scale: 1.5,
              ),
              InkWell(
                onTap: () {
                  Get.to(NavigationMenu());
                },
                child: const Text(
                  "Admin",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        )
      ]),
    );
  }
}

Widget _headerView(VoidCallback ontap) {
  final controller = Get.put(UserController());
  return Row(
    children: [
      GestureDetector(
        onTap: ontap,
        child: Obx(() {
          final networkImage = controller.userInfo.value.profilePicture;
          final image = networkImage.isNotEmpty
              ? networkImage
              : "images/user_with_green_bg.png";
          return controller.imageUploading.value
              ? const TShimmerEffect(
            width: 80,
            height: 80,
            radius: 100,
          )
              : Center(
              child: TCircularImage(
                image: image,
                width: 80,
                height: 80,
                isNetworkImage: networkImage.isNotEmpty,
                padding: 0,
              ));
        }),
      ),
      SizedBox(
        width: 16,
      ),
      Obx(
            () =>
            Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.userInfo.value.fullName,
                      style: Theme
                          .of(Get.context!)
                          .textTheme
                          .headlineMedium,
                    ),
                    Row(
                      children: [
                        Text(
                          "Let’s",
                          style: Theme
                              .of(Get.context!)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 22),
                        ),
                        Text(
                          " tour",
                          style: Theme
                              .of(Get.context!)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                              fontSize: 22, fontWeight: FontWeight.w100),
                        ),
                        Text(
                          " now 🗺️",
                          style: Theme
                              .of(Get.context!)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                              fontSize: 22, fontWeight: FontWeight.w100),
                        )
                      ],
                    ),
                  ],
                )),
      ),
    ],
  );
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
