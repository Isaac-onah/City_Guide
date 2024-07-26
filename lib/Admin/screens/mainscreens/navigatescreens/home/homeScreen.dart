
import 'package:cityguide/Admin/screens/mainscreens/navigatescreens/home/widget/current_daily_budget.dart';
import 'package:cityguide/Admin/screens/mainscreens/navigatescreens/home/widget/days_until_trip.dart';
import 'package:cityguide/Admin/screens/mainscreens/navigatescreens/home/widget/notes.dart';
import 'package:cityguide/Admin/screens/mainscreens/navigatescreens/home/widget/trip_details_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: Column(
          children: [
            // HomeHeader(),
            TripDetailsCard(),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 12,
                    child: DaysUntilTrip(),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 12,
                    child: CurrentDailyBudget(),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Notes(),
            ),
            Container(height: 40)
          ],
        ),
      ),
    );
  }
}




