/// 設備介面 - 實現部分的抽象
abstract class Device {
  String getName();

  bool isEnabled();

  void enable();

  void disable();

  int getVolume();

  void setVolume(int volume);

  int getChannel();

  void setChannel(int channel);

  String getStatus();
}

/// 電視設備 - 具體實現
class TV implements Device {
  bool _enabled = false;
  int _volume = 30;
  int _channel = 1;

  @override
  String getName() {
    return '電視';
  }

  @override
  bool isEnabled() {
    return _enabled;
  }

  @override
  void enable() {
    _enabled = true;
  }

  @override
  void disable() {
    _enabled = false;
  }

  @override
  int getVolume() {
    return _volume;
  }

  @override
  void setVolume(int volume) {
    if (volume > 100) {
      _volume = 100;
    } else if (volume < 0) {
      _volume = 0;
    } else {
      _volume = volume;
    }
  }

  @override
  int getChannel() {
    return _channel;
  }

  @override
  void setChannel(int channel) {
    _channel = channel;
  }

  @override
  String getStatus() {
    return '''
設備: 電視
電源: ${isEnabled() ? '開啟' : '關閉'}
音量: $_volume
頻道: $_channel
''';
  }
}

/// 收音機設備 - 具體實現
class RadioDevice implements Device {
  bool _enabled = false;
  int _volume = 20;
  int _channel = 1;

  @override
  String getName() {
    return '收音機';
  }

  @override
  bool isEnabled() {
    return _enabled;
  }

  @override
  void enable() {
    _enabled = true;
  }

  @override
  void disable() {
    _enabled = false;
  }

  @override
  int getVolume() {
    return _volume;
  }

  @override
  void setVolume(int volume) {
    if (volume > 100) {
      _volume = 100;
    } else if (volume < 0) {
      _volume = 0;
    } else {
      _volume = volume;
    }
  }

  @override
  int getChannel() {
    return _channel;
  }

  @override
  void setChannel(int channel) {
    _channel = channel;
  }

  @override
  String getStatus() {
    return '''
設備: 收音機
電源: ${isEnabled() ? '開啟' : '關閉'}
音量: $_volume
頻道: $_channel (${_channel * 0.1 + 87.5} MHz)
''';
  }
}
