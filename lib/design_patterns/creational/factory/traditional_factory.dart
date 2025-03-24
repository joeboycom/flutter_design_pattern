import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

abstract class PlatformWidgetFactory {
  Widget createWidget();
}

class IOSWidgetFactory extends PlatformWidgetFactory {
  @override
  Widget createWidget() {
    return CupertinoButton(
      child: Text('iOS Button'),
      onPressed: () {},
    );
  }
}

class AndroidWidgetFactory extends PlatformWidgetFactory {
  @override
  Widget createWidget() {
    return ElevatedButton(
      child: Text('Android Button'),
      onPressed: () {},
    );
  }
}

class WebWidgetFactory extends PlatformWidgetFactory {
  @override
  Widget createWidget() {
    return TextButton(
      child: Text('Web Button'),
      onPressed: () {},
    );
  }
}

// Usage in the app
void main() {
  PlatformWidgetFactory widgetFactory;

  if (Platform.isIOS) {
    widgetFactory = IOSWidgetFactory();
  } else if (Platform.isAndroid) {
    widgetFactory = AndroidWidgetFactory();
  } else {
    widgetFactory = WebWidgetFactory();
  }

  Widget myWidget = widgetFactory.createWidget();

  MaterialApp(
    home: Scaffold(
      body: Center(child: myWidget),
    ),
  );
}
