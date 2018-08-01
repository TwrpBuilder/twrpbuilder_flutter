import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../app_constants.dart';
import '../model/contributors_model.dart';
import '../json_translations.dart';
import 'package:url_launcher/url_launcher.dart';

class ContributeFragment extends StatefulWidget {
  @override
  _ContributeFragmentPage createState() => new _ContributeFragmentPage();
}

class _ContributeFragmentPage extends State<ContributeFragment> {
  List<ContributorsModel> contributorsModel = [];
  @override
  void initState() {
    super.initState();
    loadContributorsData();
  }

  Future<Null> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  loadContributorsData() async {
    var response = await http
        .get(URL_CONTRIBUTORS, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      String responseBody = response.body;
      var jsonBody = json.decode(responseBody);
      for (var data in jsonBody) {
        contributorsModel.add(new ContributorsModel(
            data['login'],
            data['id'],
            data['node_id'],
            data['avatar_url'],
            data['gravatar_id'],
            data['url'],
            data['html_url'],
            data['followers_url'],
            data['following_url'],
            data['gists_url'],
            data['starred_url'],
            data['subscriptions_url'],
            data['organizations_url'],
            data['repos_url'],
            data['events_url'],
            data['received_events_url'],
            data['type'],
            data['site_admin'],
            data['contributions']));
      }
      setState(() {});
    } else {
      print("Failed to load data!");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: DefaultTabController(
          length: 3,
          child: Scaffold(
            body: TabBarView(
              children: [
                contributorsModel.length == 0
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : updateUI()
              ],
            ),
          )),
    );
  }

  Widget updateUI() {
    return ListView.builder(
        itemCount: contributorsModel.length,
        itemBuilder: (_, index) {
          return ListTile(
            leading: Container(
              width: 50.0,
              height: 50.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "${contributorsModel[index].avatar_url}"))),
            ),
            title: Text(contributorsModel[index].login,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500)),
            subtitle: Text(
                'Contributions:  ${contributorsModel[index].contributions.toString()}',
                style: TextStyle(color: Colors.blue, fontSize: 15.0)),
            onTap: () {
              setState(() {
                _launchURL(contributorsModel[index].html_url);
              });
            },
          );
        });
  }
}
