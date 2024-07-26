// ignore_for_file: camel_case_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cityguide/Admin/comons/widgets/loaders/shimmer.dart';
import 'package:cityguide/Admin/comons/widgets/rounde_container.dart';
import 'package:cityguide/Admin/screens/mainscreens/maincontroller/city_controller.dart';
import 'package:cityguide/repositories/controllers/countryandcity_controller.dart';
import 'package:cityguide/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:cityguide/utils/constants/image_strings.dart';
import 'package:cityguide/utils/constants/sizes.dart';
import 'package:cityguide/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TAddStateForm extends StatelessWidget {
  const TAddStateForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controllax = Get.put(CityController());
    final statecitycontroller = Get.put(CountryStateCityController());
    return SingleChildScrollView(
      child: Form(
          key: controllax.cityFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: TSizes.spaceBtwSections,
              horizontal: TSizes.defaultSpace,
            ),
            child: Column(
              children: [
                ///State Image
                Obx(() {
                  final networkImage = controllax.citymain.value.cityPicture;
                  final image = networkImage.isNotEmpty
                      ? networkImage
                      : TImages.productImage2;
                  return TRoundedContainer(
                    showBorder: true,
                    width: double.infinity,
                    backgroundColor: TColors.grey.withOpacity(0.5),
                    borderColor: TColors.darkGrey,
                    child: controllax.imageUploading.value
                          ? const TShimmerEffect(
                              width: double.infinity,
                              height: 120,
                              radius: 100,
                            )
                          : attractionImage(
                              image: image,
                              isNetworkImage: networkImage.isNotEmpty)

                  );
                }),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                Obx(() {
                  return !statecitycontroller.isDataLoaded.value
                      ? const CircularProgressIndicator()
                      : Column(
                          children: [
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(18.0),
                                filled: false,
                                hintText: 'Select Country',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: TColors.darkGrey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: TColors.darkGrey),
                                ),
                              ),
                              isExpanded: true,
                              value: statecitycontroller.selectedCountry.value,
                              items: statecitycontroller.countries
                                  .map((String country) => DropdownMenuItem(
                                      value: country, child: Text(country)))
                                  .toList(),
                              onChanged: (selectedValue) {
                                statecitycontroller.selectedCountry.value =
                                    selectedValue!;
                                controllax.country.text = selectedValue!;
                                if (statecitycontroller.selectedCountry.value !=
                                    'Select Country') {
                                  statecitycontroller.getStates();
                                }
                              },
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value == 'Select Country') {
                                  return 'Please select a country';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(18.0),
                                filled: false,
                                hintText: 'Select State',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: TColors.darkGrey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: TColors.darkGrey),
                                ),
                              ),
                              isExpanded: true,
                              value: statecitycontroller.selectedState.value,
                              items: statecitycontroller.states
                                  .map((String state) => DropdownMenuItem(
                                      value: state, child: Text(state)))
                                  .toList(),
                              onChanged: (selectedValue) {
                                statecitycontroller.selectedState.value =
                                    selectedValue!;
                                controllax.state.text = selectedValue!;
                                if (statecitycontroller.selectedState.value !=
                                    'Select State') {
                                  statecitycontroller.getCities();
                                }
                              },
                              validator: (value) =>
                                  TValidator.validateEmptyText('State', value),
                            ),
                            const SizedBox(height: 20),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(18.0),
                                filled: false,
                                hintText: 'Select City',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: TColors.darkGrey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: TColors.darkGrey),
                                ),
                              ),
                              isExpanded: true,
                              value: statecitycontroller.selectedCity.value,
                              items: statecitycontroller.cities
                                  .map((String city) => DropdownMenuItem(
                                      value: city, child: Text(city)))
                                  .toList(),
                              onChanged: (selectedValue) {
                                statecitycontroller.selectedCity.value =
                                    selectedValue!;
                                controllax.city.text = selectedValue!;
                                if (statecitycontroller.selectedCity.value !=
                                    'Select City') {
                                  statecitycontroller
                                          .finalTextToBeDisplayed.value =
                                      "Country: ${statecitycontroller.selectedCountry.value}\nState: ${statecitycontroller.selectedState.value}\nCity: ${statecitycontroller.selectedCity.value}";
                                }
                              },
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value == 'Select Country') {
                                  return 'Please select a country';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            Text(
                              statecitycontroller.finalTextToBeDisplayed.value,
                              style: const TextStyle(fontSize: 22),
                            ),
                          ],
                        );
                }),

                /// Sign Up Button
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),

                ///Sign In Button
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {controllax.addCity();
                          },
                        child: Text('Add City')))
              ],
            ),
          )),
    );
  }
}

class attractionImage extends StatelessWidget {
  const attractionImage({
    super.key,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
  });

  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CityController());
    return Container(
        height: 167,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
        ),
        child: isNetworkImage
            ? ClipRRect(
                borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  color: overlayColor,
                  imageUrl: image,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const TShimmerEffect(width: 120, height: 120),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              )
            : InkWell(
                onTap: () {
                  controller.uploadCityPicture();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.image,
                        size: 50,
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      Text('Upload City Picture')
                    ],
                  ),
                ),
              ));
  }
}
