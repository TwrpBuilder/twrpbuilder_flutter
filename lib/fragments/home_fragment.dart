import 'dart:async';

import 'package:flutter/material.dart';
import 'package:twrp_builder/pages/login_page.dart';
import 'package:twrpbuilder_plugin/twrpbuilder_plugin.dart';

class HomeFragment extends StatefulWidget{

  @override
  _HomeFragmentState createState() => new _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {

  String dirStatus = "";
  ///These are to test the output
  ///
  String loog2;
  String loog3;
  String loog4;
  String loog5;
  String loog6;
  String loog7;
  bool loog8;
  String loog9;

  Future<void> _createDir() async {
    dirStatus = await TwrpbuilderPlugin.mkDir('TWRPBU'); ///TWRPBU is the name of the directory to be created
    await TwrpbuilderPlugin.cp('/system/build.prop', 'TWRPBU/build.prop');
    String log = await TwrpbuilderPlugin.command('ls');
    String log2 = await TwrpbuilderPlugin.getBuildBrand;
    String log3 = await TwrpbuilderPlugin.getBuildBoard;
    String log4 = await TwrpbuilderPlugin.getBuildAbi;
    String log5 = await TwrpbuilderPlugin.getBuildFingerprint;
    String log6 = await TwrpbuilderPlugin.getBuildModel;
    String log7 = await TwrpbuilderPlugin.getBuildProduct;
    bool log8 = await TwrpbuilderPlugin.isOldMtk;
    String log9 = await TwrpbuilderPlugin.suCommand('find /dev/block/platform -type d -name by-name');
    String log10 = await TwrpbuilderPlugin.getRecoveryMount();

    setState(() {
      loog2 = log2;
      loog3 = log3;
      loog4 = log4;
      loog5 = log5;
      loog6 = log6;
      loog7 = log7;
      loog8 = log8;
      loog9 = log9;
    });

    print(dirStatus);
    print(log);
    print(log2);
    print(log3);
    print(log4);
    print(log5);
    print(log6);
    print(log7);
    print(log8);
    print(log9);
    print(log10);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Directory status: $dirStatus'),
            Text('Brand: $loog2'),
            Text('Board: $loog3'),
            Text('Abi: $loog4'),
            Text('Fingerprint: $loog5'),
            Text('Model: $loog6'),
            Text('Product: $loog7'),
            Text('Is old mtk: $loog8'),
            Text('Recovery path: $loog9'),
            MaterialButton(onPressed: _createDir, color: Colors.blue, child: Text('Backup'),),
          ],
        ),
      ),
    );
  }
}
