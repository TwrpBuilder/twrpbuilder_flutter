import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import '../model/queue_model.dart';
import '../model/running_model.dart';
import '../json_translations.dart';

class IncompleteFragment extends StatefulWidget {
  @override
  _IncompletePage createState() => new _IncompletePage();
}

class _IncompletePage extends State<IncompleteFragment> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: new TabBar(
              tabs: [
                Tab(text: Translations.of(context).text('queue')),
                Tab(text: Translations.of(context).text('running')),
              ],
              labelColor: Colors.black,
            ),
            body: TabBarView(
              children: [
                Container(
                  child: FirebaseAnimatedList(
                      query: FirebaseDatabase.instance.reference().child('InQueue'),
                      defaultChild: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      ),
                      itemBuilder: (_, DataSnapshot snapshot, Animation<double> animation, int x) {
                        QueueModel model = QueueModel.fromSnapshot(snapshot);
                        return showQueueUI(model.Model, model.Board, model.Brand, model.Date);
                      }
                  ),
                ),
                Container(
                  child: FirebaseAnimatedList(
                      query: FirebaseDatabase.instance.reference().child('RunningBuild'),
                      defaultChild: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      ),
                      itemBuilder: (_, DataSnapshot snapshot, Animation<double> animation, int x) {
                        RunningModel model = RunningModel.fromSnapshot(snapshot);
                        return showRunningUI(model.Model, model.Board, model.Brand, model.Date);
                      }
                  ),

                ),
              ],
            ),
          )),
    );
  }

  Widget showQueueUI(String model, String board, String brand, String date) {
    return Card(
      elevation: 3.0,
      shape: BeveledRectangleBorder(),
      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(Translations.of(context).text('model')),
                Padding(padding: EdgeInsets.only(left: 2.0, right: 2.0)),
                Text(': $model'),
              ],
            ),
            Row(
              children: <Widget>[
                Text(Translations.of(context).text('board')),
                Padding(padding: EdgeInsets.only(left: 2.0, right: 2.0)),
                Text(': $board'),
              ],
            ),
            Row(
              children: <Widget>[
                Text(Translations.of(context).text('brand')),
                Padding(padding: EdgeInsets.only(left: 2.0, right: 2.0)),
                Text(': $brand'),
              ],
            ),
            Row(
              children: <Widget>[
                Text(Translations.of(context).text('date')),
                Padding(padding: EdgeInsets.only(left: 2.0, right: 2.0)),
                Text(': $date'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget showRunningUI(String model, String board, String brand, String date) {
    return Card(
      elevation: 3.0,
      shape: BeveledRectangleBorder(),
      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(Translations.of(context).text('model')),
                Padding(padding: EdgeInsets.only(left: 2.0, right: 2.0)),
                Text(': $model'),
              ],
            ),
            Row(
              children: <Widget>[
                Text(Translations.of(context).text('board')),
                Padding(padding: EdgeInsets.only(left: 2.0, right: 2.0)),
                Text(': $board'),
              ],
            ),
            Row(
              children: <Widget>[
                Text(Translations.of(context).text('brand')),
                Padding(padding: EdgeInsets.only(left: 2.0, right: 2.0)),
                Text(': $brand'),
              ],
            ),
            Row(
              children: <Widget>[
                Text(Translations.of(context).text('date')),
                Padding(padding: EdgeInsets.only(left: 2.0, right: 2.0)),
                Text(': $date'),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
