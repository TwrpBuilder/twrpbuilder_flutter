import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:twrp_builder/model/developer_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../icons/icon_data.dart';
import '../json_translations.dart';
import '../model/completed_model.dart';

class CompletedFragment extends StatefulWidget {
  @override
  _CompletedPage createState() => new _CompletedPage();
}

class _CompletedPage extends State<CompletedFragment> {
  String devEmail = "";
  String devName = "";
  String devPhotoUrl = "";
  String devXdaUrl = "";
  String devGitId = "";
  String devDonationUrl = "";
  String devDescription = "";

  Future<Null> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
      child: FirebaseAnimatedList(
          query: FirebaseDatabase.instance.reference().child('Builds'),
          reverse: false,
          defaultChild: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
          ),
          itemBuilder:
              (_, DataSnapshot snapshot, Animation<double> animation, int x) {
            CompletedModel model = CompletedModel.fromSnapshot(snapshot);
            return showUI(model.Model, model.Board, model.Brand, model.Date,
                model.DeveloperEmail, model.Url);
          }),
    ));
  }

  Widget showUI(String model, String board, String brand, String date,
      String developer, String url) {
    return Card(
      elevation: 3.0,
      shape: BeveledRectangleBorder(),
      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0, bottom: 2.0),
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
                Text(Translations.of(context).text('developer')),
                Padding(padding: EdgeInsets.only(left: 2.0, right: 2.0)),
                Text(': $developer'),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 8.0, bottom: 8.0)),
            Center(
              child: OutlineButton(
                  onPressed: () {
                    //_launchURL(url);
                    _loadDeveloperProfile(developer, brand, model, board, url);
                    //_showBottomSheet(brand, model, board, url);
                  },
                  child: Text(Translations.of(context).text('recovery'))),
            ),
          ],
        ),
      ),
    );
  }

  _showBottomSheet(String brand, String model, String board, String url) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(top: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0, bottom: 10.0)),
                    Text(
                      Translations.of(context).text('model'),
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                    Padding(padding: EdgeInsets.only(left: 2.0, right: 2.0)),
                    Text(
                      ': $model',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0, bottom: 10.0)),
                    Text(
                      Translations.of(context).text('board'),
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                    Padding(padding: EdgeInsets.only(left: 2.0, right: 2.0)),
                    Text(
                      ': $board',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0, bottom: 10.0)),
                    Text(
                      Translations.of(context).text('brand'),
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                    Padding(padding: EdgeInsets.only(left: 2.0, right: 2.0)),
                    Text(
                      ': $brand',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Text(
                  'Developer Profile',
                  style: TextStyle(fontSize: 18.0, color: Colors.blue),
                ),
                Padding(padding: EdgeInsets.only(top: 4.0, bottom: 4.0)),
                ListTile(
                  leading: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage("$devPhotoUrl"))),
                  ),
                  title: Text(devName),
                  subtitle: Text(devDescription),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 8.0, right: 8.0)),
                    IconButton(
                        icon: Icon(
                          Icons.mail,
                          size: 30.0,
                        ),
                        onPressed: () => _launchURL("mailto:$devEmail")),
                    IconButton(
                        icon: Icon(
                          github_circle,
                          size: 30.0,
                        ),
                        onPressed: () => _launchURL("https://$devGitId")),
                    IconButton(
                        icon: Icon(
                          xda,
                          size: 30.0,
                        ),
                        onPressed: () => _launchURL("$devXdaUrl"))
                  ],
                ),
                Center(
                  child: OutlineButton(
                    onPressed: () {
                      //checkStoragePermissions(url);
                      _launchURL(url);
                    },
                    child: Text('Download'),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 8.0, bottom: 8.0)),
              ],
            ),
          );
        });
  }

  Future<Null> _loadDeveloperProfile(String email, brand, model, board, url) async {
    FirebaseDatabase.instance
        .reference()
        .child('Developers')
        .orderByChild('email')
        .equalTo(email);
    Query query = FirebaseDatabase.instance
        .reference()
        .child('Developers')
        .orderByChild('email')
        .equalTo(email);
    query.keepSynced(true);
    await query.once().then((DataSnapshot snapshot) {
      String snapshotValue = snapshot.value.toString();
      print(snapshotValue);

      if(snapshotValue == 'null'){
        print(snapshotValue);
        setState(() {
          devName = "Null";
          devEmail = email;
          devGitId = 'github.com';
          devXdaUrl = "https://www.xda-developers.com/";
          devPhotoUrl = '';
          devDonationUrl = '';
          devDescription = 'Null';
          _showBottomSheet(brand, model, board, url);
        });
      }
      else {
        Map<String, dynamic> devMap = snapshot.value.cast<String, dynamic>();
        devMap.forEach((string, dynamic) {
          DeveloperModel developerModel = parseUser(string, dynamic);
          setState(() {
            devName = developerModel.name;
            devEmail = developerModel.email;
            devGitId = developerModel.gitId;
            devXdaUrl = developerModel.xdaUrl;
            devPhotoUrl = developerModel.photoUrl;
            devDonationUrl = developerModel.donationUrl;
            devDescription = developerModel.description;
            _showBottomSheet(brand, model, board, url);
          });
        });
      }
    });
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
