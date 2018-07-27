# TWRP Builder

A flutter version of [TWRP Builder](https://github.com/TwrpBuilder/TwrpBuilder) app.

This app depends upon flutter plugin [twrpbuilder_plugin](https://pub.dartlang.org/packages/twrpbuilder_plugin) [![pub package](https://img.shields.io/pub/v/twrpbuilder_plugin.svg)](https://pub.dartlang.org/packages/twrpbuilder_plugin)

##### Note: This app is not for iOS, so don't try to build it for iOS devices.

## Implemented
* Google login
* Root access request
* User profile data in Navigation header
* Team details page
* Contact details page
* Logout and Quit

## TODO

* Implement Settings page
* Implement Backup page to backup stock recovery
* Implement Incomplete page - running and in queue
* Implement Complete page to show completed builds
* Implement Reject page to show rejected requests
* Implement Contributors page

## Let's understand Flutter

### Topics
* Stateless and Stateful widgets
* Navigation
* Icon fonts
* Buttons
* Fonts

More topics will be added soon

#### Stateless and Stateful widgets

Everything in Flutter is a widget

##### Stateless widget

A stateless widget has no internal state to manage - never going to change it's state in future.

##### Example code

The code below shows a stateless widget that has static content and will never change in future.

~~~dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo'),
        ),
        body: Center(
          child: Text('Hello!'),
        ),
      ),
    );
  }
}
~~~

##### Stateful widget
    
A stateful widget is dynamic. The user can interact with a stateful widget (by typing into a form, or moving a slider, for example), or it changes over time (perhaps a data feed causes the UI to update).

Example code: Check ```login_page.dart``` [here](/lib/pages/login_page.dart)

#### Navigation

In Android we used to launch another activity using ```Intent``` but in Flutter it's different.
Since there are no activities in Flutter and every screen is a Widget. So we use [Navigator](https://docs.flutter.io/flutter/widgets/Navigator-class.html) here.

Navigator is just like stack, push and pop content. So if we want to launch a Settings screen from current screen then we use:

```dart
Navigator.push(context,
    new MaterialPageRoute(builder: (BuildContext context) {
      return new SettingsPage();
    }));
```

And if we want to go back to previous screen then we use:
```dart
Navigator.pop(context);
```
By default a pushed screen has a back(home) button.

And if we want to replace the current screen with a new one, like we do in Android - replacing login activity with Main activity.

Here we're replacing a loginpage screen with a homepage screen
```dart
Navigator.pushReplacement(context,
    new MaterialPageRoute(builder: (BuildContext context) {
      return new HomePage();
    }));
```

#### Icon fonts
##### What is icon font?
Icon font is a font that has icons :stuck_out_tongue_winking_eye:

How do i create icon fonts? Well you can do that on this website [http://fluttericon.com](http://fluttericon.com)

##### Usage

* Download the font and put it in ```/fonts``` in your project directory.
* Most of the instructions are given in your downloaded font zip.
* And edit your project's ```pubspec.yaml``` like this 
    ```yaml
    flutter: 
        fonts:
             - family: MyFlutterApp #font family name- put the one you've given while creating font
               fonts:
                  - asset: fonts/MyFlutterApp.ttf #your font name
    ```
* Create a dart file with any name e.g. ```icon_data.dart```
* Copy the code from the dart file provided in font zip file, it could be like this:
    ```dart
    import 'package:flutter/material.dart';
    
    const _kFontFam = 'MyFlutterApp';
  
    //These are icon names
    const IconData xda = const IconData(0xe800, fontFamily: _kFontFam);
    const IconData telegram = const IconData(0xe801, fontFamily: _kFontFam);
    const IconData github_circle = const IconData(0xe802, fontFamily: _kFontFam);

    ```
* Now just import your icon dart file e.g ```icon_data.dart``` in your dart file where you want to use icon

    ```dart
    import 'icon_data.dart';
    ...
    
    new FlatButton.icon(
        onPressed: () => setState(() {
            _launchURL("https://github.com/TwrpBuilder");
            }),
        icon: Icon(github_circle, size: 30.0,), //Write your icon name here in place of github_circle
        label: Text("Source", style: TextStyle(color: Colors.black, fontSize: 16.0),)
    ```
    
    
#### Rest of the documentation will be completed soon

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).
