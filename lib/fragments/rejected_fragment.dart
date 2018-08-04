import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import '../model/rejected_model.dart';

class RejectedFragment extends StatefulWidget {
  @override
  _RejectedPage createState() => new _RejectedPage();
}

class _RejectedPage extends State<RejectedFragment> {
  List<RejectedModel> rejectedList = [];

  @override
  void initState() {
    super.initState();
//    DatabaseReference reference = FirebaseDatabase.instance.reference().child('Rejected');
//    reference.keepSynced(true);
//    reference.once().then((DataSnapshot snapshot) {
//      var keys = snapshot.value.keys;
//      var data = snapshot.value;
//      rejectedList.clear();
//      for (var key in keys) {
//        RejectedModel model = new RejectedModel(
//            data[key]['brand'],
//            data[key]['board'],
//            data[key]['model'],
//            data[key]['codeName'],
//            data[key]['email'],
//            data[key]['uid'],
//            data[key]['fmcToken'],
//            data[key]['date'],
//            data[key]['url'],
//            data[key]['developerEmail'],
//            data[key]['note'],
//            data[key]['rejector']);
//        rejectedList.add(model);
//      }
//
//      setState(() {
//        print('Length of data ${rejectedList.length} ${data.toString()}');
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
//            child: rejectedList.length == 0
//                ? Center(
//                    child: CircularProgressIndicator(),
//                  )
//                : ListView.builder(
//                    itemCount: rejectedList.length,
//                    itemBuilder: (_, index) {
//                      return showUI(
//                          rejectedList[index].Model,
//                          rejectedList[index].Board,
//                          rejectedList[index].Brand,
//                          rejectedList[index].Date,
//                          rejectedList[index].Rejector,
//                          rejectedList[index].Note);
//                    },
//                  )
        child: FirebaseAnimatedList(
            query: FirebaseDatabase.instance.reference().child('Rejected'),
            defaultChild: Center(
              child: CircularProgressIndicator(strokeWidth: 2.0,),
            ),
            itemBuilder: (_, DataSnapshot snapshot,
            Animation<double> animation, int x){

              RejectedModel model = RejectedModel.fromSnapshot(snapshot);
              print(model.Rejector);
              print(x);
              return showUI(model.Model, model.Board, model.Brand, model.Date, model.Email, model.Rejector, model.Note);
            },
        ),
        )
    );
  }

  Widget showUI(String model, String board, String brand, String date,
      String email, String rejector, String note) {
    return Card(
      elevation: 3.0,
      shape: BeveledRectangleBorder(),
      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 5.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Model: $model'),
            Text('Board: $board'),
            Text('Brand: $brand'),
            Text('Date: $date'),
            Text('Email: $email'),
            Text('Rejector: $rejector'),
            Text('Note: $note'),
          ],
        ),
      ),
    );
  }
}
