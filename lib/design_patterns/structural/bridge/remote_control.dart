import 'device.dart';

/// 遙控器 - 抽象部分
abstract class RemoteControl {
  final Device _device;
  
  RemoteControl(this._device);
  
  void togglePower() {
    if (_device.isEnabled()) {
      _device.disable();
    } else {
      _device.enable();
    }
  }
  
  void volumeDown() {
    _device.setVolume(_device.getVolume() - 10);
  }
  
  void volumeUp() {
    _device.setVolume(_device.getVolume() + 10);
  }
  
  void channelDown() {
    _device.setChannel(_device.getChannel() - 1);
  }
  
  void channelUp() {
    _device.setChannel(_device.getChannel() + 1);
  }
  
  String getDeviceStatus() {
    return _device.getStatus();
  }
}

/// 基本遙控器 - 具體抽象
class BasicRemote extends RemoteControl {
  BasicRemote(Device device) : super(device);
  
  @override
  String toString() {
    return '基本遙控器';
  }
}

/// 進階遙控器 - 具體抽象
class AdvancedRemote extends RemoteControl {
  AdvancedRemote(Device device) : super(device);
  
  void mute() {
    _device.setVolume(0);
  }
  
  void setChannel(int channel) {
    _device.setChannel(channel);
  }
  
  @override
  String toString() {
    return '進階遙控器';
  }
} 