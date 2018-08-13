import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:twrp_builder/icons/icon_data.dart';
import 'package:twrp_builder/model/developer_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DevListItem extends StatelessWidget {
  final DeveloperModel developerModel;
  final DataSnapshot snapshot;

  DevListItem(this.developerModel, this.snapshot);

  Future<Null> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          new Expanded(
              child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                //margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                height: 220.0,
                width: 320.0,
                child: Card(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 96.0,
                        height: 96.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    "${developerModel.photoUrl}"))),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '${developerModel.name}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.mail),
                              onPressed: () =>
                                  _launchURL("mailto:${developerModel.email}")),
                          IconButton(
                              icon: Icon(github_circle),
                              onPressed: () => _launchURL(
                                  "https://${developerModel.gitId}")),
                          IconButton(
                              icon: Icon(xda),
                              onPressed: () =>
                                  _launchURL("${developerModel.xdaUrl}"))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
