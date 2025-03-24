import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// 工廠類別
abstract class PlatformWidgetFactory {
  Widget createWidget();

  // 使用 factory 來根據平台返回不同的工廠實例
  factory PlatformWidgetFactory() {
    if (Platform.isIOS) {
      return IOSWidgetFactory();
    } else if (Platform.isAndroid) {
      return AndroidWidgetFactory();
    } else {
      return WebWidgetFactory();
    }
  }
}

class IOSWidgetFactory implements PlatformWidgetFactory {
  @override
  Widget createWidget() {
    return CupertinoButton(
      child: Text('iOS Button'),
      onPressed: () {},
    );
  }
}

class AndroidWidgetFactory implements PlatformWidgetFactory {
  @override
  Widget createWidget() {
    return ElevatedButton(
      child: Text('Android Button'),
      onPressed: () {},
    );
  }
}

class WebWidgetFactory implements PlatformWidgetFactory {
  @override
  Widget createWidget() {
    return TextButton(
      child: Text('Web Button'),
      onPressed: () {},
    );
  }
}

// 使用
void main() {
  final widgetFactory = PlatformWidgetFactory(); // 這裡會自動選擇適合的工廠
  final myWidget = widgetFactory.createWidget();

  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(child: myWidget),
      ),
    ),
  );
}
