import 'package:flutter/material.dart';

class ContributeFragment extends StatelessWidget {
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
                  child: Text("Details about contributers will be here", textAlign: TextAlign.center,),
                )
              ],
            ),
          )
      ),
    );
  }

}