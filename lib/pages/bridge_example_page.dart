import 'package:flutter/material.dart';
import '../design_patterns/structural/bridge/device.dart';
import '../design_patterns/structural/bridge/remote_control.dart';

class BridgeExamplePage extends StatefulWidget {
  const BridgeExamplePage({Key? key}) : super(key: key);

  @override
  _BridgeExamplePageState createState() => _BridgeExamplePageState();
}

class _BridgeExamplePageState extends State<BridgeExamplePage> {
  late List<Device> _devices;
  late List<RemoteControl> _remotes;
  
  int _selectedDeviceIndex = 0;
  int _selectedRemoteIndex = 0;
  
  @override
  void initState() {
    super.initState();
    
    // 建立設備
    _devices = [
      TV(),
      RadioDevice(),
    ];
    
    // 建立遙控器，初始都綁定第一個設備
    _remotes = [
      BasicRemote(_devices[0]),
      AdvancedRemote(_devices[0]),
    ];
  }
  
  // 重新設定遙控器綁定的設備
  void _connectRemoteToDevice(int remoteIndex, int deviceIndex) {
    setState(() {
      if (remoteIndex == 0) {
        _remotes[0] = BasicRemote(_devices[deviceIndex]);
      } else {
        _remotes[1] = AdvancedRemote(_devices[deviceIndex]);
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // 取得當前選定的遙控器和設備
    final RemoteControl remote = _remotes[_selectedRemoteIndex];
    final String deviceStatus = remote.getDeviceStatus();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('橋接模式示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '橋接模式將抽象部分與實現部分分離，使它們可以獨立變化。這個示例中，遙控器(抽象)和設備(實現)可以獨立擴展，任何遙控器都可以操作任何設備。',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            
            // 設備和遙控器選擇區域
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '選擇設備：',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          for (int i = 0; i < _devices.length; i++)
                            RadioListTile<int>(
                              title: Text(_devices[i].getName()),
                              value: i,
                              groupValue: _selectedDeviceIndex,
                              onChanged: (value) {
                                setState(() {
                                  _selectedDeviceIndex = value!;
                                  _connectRemoteToDevice(_selectedRemoteIndex, _selectedDeviceIndex);
                                });
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '選擇遙控器：',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          for (int i = 0; i < _remotes.length; i++)
                            RadioListTile<int>(
                              title: Text(_remotes[i].toString()),
                              value: i,
                              groupValue: _selectedRemoteIndex,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRemoteIndex = value!;
                                  _connectRemoteToDevice(_selectedRemoteIndex, _selectedDeviceIndex);
                                });
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // 設備狀態顯示
            Card(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '設備狀態：',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      deviceStatus,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 遙控器按鈕
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_remotes[_selectedRemoteIndex].toString()} 控制面板：',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    
                    // 電源按鈕
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            remote.togglePower();
                          });
                        },
                        icon: const Icon(Icons.power_settings_new),
                        label: const Text('電源'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // 音量控制
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              remote.volumeDown();
                            });
                          },
                          icon: const Icon(Icons.volume_down),
                          label: const Text('音量 -'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              remote.volumeUp();
                            });
                          },
                          icon: const Icon(Icons.volume_up),
                          label: const Text('音量 +'),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // 頻道控制
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              remote.channelDown();
                            });
                          },
                          icon: const Icon(Icons.arrow_downward),
                          label: const Text('頻道 -'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              remote.channelUp();
                            });
                          },
                          icon: const Icon(Icons.arrow_upward),
                          label: const Text('頻道 +'),
                        ),
                      ],
                    ),
                    
                    // 只有進階遙控器才有的額外按鈕
                    if (_selectedRemoteIndex == 1) ...[
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 8),
                      const Text(
                        '進階功能：',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                (remote as AdvancedRemote).mute();
                              });
                            },
                            icon: const Icon(Icons.volume_mute),
                            label: const Text('靜音'),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              // 顯示頻道選擇對話框
                              showDialog(
                                context: context,
                                builder: (context) {
                                  int selectedChannel = 1;
                                  
                                  return AlertDialog(
                                    title: const Text('切換到特定頻道'),
                                    content: TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: '請輸入頻道號碼',
                                      ),
                                      onChanged: (value) {
                                        selectedChannel = int.tryParse(value) ?? 1;
                                      },
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('取消'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            (remote as AdvancedRemote).setChannel(selectedChannel);
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: const Text('確認'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text('快速切換頻道'),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 