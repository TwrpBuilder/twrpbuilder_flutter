import 'package:flutter/material.dart';
import 'package:twrp_builder/icons/icon_data.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class ContactFragment extends StatefulWidget {

  @override
  _ContactFragmentState createState() => new _ContactFragmentState();
}

class _ContactFragmentState extends State<ContactFragment> {

  Future<Null> _launchURL(String url) async {

    if (await canLaunch(url)) {
      await launch(url, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: DefaultTabController(
          length: 3,
          child: Scaffold(
            body: TabBarView(
              children: [
                new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
                          child: new FlatButton.icon(
                              onPressed: () => setState(() {
                                _launchURL("https://twrpbuilder.github.io/");
                              }),
                              icon: Icon(Icons.public, size: 30.0,),
                              label: Text("Official Website", style: TextStyle(color: Colors.black, fontSize: 16.0),)
                          ),
                        )
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                          child: new FlatButton.icon(
                              onPressed: () => setState(() {
                                _launchURL("https://forum.xda-developers.com/android/apps-games/twrpbuilder-t3744253");
                              }),
                              icon: Icon(xda, size: 30.0,),
                              label: Text("XDA Thread", style: TextStyle(color: Colors.black, fontSize: 16.0),)
                          ),
                        )
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                          child: new FlatButton.icon(
                              onPressed: () => setState(() {
                                _launchURL("https://github.com/TwrpBuilder");
                              }),
                              icon: Icon(github_circle, size: 30.0,),
                              label: Text("Source", style: TextStyle(color: Colors.black, fontSize: 16.0),)
                          ),
                        )
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                          child: new FlatButton.icon(
                              onPressed: () => setState(() {
                                _launchURL("https://t.me/TWBuilder");
                              }),
                              icon: Icon(telegram, size: 30.0,),
                              label: Text("Telegram Support", style: TextStyle(color: Colors.black, fontSize: 16.0),)
                          ),
                        )
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                          child: new FlatButton.icon(
                              onPressed: () => setState(() {
                                _launchURL("https://github.com/TWRPBuilder/TWRPBuilder/issues");
                              }),
                              icon: Icon(Icons.bug_report , size: 30.0,),
                              label: Text("Report a bug", style: TextStyle(color: Colors.black, fontSize: 16.0),)
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          )
      ),
    );
  }

}