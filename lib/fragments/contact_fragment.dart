import 'package:flutter/material.dart';
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
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 5.0),
                          child: new FlatButton.icon(
                              onPressed: () => setState(() {
                                _launchURL("https://twrpbuilder.github.io/");
                              }),
                              icon: Icon(Icons.public),
                              label: Text("Official Website", style: TextStyle(color: Colors.black, fontSize: 16.0),)
                          ),
                        )
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0, bottom: 5.0),
                          child: new FlatButton.icon(
                              onPressed: () => setState(() {
                                _launchURL("https://forum.xda-developers.com/android/apps-games/twrpbuilder-t3744253");
                              }),
                              icon: Icon(Icons.web),
                              label: Text("XDA Thread", style: TextStyle(color: Colors.black, fontSize: 16.0),)
                          ),
                        )
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0, bottom: 5.0),
                          child: new FlatButton.icon(
                              onPressed: () => setState(() {
                                _launchURL("https://github.com/TwrpBuilder");
                              }),
                              icon: Icon(Icons.code),
                              label: Text("Source", style: TextStyle(color: Colors.black, fontSize: 16.0),)
                          ),
                        )
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0, bottom: 5.0),
                          child: new FlatButton.icon(
                              onPressed: () => setState(() {
                                _launchURL("https://t.me/TWBuilder");
                              }),
                              icon: Icon(Icons.group),
                              label: Text("Telegram Support", style: TextStyle(color: Colors.black, fontSize: 16.0),)
                          ),
                        )
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0, bottom: 5.0),
                          child: new FlatButton.icon(
                              onPressed: () => setState(() {
                                _launchURL("https://github.com/TWRPBuilder/TWRPBuilder/issues");
                              }),
                              icon: Icon(Icons.bug_report),
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