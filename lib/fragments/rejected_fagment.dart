import 'package:flutter/material.dart';

class RejectedFragment extends StatelessWidget {
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
                  child: Text(
                    "Rejected builds will be here",
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
