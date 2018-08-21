import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:twrpbuilder_plugin/twrpbuilder_plugin.dart';
import 'package:document_chooser/document_chooser.dart';

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
  bool iSOldMTK;
  String sdcard;

  String backupStatus = "no";

  Future<void> _createBackup() async {
    setState(() {
      backupStatus = 'started';
    });
    bool requestStatus = await SimplePermissions
        .requestPermission(Permission.WriteExternalStorage);

    sdcard = await TwrpbuilderPlugin.getSdCard;

    if (rootStatus) {
      if (requestStatus) {
        dirStatus = await TwrpbuilderPlugin.mkDir('TWRPBuilderF');

        String propData = await TwrpbuilderPlugin.buildProp;
        await TwrpbuilderPlugin
            .createBuildProp('build.prop', propData)
            .whenComplete(() {
          print('build.prop successfully created!');
        }).catchError((e) {
          print('Error: $e');
          setState(() {
            backupStatus = 'failed';
          });
          _showInfoDialog("Backup failed!", e.message);
        });

        String recoveryMount = await TwrpbuilderPlugin.getRecoveryMount();
        print(_isOldMtk());
        print(recoveryMount);

        iSOldMTK = await _isOldMtk();

        if (iSOldMTK) {
          await TwrpbuilderPlugin.suCommand(
              "dd if=$recoveryMount bs=20000000 count=1 of=$sdcard/TWRPBuilderF/recovery.img ; cat /proc/dumchar > $sdcard/TWRPBuilderF/mounts ; cd $sdcard/TWRPBuilderF && tar -c recovery.img build.prop mounts > $sdcard/TWRPBuilderF/TwrpBuilderRecoveryBackup.tar ");
          bool status = await TwrpbuilderPlugin.compressGzipFile(
              '$sdcard/TWRPBuilderF/TwrpBuilderRecoveryBackup.tar ',
              '$sdcard/TWRPBuilderF/TwrpBuilderRecoveryBackup.tar.gz ');
          print('$sdcard/TWRPBuilderF/TwrpBuilderRecoveryBackup.tar ');
          if (!status) {
            _showInfoDialog("Done", "Backup completed!");
            setState(() {
              backupStatus = "done";
            });
          } else {
            setState(() {
              backupStatus = "failed";
            });
            _showInfoDialog("Error!", "Backup failed");
          }
        } else {
          await TwrpbuilderPlugin.suCommand(
              "dd if=$recoveryMount of=$sdcard/TWRPBuilderF/recovery.img ; ls -la `find /dev/block/platform/ -type d -name \"by-name\"` > $sdcard/TWRPBuilderF/mounts ; cd $sdcard/TWRPBuilderF && tar -c recovery.img build.prop mounts > $sdcard/TWRPBuilderF/TwrpBuilderRecoveryBackup.tar ");
          bool status = await TwrpbuilderPlugin.compressGzipFile(
              '$sdcard/TWRPBuilderF/TwrpBuilderRecoveryBackup.tar ',
              '$sdcard/TWRPBuilderF/TwrpBuilderRecoveryBackup.tar.gz ');
          print('$sdcard/TWRPBuilderF/TwrpBuilderRecoveryBackup.tar ');
          if (!status) {
            _showInfoDialog("Done", "Backup completed!");
            setState(() {
              backupStatus = "done";
            });
          } else {
            setState(() {
              backupStatus = "failed";
            });
            _showInfoDialog("Error!", "Backup failed");
          }
        }
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
              content: Text(
                  'Either your device is not rooted or root permissions are not granted.'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _runNonRootMode(requestStatus);
                    },
                    child: Text('Run in non-root mode')),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        backupStatus = "done";
                      });
                    },
                    child: Text('Close')),
              ],
            );
          });
      print('Device is not rooted or root permissions not granted! -_^');
    }
  }

  Future<Null> _runNonRootMode(bool requestStatus) async {
    if (requestStatus) {
      dirStatus = await TwrpbuilderPlugin.mkDir('TWRPBuilderF');
      String propData = await TwrpbuilderPlugin.buildProp;
      await TwrpbuilderPlugin
          .createBuildProp('build.prop', propData)
          .whenComplete(() {
        print('build.prop successfully created!');
        _wait();
      }).catchError((e) {
        print('Error: $e');
        _showInfoDialog("Fatal error", e.message);
        setState(() {
          backupStatus = "failed";
        });
      });
    } else {
      print('Storage permisisons not granted -_^');
    }
  }

  Future _wait() async {
    await _chooseFile();
  }

  _zipFiles() async {
    await TwrpbuilderPlugin.zip(
        "$sdcard/TWRPBuilderF/build.prop,$sdcard/TWRPBuilderF/recovery.img",
        "/TWRPBuilderF/TwrpBuilderRecoveryBackup.zip");
    setState(() {
      backupStatus = "done";
    });
    _showInfoDialog("Backup complete",
        "Please check if $sdcard/TWRPBuilderF/TwrpBuilderRecoveryBackup.zip is there or not");
  }

  _chooseFile() async {
    String path = await DocumentChooser.chooseDocument();

    await _copyFile(path);
    await _zipFiles();

//    await TwrpbuilderPlugin
//        .cp(path, 'TWRPBuilderF/recovery.img')
//        .whenComplete(() {
//          _zipFiles();
//    })
//        .catchError((e) {
//      print('error:$e');
//      _showInfoDialog("Error", e.message);
//      setState(() {
//        backupStatus = "done";
//      });
//    });
  }

  _copyFile(String path) async {
    var recovery = File(path);
    await recovery.copy("$sdcard/TWRPBuilderF/recovery.img");
  }

  Future<bool> _isOldMtk() async {
    return await TwrpbuilderPlugin.isOldMtk;
  }

  Future<Null> _showInfoDialog(String title, String error) async {
    return showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('$title'),
            content: Text('$error'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close')),
            ],
          );
        });
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
          ));
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
            title: Text('Brand',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700)),
            subtitle: Text(_brand,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600)),
          ),
          ListTile(
            title: Text('Board',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700)),
            subtitle: Text(_board,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600)),
          ),
          ListTile(
            title: Text('Model',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700)),
            subtitle: Text(_model,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600)),
          ),
          ListTile(
            title: Text('Product',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700)),
            subtitle: Text(_product,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              backupStatus == "started"
                  ? CircularProgressIndicator()
                  : MaterialButton(
                      onPressed: _createBackup,
                      color: Colors.blue,
                      child: Text('Backup'),
                    ),
            ],
          ),
          ListTile(
            contentPadding: EdgeInsets.all(16.0),
            subtitle: Text(
                "You can make request one time only from this device. If you're facing any issues then please contact via XDA.",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    ));
  }
}
