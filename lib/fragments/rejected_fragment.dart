import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../json_translations.dart';
import '../model/rejected_model.dart';

class RejectedFragment extends StatefulWidget {
  @override
  _RejectedPage createState() => new _RejectedPage();
}

class _RejectedPage extends State<RejectedFragment> {
  List<RejectedModel> rejectedList = [];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
      child: FirebaseAnimatedList(
        query: FirebaseDatabase.instance.reference().child('Rejected'),
        defaultChild: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
          ),
        ),
        itemBuilder:
            (_, DataSnapshot snapshot, Animation<double> animation, int x) {
          RejectedModel model = RejectedModel.fromSnapshot(snapshot);
          //print(model.Rejector);
          //print(x);
          return showUI(model.Model, model.Board, model.Brand, model.Date,
              model.Email, model.Rejector, model.Note);
        },
      ),
    ));
  }

  Widget showUI(String model, String board, String brand, String date,
      String email, String rejector, String note) {
    return Card(
      elevation: 3.0,
      shape: BeveledRectangleBorder(),
      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
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
            Row(
              children: <Widget>[
                Text(Translations.of(context).text('hint_email')),
                Padding(padding: EdgeInsets.only(left: 2.0, right: 2.0)),
                Text(': $email'),
              ],
            ),
            Row(
              children: <Widget>[
                Text(Translations.of(context).text('rejected_by')),
                Padding(padding: EdgeInsets.only(left: 2.0, right: 2.0)),
                Text(': $rejector'),
              ],
            ),
            Row(
              children: <Widget>[
                Text(Translations.of(context).text('note')),
                Padding(padding: EdgeInsets.only(left: 2.0, right: 2.0)),
                Text(': $note'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
