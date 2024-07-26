import 'package:cityguide/Admin/screens/mainscreens/navigatescreens/edit/edit_products_tabs/published_tab.dart';
import 'package:cityguide/Admin/screens/mainscreens/navigatescreens/edit/edit_products_tabs/unpublished_tab.dart';
import 'package:flutter/material.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:cityguide/utils/constants/sizes.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  int selectIndex = 0;

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text(
            'Manage Products',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
            ),
          ),

        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      indicatorColor: TColors.primary,
                      labelColor: TColors.primary,
                      labelPadding:
                      EdgeInsets.symmetric(horizontal: 05),
                      indicator:BoxDecoration(),
                      dividerColor: Colors.transparent,
                      tabs: [
                        selectIndex != 0
                            ? Text(
                            'Published',style: Theme.of(context).textTheme.labelMedium!
                        )
                            : Container(
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: TColors.primary,
                          ),
                          child:Center(
                            child: Text(
                                'Published',style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.white)
                            ),
                          ),
                        ),
                        selectIndex != 1
                            ? Text(
                            'Unpublished',style: Theme.of(context).textTheme.labelMedium!
                        )
                            : Container(
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: TColors.primary,
                          ),
                          child:Center(
                            child: Text(
                                'Unpublished',style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.white)
                            ),
                          ),
                        ),
                      ],),
                  ),
                  Expanded(
                    child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                      PublishedTab(),
                      UnPublishedTab(),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}