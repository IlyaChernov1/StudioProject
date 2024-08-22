import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {

  final int number;

  DetailsScreen(this.number);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text("$number"),
            ElevatedButton(
              onPressed: () {

              Navigator.of(context).pop();

            },
              child: Text("Pop current screen"),
            )
          ],
        ),
      ),
    );
  }
}
