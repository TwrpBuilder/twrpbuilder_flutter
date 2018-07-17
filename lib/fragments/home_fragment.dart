import 'package:flutter/material.dart';

class HomeFragment extends StatelessWidget {
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
                  child: Text("Backup options will be here", textAlign: TextAlign.center,),
                )
              ],
            ),
          )
      ),
    );
  }

}