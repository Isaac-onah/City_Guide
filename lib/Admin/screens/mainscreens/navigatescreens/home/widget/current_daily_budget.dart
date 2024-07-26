
import 'package:flutter/material.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:get/get.dart';

class CurrentDailyBudget extends StatelessWidget {
  CurrentDailyBudget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color:TColors.primary
        ),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text('34',style: TextStyle(fontSize: 60, color: Colors.white),
              )),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text("Total Orders", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

