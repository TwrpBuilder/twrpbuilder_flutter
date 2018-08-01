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
                        leading: Icon(
                          Icons.public,
                          color: Colors.black54,
                        ),
                        title: Text(
                            Translations.of(context).text('official_website'),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500)),
                        onTap: () {
                          setState(() {
                            _launchURL(OfficialWebsite);
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          xda,
                          color: Colors.black54,
                        ),
                        title: Text(Translations.of(context).text('xda_thread'),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500)),
                        onTap: () {
                          setState(() {
                            _launchURL(XdaThread);
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          github_circle,
                          color: Colors.black54,
                        ),
                        title: Text(Translations.of(context).text('source'),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500)),
                        onTap: () {
                          setState(() {
                            _launchURL(GithubSource);
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          telegram,
                          color: Colors.black54,
                        ),
                        title: Text(
                            Translations.of(context).text('telegram_support'),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500)),
                        onTap: () {
                          setState(() {
                            _launchURL(TGramSupport);
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.bug_report,
                          color: Colors.black54,
                        ),
                        title: Text(
                            Translations.of(context).text('report_a_bug'),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500)),
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
          )),
    );
  }
}
