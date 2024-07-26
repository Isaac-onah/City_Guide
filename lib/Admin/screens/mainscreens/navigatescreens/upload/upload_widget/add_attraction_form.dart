// ignore_for_file: camel_case_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cityguide/Admin/comons/widgets/loaders/shimmer.dart';
import 'package:cityguide/Admin/comons/widgets/rounde_container.dart';
import 'package:cityguide/Admin/screens/mainscreens/maincontroller/categories_controller.dart';
import 'package:cityguide/Admin/screens/mainscreens/maincontroller/attraction_controller.dart';
import 'package:cityguide/repositories/controllers/countryandcity_controller.dart';
import 'package:cityguide/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:cityguide/utils/constants/image_strings.dart';
import 'package:cityguide/utils/constants/sizes.dart';
import 'package:cityguide/utils/helpers/cloud_helper_functions.dart';
import 'package:cityguide/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TAddattractionForm extends StatelessWidget {
  const TAddattractionForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(attractionController());

    final controllax = Get.put(CategoriesController());
    final statecitycontroller = Get.put(CountryStateCityController());

    return Form(
        key: controller.addAttractionFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: TSizes.spaceBtwSections,
          ),
          child: Column(
            children: [
              ///Attraction Image
              TRoundedContainer(
                showBorder: true,
                width: double.infinity,
                backgroundColor: TColors.grey.withOpacity(0.5),
                borderColor: TColors.darkGrey,
                child: Obx(() {
                  final networkImage = controller.attractionmain.value.profilePicture;

                  final image = networkImage.isNotEmpty
                      ? networkImage
                      : TImages.productImage2;
                  return controller.imageUploading.value
                      ? const TShimmerEffect(
                          width: double.infinity,
                          height: 120,
                          radius: 100,
                        )
                      : attractionImage(
                          image: image,
                          isNetworkImage: networkImage.isNotEmpty);
                }),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              ///Attraction Name
              TextFormField(
                controller: controller.attractionName,
                validator: (value) =>
                    TValidator.validateEmptyText('Name', value),
                decoration: InputDecoration(
                  labelText: 'Enter Name',
                  floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              ///Attraction Location
              TextFormField(
                expands: false,
                controller: controller.attractionLocation,
                validator: (value) =>
                    TValidator.validateEmptyText('Location', value),
                decoration: InputDecoration(
                  labelText: 'Enter location',
                  floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              Row(
                children: [
                  ///website
                  Expanded(
                    child: TextFormField(
                      expands: false,
                      keyboardType:TextInputType.number,
                      controller: controller.attractionLong,
                      validator: (value) =>
                          TValidator.validateEmptyText('Longitude', value),
                      decoration: InputDecoration(
                        labelText: 'Enter Longitude',
                        floatingLabelStyle:
                            Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwInputFields/2,
                  ),

                  ///contact
                  Expanded(
                    child: TextFormField(
                      expands: false,
                      keyboardType:TextInputType.number,
                      controller: controller.attractionLat,
                      validator: (value) =>
                          TValidator.validateEmptyText('Latitude', value),
                      decoration: InputDecoration(
                        labelText: 'Enter Latitude',
                        floatingLabelStyle:
                            Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              ///website
              TextFormField(
                expands: false,
                controller: controller.attractionWeb,
                validator: (value) =>
                    TValidator.validateEmptyText('website link', value),
                decoration: InputDecoration(
                  labelText: 'website link',
                  floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              ///contact
              TextFormField(
                expands: false,
                controller: controller.attractionNumber,
                validator: (value) =>
                    TValidator.validateEmptyText('phone Number', value),
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              ///contact info
              TextFormField(
                expands: false,
                controller: controller.attractionAddress,
                validator: (value) =>
                    TValidator.validateEmptyText('Address', value),
                decoration: InputDecoration(
                  labelText: 'Enter Address',
                  floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
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
                        controller.attractionCountry.text = selectedValue!;
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
                        controller.attractionState.text = selectedValue!;
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
                        controller.attractionCity.text = selectedValue!;
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
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              ///Attraction Category
              Obx(() => FutureBuilder(
                //use to trigger refresh
                  key: Key(controllax.refreshData.value.toString()),
                  future: controllax.getAllbranchCategories(),
                  builder: (context, snapshot) {
                    /// Helper Function: Handle loader, No Record, or Error Message
                    final response =
                    TCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot);
                    if (response != null) return response;

                    final cate = snapshot.data!;
                    return DropdownButtonFormField(
                        dropdownColor: kFormBColor,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(18.0),
                          filled: false,
                          hintText: 'Attraction Category',
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
                        hint: Text(
                          'Select Attraction Category',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        items: cate.map<DropdownMenuItem<String>>((e) {
                          return DropdownMenuItem(
                              value: e.category, child: Text(e.category));
                        }).toList(),
                        onChanged: (value) {
                          controller.category.text = value!;
                        });
                  })),

              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              ///rating info
              TextFormField(
                keyboardType:TextInputType.number,
                expands: false,
                controller: controller.rate,
                validator: (value) =>
                    TValidator.validateEmptyText('Rating', value),
                decoration: InputDecoration(
                  labelText: 'Enter Rating',
                  floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              ///Description
              TextFormField(
                expands: false,
                minLines: 3,
                maxLines: 10,
                controller: controller.attractionDescription,
                validator: (value) =>
                    TValidator.validateEmptyText('Description', value),
                decoration: InputDecoration(
                  labelText: 'Description',
                  floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),

              /// Sign Up Button
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              ///Sign In Button
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.addAttraction(),
                      child: Text('Add Attraction')))
            ],
          ),
        ));
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
    final controller = Get.put(attractionController());
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
                  controller.uploadAttractionPicture();
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
                      Text('Upload Attraction Picture')
                    ],
                  ),
                ),
              ));
  }
}
