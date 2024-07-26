import 'package:cityguide/Admin/screens/mainscreens/navigatescreens/upload/upload_screens/add_categories.dart';
import 'package:cityguide/Admin/screens/mainscreens/navigatescreens/upload/upload_screens/attraction.dart';
import 'package:cityguide/Admin/screens/mainscreens/navigatescreens/upload/upload_widget/add_state.dart';
import 'package:flutter/material.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:cityguide/utils/constants/sizes.dart';
import 'package:cityguide/utils/constants/text_strings.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {

  int selectIndex = 0;

  String searchQuery = '';

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text('Upload Resources', style: Theme.of(context).textTheme.headlineSmall!),
              ),
              SizedBox(
                height: TSizes.spaceBtwSections/2,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,

                      child: TabBar(
                        overlayColor:MaterialStateProperty.all<Color>(Colors.transparent),
                        splashFactory: NoSplash.splashFactory,
                        onTap: (index) {
                          setState(() {
                            selectIndex = index;
                          });
                        },
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 05),
                        indicator:BoxDecoration(),
                        dividerColor: Colors.transparent,
                        tabs: [
                          selectIndex != 0
                              ? Text(
                              'Add Category',style: Theme.of(context).textTheme.labelMedium!
                          )
                              : Container(
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: TColors.primary,
                            ),
                            child:Center(
                              child: Text(
                                  'Add Category',style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.white)
                              ),
                            ),
                          ),
                          selectIndex != 1
                              ? Text(
                                  'Add State',style: Theme.of(context).textTheme.labelMedium!
                                )
                              : Container(
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: TColors.primary,
                                  ),
                                  child:Center(
                                    child: Text(
                                      'Add State',style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.white)
                                    ),
                                  ),
                                ),
                          selectIndex != 2
                              ? Text(
                                  'Add Attraction',style: Theme.of(context).textTheme.labelMedium!
                                )
                              : Container(
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: TColors.primary,
                                  ),
                                  child:Center(
                                    child: Text(
                                      'Add Attraction',style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.white)
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          categoriesScreen(),
                          TAddStateForm(),
                          attractionScreen()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
