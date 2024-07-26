import 'package:cityguide/Admin/screens/mainscreens/maincontroller/attraction_controller.dart';
import 'package:flutter/material.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:get/get.dart';

class DaysUntilTrip extends StatelessWidget {
  DaysUntilTrip();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: TColors.primary
        ),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text('34', style: TextStyle(fontSize: 60, color: Colors.white)),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text("Total Products", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
