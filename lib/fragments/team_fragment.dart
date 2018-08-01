import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:twrp_builder/dev_list_item.dart';
import 'package:twrp_builder/model/developer_model.dart';

final DatabaseReference developerDatabaseReference =
    FirebaseDatabase.instance.reference().child('Developers');
DataSnapshot snapshot;

class TeamFragment extends StatefulWidget {
  @override
  _TeamFragmentPage createState() => new _TeamFragmentPage();
}

class _TeamFragmentPage extends State<TeamFragment> {
  List<DeveloperModel> devList = new List();

//  _TeamFragmentPage() {
//    //developerDatabaseReference.onChildChanged.listen(_onEntryAdded);
//    developerDatabaseReference.once().then((DataSnapshot snapshot){
//      //print(snapshot.toString());
//     // _onEntryAdded(snapshot);
//    }
//    );
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    developerDatabaseReference.onValue.listen(_onEntryAdded);
  }

  _onEntryAdded(Event event) {
    setState(() {
      //devList.add(new DeveloperModel.fromSnapshot(event.snapshot));
      snapshot = event.snapshot;
      Map<String, dynamic> usermap = snapshot.value.cast<String, dynamic>();
      usermap.forEach((string, dynamic) {
        DeveloperModel developerModel = parseUser(string, dynamic);
        setState(() {
          devList.add(developerModel);
        });
      });
      //devList.add(new DeveloperModel.fromSnapshot());
      print(event.snapshot.value.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ListView.builder(
            itemCount: devList.length,
            itemBuilder: (context, index) {
              return new InkWell(
                child: new DevListItem(devList[index], snapshot),
              );
            }));
  }

  DeveloperModel parseUser(String userId, Map<dynamic, dynamic> user) {
    String email;
    String name;
    String photoUrl;
    String xdaUrl;
    String gitId;
    String donationUrl;
    String description;
    user.forEach((key, value) {
      if (key == 'name') {
        name = value as String;
      }
      if (key == 'photoUrl') {
        photoUrl = value as String;
      }
      if (key == 'email') {
        email = value as String;
      }
      if (key == 'xdaUrl') {
        xdaUrl = value as String;
      }
      if (key == 'gitId') {
        gitId = value as String;
      }
      if (key == 'donationUrl') {
        donationUrl = value as String;
      }
      if (key == 'description') {
        description = value as String;
      }
    });

    return DeveloperModel(
        email, name, photoUrl, xdaUrl, gitId, donationUrl, description);
  }
}
