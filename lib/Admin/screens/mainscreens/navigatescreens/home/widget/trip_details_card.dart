
import 'package:flutter/material.dart';
import 'package:cityguide/utils/constants/image_strings.dart';
import 'package:cityguide/utils/formatter/formatter.dart';
import 'package:intl/intl.dart';

class TripDetailsCard extends StatelessWidget {
  TripDetailsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        clipBehavior: Clip.none, alignment: Alignment.bottomCenter,
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: Image.asset('images/place5.jpg',fit: BoxFit.fill,),
                  
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                )
              ],
            ),
          ),
          Positioned(
            top: 150,
            left: 15,
            right: 15,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            child: Text(
                              'CITY GUIDE',
                              style: TextStyle(fontSize: 30.0),
                              maxLines: 2,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                              "${DateFormat("MMM dd, yyyy - HH:mm").format(DateTime.now())}"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(TFormatter.formatCurrency(7700),
                            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                          child: Text("today's Transactions"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
