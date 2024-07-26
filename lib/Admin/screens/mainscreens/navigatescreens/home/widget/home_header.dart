import 'package:flutter/material.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:cityguide/utils/formatter/formatter.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader();


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
          gradient: TColors.linerGradient
      ),

      child:SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(TFormatter.formatCurrency(89), style: TextStyle(color: Colors.white, fontSize: 65)),
              ),
            ),
            Text("Total Saved", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
