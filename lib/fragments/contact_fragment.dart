import 'package:flutter/material.dart';
import 'package:twrp_builder/icons/icon_data.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import '../app_constants.dart';
import '../json_translations.dart';

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
                SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      ListTile(
                        title: Row(
                          children: <Widget>[
                            Icon(Icons.public),
                            Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
                            Text(Translations.of(context).text('official_website'), style: TextStyle(color: Colors.black, fontSize: 16.0))
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _launchURL(OfficialWebsite);
                          });
                        },
                      ),
                      ListTile(
                        title: Row(
                          children: <Widget>[
                            Icon(xda),
                            Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
                            Text(Translations.of(context).text('xda_thread'), style: TextStyle(color: Colors.black, fontSize: 16.0))
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _launchURL(XdaThread);
                          });
                        },
                      ),
                      ListTile(
                        title: Row(
                          children: <Widget>[
                            Icon(github_circle),
                            Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
                            Text(Translations.of(context).text('source'), style: TextStyle(color: Colors.black, fontSize: 16.0))
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _launchURL(GithubSource);
                          });
                        },
                      ),
                      ListTile(
                        title: Row(
                          children: <Widget>[
                            Icon(telegram),
                            Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
                            Text(Translations.of(context).text('telegram_support'), style: TextStyle(color: Colors.black, fontSize: 16.0))
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _launchURL(TGramSupport);
                          });
                        },
                      ),
                      ListTile(
                        title: Row(
                          children: <Widget>[
                            Icon(Icons.bug_report),
                            Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
                            Text(Translations.of(context).text('report_a_bug'), style: TextStyle(color: Colors.black, fontSize: 16.0))
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _launchURL(ReportIssue);
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

}

//new Column(
//mainAxisAlignment: MainAxisAlignment.start,
//children: <Widget>[
//new Row(
//mainAxisAlignment: MainAxisAlignment.start,
//children: <Widget>[
//new Padding(
//padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
//child: new FlatButton.icon(
//onPressed: () => setState(() {
//_launchURL(OfficialWebsite);
//}),
//icon: Icon(Icons.public, size: 30.0,),
//label: Text("Official Website", style: TextStyle(color: Colors.black, fontSize: 16.0),)
//),
//)
//],
//),
//new Row(
//mainAxisAlignment: MainAxisAlignment.start,
//children: <Widget>[
//new Padding(
//padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
//child: new FlatButton.icon(
//onPressed: () => setState(() {
//_launchURL(XdaThread);
//}),
//icon: Icon(xda, size: 30.0,),
//label: Text("XDA Thread", style: TextStyle(color: Colors.black, fontSize: 16.0),)
//),
//)
//],
//),
//new Row(
//mainAxisAlignment: MainAxisAlignment.start,
//children: <Widget>[
//new Padding(
//padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
//child: new FlatButton.icon(
//onPressed: () => setState(() {
//_launchURL(GithubSource);
//}),
//icon: Icon(github_circle, size: 30.0,),
//label: Text("Source", style: TextStyle(color: Colors.black, fontSize: 16.0),)
//),
//)
//],
//),
//new Row(
//mainAxisAlignment: MainAxisAlignment.start,
//children: <Widget>[
//new Padding(
//padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
//child: new FlatButton.icon(
//onPressed: () => setState(() {
//_launchURL(TGramSupport);
//}),
//icon: Icon(telegram, size: 30.0,),
//label: Text("Telegram Support", style: TextStyle(color: Colors.black, fontSize: 16.0),)
//),
//)
//],
//),
//new Row(
//mainAxisAlignment: MainAxisAlignment.start,
//children: <Widget>[
//new Padding(
//padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
//child: new FlatButton.icon(
//onPressed: () => setState(() {
//_launchURL(ReportIssue);
//}),
//icon: Icon(Icons.bug_report , size: 30.0,),
//label: Text("Report a bug", style: TextStyle(color: Colors.black, fontSize: 16.0),)
//),
//)
//],
//)
//],
//)