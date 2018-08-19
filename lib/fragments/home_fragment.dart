import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:twrp_builder/pages/login_page.dart';
import 'package:twrpbuilder_plugin/twrpbuilder_plugin.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => new _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String dirStatus = "";

  String _brand;
  String _board;
  String _abi;
  String _fingerPrint;
  String _model;
  String _product;

  bool rootStatus;

  Future<void> _createDir() async {

    if (rootStatus) {
      bool requestStatus = await SimplePermissions
          .requestPermission(Permission.WriteExternalStorage);
      if (requestStatus) {
        _showLoading();

        dirStatus = await TwrpbuilderPlugin.mkDir('TWRPBuilderF');

        await TwrpbuilderPlugin.cp('/system/build.prop', 'TWRPBuilderF/build.prop');
        bool isOldMtk = await TwrpbuilderPlugin.isOldMtk;
        String recoveryMount = await TwrpbuilderPlugin.getRecoveryMount();
        print(isOldMtk);
        print(recoveryMount);
        Navigator.of(context).pop();
      } else {
        print('Storage permissions denied!');
      }
    } else {
      showDialog<Null>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Info'),
              content: Text('Either your device is not rooted or root permissions are not granted.'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Run in non-root mode')),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close')),
              ],
            );
          });
      print('Device is not rooted or root permissions not granted! -_^');
    }
  }

  Future<Null> _showLoading() async {
    return showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Container(
                height: 60.0,
                width: 60.0,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(padding: EdgeInsets.only(left: 8.0, right: 8.0)),
                    Text('Please wait...')
                  ],
                ),
              )
          );
        });
  }

  Future<Null> _loadDeviceDetails() async {
    _showLoading();
    String brand = await TwrpbuilderPlugin.getBuildBrand;
    String board = await TwrpbuilderPlugin.getBuildBoard;
    String abi = await TwrpbuilderPlugin.getBuildAbi;
    String fingerPrint = await TwrpbuilderPlugin.getBuildFingerprint;
    String model = await TwrpbuilderPlugin.getBuildModel;
    String product = await TwrpbuilderPlugin.getBuildProduct;

    setState(() {
      _brand = brand;
      _board = board;
      _abi = abi;
      _fingerPrint = fingerPrint;
      _model = model;
      _product = product;
      Navigator.of(context).pop();
    });
  }

  Future<Null> _loadPrefs() async {
    final SharedPreferences prefs = await _prefs;
    rootStatus = prefs.getBool('isRootGranted');
  }

  @override
  void initState() {
    super.initState();
    _loadDeviceDetails();
    _loadPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ListTile(
              title: Text('Brand', style: TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.w700)),
              subtitle: Text(_brand, style: TextStyle(
                  fontSize: 16.0, fontWeight: FontWeight.w600)),
            ),
            ListTile(
              title: Text('Board', style: TextStyle(
                  fontSize: 16.0, fontWeight: FontWeight.w700)),
              subtitle: Text(_board, style: TextStyle(
                  fontSize: 16.0, fontWeight: FontWeight.w600)),
            ),
            ListTile(
              title: Text('Model', style: TextStyle(
                  fontSize: 16.0, fontWeight: FontWeight.w700)),
              subtitle: Text(_model, style: TextStyle(
                  fontSize: 16.0, fontWeight: FontWeight.w600)),
            ),
            ListTile(
              title: Text('Product', style: TextStyle(
                  fontSize: 16.0, fontWeight: FontWeight.w700)),
              subtitle: Text(_product, style: TextStyle(
                  fontSize: 16.0, fontWeight: FontWeight.w600)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  onPressed: _createDir,
                  color: Colors.blue,
                  child: Text('Backup'),
                ),
              ],
            ),
            ListTile(
              contentPadding: EdgeInsets.all(16.0),
              subtitle: Text("You can make request one time only from this device. If you're facing any issues then please contact via XDA.", style: TextStyle(
                  fontSize: 16.0, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      )
    );
  }
}
