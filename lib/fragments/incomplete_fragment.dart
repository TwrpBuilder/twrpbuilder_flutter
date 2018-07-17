import 'package:flutter/material.dart';

class IncompleteFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: new TabBar(
              tabs: [
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.sync)),
              ],
              labelColor: Colors.black,
            ),
            body: TabBarView(
              children: [
                Center(
                  child: Text(
                    "In queue builds will be here",
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    "Running builds will be here",
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
