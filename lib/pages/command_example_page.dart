import 'package:flutter/material.dart';
import '../design_patterns/behavioral/command/command.dart';

class CommandExamplePage extends StatefulWidget {
  const CommandExamplePage({Key? key}) : super(key: key);

  @override
  _CommandExamplePageState createState() => _CommandExamplePageState();
}

class _CommandExamplePageState extends State<CommandExamplePage> {
  final RemoteControl _remoteControl = RemoteControl();
  final List<SmartDevice> _devices = [
    SmartDevice('客廳燈'),
    SmartDevice('臥室燈'),
    SmartDevice('廚房燈'),
  ];
  
  int _selectedDeviceIndex = 0;
  final List<String> _logs = [];
  final ScrollController _logScrollController = ScrollController();
  
  // 可用顏色選項
  final List<Color> _availableColors = [
    Colors.white,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
  ];
  
  @override
  void dispose() {
    _logScrollController.dispose();
    super.dispose();
  }
  
  // 添加日誌並滾動到底部
  void _addLog(String log) {
    setState(() {
      _logs.add('[${DateTime.now().toString().split('.').first}] $log');
    });
    
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_logScrollController.hasClients) {
        _logScrollController.animateTo(
          _logScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }
  
  // 執行開啟命令
  void _executeTurnOnCommand() {
    final device = _devices[_selectedDeviceIndex];
    final command = TurnOnCommand(device);
    
    setState(() {
      _remoteControl.executeCommand(command);
      _addLog('執行: ${command.getName()}');
    });
  }
  
  // 執行關閉命令
  void _executeTurnOffCommand() {
    final device = _devices[_selectedDeviceIndex];
    final command = TurnOffCommand(device);
    
    setState(() {
      _remoteControl.executeCommand(command);
      _addLog('執行: ${command.getName()}');
    });
  }
  
  // 執行改變顏色命令
  void _executeChangeColorCommand(Color color) {
    final device = _devices[_selectedDeviceIndex];
    final command = ChangeColorCommand(device, color);
    
    setState(() {
      _remoteControl.executeCommand(command);
      _addLog('執行: ${command.getName()}');
    });
  }
  
  // 執行調整亮度命令
  void _executeSetBrightnessCommand(double brightness) {
    final device = _devices[_selectedDeviceIndex];
    final command = SetBrightnessCommand(device, brightness);
    
    setState(() {
      _remoteControl.executeCommand(command);
      _addLog('執行: ${command.getName()}');
    });
  }
  
  // 撤銷最後的命令
  void _undoLastCommand() {
    setState(() {
      if (_remoteControl.getHistory().isNotEmpty) {
        _addLog('撤銷: ${_remoteControl.getHistory().last.getName()}');
        _remoteControl.undo();
      } else {
        _addLog('沒有可撤銷的命令');
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final selectedDevice = _devices[_selectedDeviceIndex];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('命令模式示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '命令模式將請求封裝為一個對象，從而使你可以用不同的請求對客戶進行參數化，對請求排隊或記錄請求日誌，以及支持可撤銷的操作。',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            
            // 設備選擇區域
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '選擇設備',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    DropdownButton<int>(
                      isExpanded: true,
                      value: _selectedDeviceIndex,
                      items: List.generate(_devices.length, (index) {
                        return DropdownMenuItem<int>(
                          value: index,
                          child: Text(_devices[index].name),
                        );
                      }),
                      onChanged: (value) {
                        setState(() {
                          _selectedDeviceIndex = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '狀態: ${selectedDevice.getStatus()}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 命令執行區域
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 命令按鈕區域
                  Expanded(
                    flex: 3,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '控制命令',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            
                            // 電源控制
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: _executeTurnOnCommand,
                                    icon: const Icon(Icons.power),
                                    label: const Text('開啟'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: _executeTurnOffCommand,
                                    icon: const Icon(Icons.power_off),
                                    label: const Text('關閉'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 16),
                            const Text('調整亮度:'),
                            Slider(
                              value: selectedDevice.brightness,
                              onChanged: (value) {
                                _executeSetBrightnessCommand(value);
                              },
                              divisions: 10,
                              label: '${(selectedDevice.brightness * 100).toInt()}%',
                            ),
                            
                            const SizedBox(height: 16),
                            const Text('選擇顏色:'),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _availableColors.map((color) {
                                final bool isSelected = selectedDevice.color == color;
                                return GestureDetector(
                                  onTap: () => _executeChangeColorCommand(color),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected ? Colors.black : Colors.grey,
                                        width: isSelected ? 3 : 1,
                                      ),
                                      boxShadow: isSelected
                                          ? [BoxShadow(
                                              color: Colors.black.withOpacity(0.3),
                                              blurRadius: 5,
                                              spreadRadius: 1,
                                            )]
                                          : null,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            
                            const Spacer(),
                            
                            // 撤銷按鈕
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _undoLastCommand,
                                icon: const Icon(Icons.undo),
                                label: const Text('撤銷上一個命令'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // 日誌區域
                  Expanded(
                    flex: 2,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              '命令日誌',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(height: 1),
                          Expanded(
                            child: _logs.isEmpty
                                ? const Center(
                                    child: Text('尚無命令執行記錄'),
                                  )
                                : ListView.builder(
                                    controller: _logScrollController,
                                    padding: const EdgeInsets.all(8.0),
                                    itemCount: _logs.length,
                                    itemBuilder: (context, index) {
                                      final log = _logs[index];
                                      Icon icon;
                                      
                                      if (log.contains('執行:')) {
                                        icon = const Icon(Icons.play_arrow, color: Colors.green, size: 18);
                                      } else if (log.contains('撤銷:')) {
                                        icon = const Icon(Icons.undo, color: Colors.orange, size: 18);
                                      } else {
                                        icon = const Icon(Icons.info, color: Colors.blue, size: 18);
                                      }
                                      
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            icon,
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                log,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: log.contains('錯誤') || log.contains('沒有可撤銷的命令')
                                                      ? Colors.red
                                                      : null,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 