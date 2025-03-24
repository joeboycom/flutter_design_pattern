import 'package:flutter/material.dart';

// 命令接口
abstract class Command {
  void execute();
  void undo();
  String getName();
}

// 接收者：智能家居設備
class SmartDevice {
  final String name;
  bool _isOn = false;
  Color _color = Colors.white;
  double _brightness = 1.0;
  
  SmartDevice(this.name);
  
  bool get isOn => _isOn;
  Color get color => _color;
  double get brightness => _brightness;
  
  void turnOn() {
    _isOn = true;
    print('$name 已開啟');
  }
  
  void turnOff() {
    _isOn = false;
    print('$name 已關閉');
  }
  
  void changeColor(Color color) {
    _color = color;
    print('$name 顏色已改變為 ${colorToString(color)}');
  }
  
  void setBrightness(double brightness) {
    _brightness = brightness.clamp(0.0, 1.0);
    print('$name 亮度已設定為 ${(_brightness * 100).toInt()}%');
  }
  
  String colorToString(Color color) {
    if (color == Colors.red) return '紅色';
    if (color == Colors.green) return '綠色';
    if (color == Colors.blue) return '藍色';
    if (color == Colors.yellow) return '黃色';
    if (color == Colors.purple) return '紫色';
    return '白色';
  }
  
  String getStatus() {
    return '${_isOn ? "開啟" : "關閉"} | 亮度: ${(_brightness * 100).toInt()}% | 顏色: ${colorToString(_color)}';
  }
}

// 具體命令：開啟設備
class TurnOnCommand implements Command {
  final SmartDevice device;
  
  TurnOnCommand(this.device);
  
  @override
  void execute() {
    device.turnOn();
  }
  
  @override
  void undo() {
    device.turnOff();
  }
  
  @override
  String getName() {
    return '開啟 ${device.name}';
  }
}

// 具體命令：關閉設備
class TurnOffCommand implements Command {
  final SmartDevice device;
  
  TurnOffCommand(this.device);
  
  @override
  void execute() {
    device.turnOff();
  }
  
  @override
  void undo() {
    device.turnOn();
  }
  
  @override
  String getName() {
    return '關閉 ${device.name}';
  }
}

// 具體命令：改變顏色
class ChangeColorCommand implements Command {
  final SmartDevice device;
  final Color newColor;
  late Color oldColor;
  
  ChangeColorCommand(this.device, this.newColor);
  
  @override
  void execute() {
    oldColor = device.color;
    device.changeColor(newColor);
  }
  
  @override
  void undo() {
    device.changeColor(oldColor);
  }
  
  @override
  String getName() {
    return '設置 ${device.name} 為 ${device.colorToString(newColor)}';
  }
}

// 具體命令：調整亮度
class SetBrightnessCommand implements Command {
  final SmartDevice device;
  final double newBrightness;
  late double oldBrightness;
  
  SetBrightnessCommand(this.device, this.newBrightness);
  
  @override
  void execute() {
    oldBrightness = device.brightness;
    device.setBrightness(newBrightness);
  }
  
  @override
  void undo() {
    device.setBrightness(oldBrightness);
  }
  
  @override
  String getName() {
    return '設置 ${device.name} 亮度為 ${(newBrightness * 100).toInt()}%';
  }
}

// 調用者：遙控器
class RemoteControl {
  final List<Command> _commands = [];
  final List<Command> _history = [];
  
  void executeCommand(Command command) {
    _commands.add(command);
    command.execute();
    _history.add(command);
  }
  
  void undo() {
    if (_history.isNotEmpty) {
      Command command = _history.removeLast();
      command.undo();
    } else {
      print('沒有可撤銷的命令');
    }
  }
  
  List<Command> getCommands() {
    return _commands;
  }
  
  List<Command> getHistory() {
    return _history;
  }
  
  void clearHistory() {
    _history.clear();
  }
} 