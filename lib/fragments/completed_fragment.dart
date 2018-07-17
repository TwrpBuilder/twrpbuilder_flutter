import 'package:flutter/material.dart';

class CompletedFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: DefaultTabController(
          length: 3,
          child: Scaffold(
            body: TabBarView(
              children: [
                Center(
                  child: Text("Completed builds will be here", textAlign: TextAlign.center,),
                )
              ],
            ),
          )
      ),
    );
  }

}