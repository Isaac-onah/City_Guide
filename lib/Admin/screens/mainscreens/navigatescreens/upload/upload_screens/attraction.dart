
import 'package:cityguide/Admin/screens/mainscreens/navigatescreens/upload/upload_widget/add_attraction_form.dart';
import 'package:flutter/material.dart';
import 'package:cityguide/utils/constants/sizes.dart';
import 'package:cityguide/utils/constants/text_strings.dart';

class attractionScreen extends StatelessWidget {
  const attractionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Padding(
          padding:EdgeInsets.all(TSizes.defaultSpace,),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            TAddattractionForm()
          ],
                ),
        ),),
    );
  }
}
