import 'package:flutter/material.dart';

class Notes extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "TripNotes-",
      transitionOnUserGestures: true,
      child: Card(
        color: Colors.amberAccent,
        child: InkWell(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                child: Row(
                  children: <Widget>[
                    Text("Notes", style: TextStyle(fontSize: 24, color: Colors.black)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: setNoteText(),
                ),
              )
            ],
          ),
          onTap: () {

          },
        ),
      ),
    );
  }

  List<Widget> setNoteText() {

      return [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.add_circle_outline, color: Colors.grey),
        ),
        Text("Click To Add Notes", style: TextStyle(color: Colors.black)),
      ];

  }
}
