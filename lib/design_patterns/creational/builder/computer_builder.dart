// 產品：計算機
class Computer {
  final String cpu;
  final String memory;
  final String storage;
  final String graphicsCard;
  final String monitor;
  final String operatingSystem;
  final String keyboard;
  final String mouse;
  final bool hasWifi;
  final bool hasBluetooth;
  final bool hasWebcam;
  
  Computer({
    required this.cpu,
    required this.memory,
    required this.storage,
    required this.graphicsCard,
    required this.monitor,
    required this.operatingSystem,
    required this.keyboard,
    required this.mouse,
    required this.hasWifi,
    required this.hasBluetooth,
    required this.hasWebcam,
  });
  
  @override
  String toString() {
    return '''
計算機配置：
  CPU: $cpu
  記憶體: $memory
  存儲: $storage
  顯示卡: $graphicsCard
  顯示器: $monitor
  作業系統: $operatingSystem
  鍵盤: $keyboard
  滑鼠: $mouse
  WiFi: ${hasWifi ? '有' : '無'}
  藍牙: ${hasBluetooth ? '有' : '無'}
  網路攝影機: ${hasWebcam ? '有' : '無'}
''';
  }
}

// 抽象建造者
abstract class ComputerBuilder {
  setCpu(String cpu);
  setMemory(String memory);
  setStorage(String storage);
  setGraphicsCard(String graphicsCard);
  setMonitor(String monitor);
  setOperatingSystem(String operatingSystem);
  setKeyboard(String keyboard);
  setMouse(String mouse);
  setWifi(bool hasWifi);
  setBluetooth(bool hasBluetooth);
  setWebcam(bool hasWebcam);
  Computer build();
}

// 具體建造者：高階電競計算機建造者
class GamingComputerBuilder implements ComputerBuilder {
  String _cpu = 'Intel Core i9-12900K';
  String _memory = '32GB DDR5 RAM';
  String _storage = '2TB NVMe SSD';
  String _graphicsCard = 'NVIDIA RTX 4090';
  String _monitor = '32" 4K 240Hz 曲面顯示器';
  String _operatingSystem = 'Windows 11 Pro';
  String _keyboard = '機械式RGB鍵盤';
  String _mouse = '高精度遊戲滑鼠';
  bool _hasWifi = true;
  bool _hasBluetooth = true;
  bool _hasWebcam = true;
  
  @override
  setCpu(String cpu) {
    this._cpu = cpu;
    return this;
  }
  
  @override
  setMemory(String memory) {
    this._memory = memory;
    return this;
  }
  
  @override
  setStorage(String storage) {
    this._storage = storage;
    return this;
  }
  
  @override
  setGraphicsCard(String graphicsCard) {
    this._graphicsCard = graphicsCard;
    return this;
  }
  
  @override
  setMonitor(String monitor) {
    this._monitor = monitor;
    return this;
  }
  
  @override
  setOperatingSystem(String operatingSystem) {
    this._operatingSystem = operatingSystem;
    return this;
  }
  
  @override
  setKeyboard(String keyboard) {
    this._keyboard = keyboard;
    return this;
  }
  
  @override
  setMouse(String mouse) {
    this._mouse = mouse;
    return this;
  }
  
  @override
  setWifi(bool hasWifi) {
    this._hasWifi = hasWifi;
    return this;
  }
  
  @override
  setBluetooth(bool hasBluetooth) {
    this._hasBluetooth = hasBluetooth;
    return this;
  }
  
  @override
  setWebcam(bool hasWebcam) {
    this._hasWebcam = hasWebcam;
    return this;
  }
  
  @override
  Computer build() {
    return Computer(
      cpu: _cpu,
      memory: _memory,
      storage: _storage,
      graphicsCard: _graphicsCard,
      monitor: _monitor,
      operatingSystem: _operatingSystem,
      keyboard: _keyboard,
      mouse: _mouse,
      hasWifi: _hasWifi,
      hasBluetooth: _hasBluetooth,
      hasWebcam: _hasWebcam,
    );
  }
}

// 具體建造者：辦公計算機建造者
class OfficeComputerBuilder implements ComputerBuilder {
  String _cpu = 'Intel Core i5-12400';
  String _memory = '16GB DDR4 RAM';
  String _storage = '512GB SSD';
  String _graphicsCard = '整合式顯示卡';
  String _monitor = '24" 1080p 60Hz 顯示器';
  String _operatingSystem = 'Windows 11 Home';
  String _keyboard = '標準鍵盤';
  String _mouse = '標準滑鼠';
  bool _hasWifi = true;
  bool _hasBluetooth = true;
  bool _hasWebcam = true;
  
  @override
  setCpu(String cpu) {
    this._cpu = cpu;
    return this;
  }
  
  @override
  setMemory(String memory) {
    this._memory = memory;
    return this;
  }
  
  @override
  setStorage(String storage) {
    this._storage = storage;
    return this;
  }
  
  @override
  setGraphicsCard(String graphicsCard) {
    this._graphicsCard = graphicsCard;
    return this;
  }
  
  @override
  setMonitor(String monitor) {
    this._monitor = monitor;
    return this;
  }
  
  @override
  setOperatingSystem(String operatingSystem) {
    this._operatingSystem = operatingSystem;
    return this;
  }
  
  @override
  setKeyboard(String keyboard) {
    this._keyboard = keyboard;
    return this;
  }
  
  @override
  setMouse(String mouse) {
    this._mouse = mouse;
    return this;
  }
  
  @override
  setWifi(bool hasWifi) {
    this._hasWifi = hasWifi;
    return this;
  }
  
  @override
  setBluetooth(bool hasBluetooth) {
    this._hasBluetooth = hasBluetooth;
    return this;
  }
  
  @override
  setWebcam(bool hasWebcam) {
    this._hasWebcam = hasWebcam;
    return this;
  }
  
  @override
  Computer build() {
    return Computer(
      cpu: _cpu,
      memory: _memory,
      storage: _storage,
      graphicsCard: _graphicsCard,
      monitor: _monitor,
      operatingSystem: _operatingSystem,
      keyboard: _keyboard,
      mouse: _mouse,
      hasWifi: _hasWifi,
      hasBluetooth: _hasBluetooth,
      hasWebcam: _hasWebcam,
    );
  }
}

// 指揮者：計算機組裝人員
class ComputerAssembler {
  ComputerBuilder _builder;
  
  ComputerAssembler(this._builder);
  
  void changeBuilder(ComputerBuilder builder) {
    _builder = builder;
  }
  
  // 組裝默認配置的計算機
  Computer buildStandardComputer() {
    return _builder.build();
  }
  
  // 組裝自定義配置的計算機
  Computer buildCustomComputer({
    String? cpu,
    String? memory,
    String? storage,
    String? graphicsCard,
    String? monitor,
    String? operatingSystem,
    String? keyboard,
    String? mouse,
    bool? hasWifi,
    bool? hasBluetooth,
    bool? hasWebcam,
  }) {
    if (cpu != null) _builder.setCpu(cpu);
    if (memory != null) _builder.setMemory(memory);
    if (storage != null) _builder.setStorage(storage);
    if (graphicsCard != null) _builder.setGraphicsCard(graphicsCard);
    if (monitor != null) _builder.setMonitor(monitor);
    if (operatingSystem != null) _builder.setOperatingSystem(operatingSystem);
    if (keyboard != null) _builder.setKeyboard(keyboard);
    if (mouse != null) _builder.setMouse(mouse);
    if (hasWifi != null) _builder.setWifi(hasWifi);
    if (hasBluetooth != null) _builder.setBluetooth(hasBluetooth);
    if (hasWebcam != null) _builder.setWebcam(hasWebcam);
    
    return _builder.build();
  }
  
  // 快速組裝高階配置的電競計算機
  Computer buildHighEndGamingComputer() {
    if (_builder is! GamingComputerBuilder) {
      _builder = GamingComputerBuilder();
    }
    
    return _builder
      .setCpu('AMD Ryzen 9 7950X')
      .setMemory('64GB DDR5 6000MHz RAM')
      .setStorage('4TB NVMe SSD')
      .setGraphicsCard('NVIDIA RTX 4090 OC Edition')
      .setMonitor('34" 5K 360Hz 曲面顯示器')
      .build();
  }
  
  // 快速組裝基礎配置的辦公計算機
  Computer buildBasicOfficeComputer() {
    if (_builder is! OfficeComputerBuilder) {
      _builder = OfficeComputerBuilder();
    }
    
    return _builder
      .setCpu('Intel Core i3-12100')
      .setMemory('8GB DDR4 RAM')
      .setStorage('256GB SSD')
      .setMonitor('22" 1080p 顯示器')
      .build();
  }
} 