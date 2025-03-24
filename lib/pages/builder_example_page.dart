import 'package:flutter/material.dart';
import '../design_patterns/creational/builder/computer_builder.dart';

class BuilderExamplePage extends StatefulWidget {
  const BuilderExamplePage({Key? key}) : super(key: key);

  @override
  _BuilderExamplePageState createState() => _BuilderExamplePageState();
}

class _BuilderExamplePageState extends State<BuilderExamplePage> {
  final GamingComputerBuilder _gamingBuilder = GamingComputerBuilder();
  final OfficeComputerBuilder _officeBuilder = OfficeComputerBuilder();
  late ComputerAssembler _assembler;
  late Computer _computer;
  
  String _currentBuilder = '遊戲電腦';
  bool _isCustomizing = false;
  
  // 用於自定義選項的控制器
  final TextEditingController _cpuController = TextEditingController();
  final TextEditingController _memoryController = TextEditingController();
  final TextEditingController _storageController = TextEditingController();
  final TextEditingController _graphicsCardController = TextEditingController();
  final TextEditingController _monitorController = TextEditingController();
  
  bool _hasWifi = true;
  bool _hasBluetooth = true;
  bool _hasWebcam = true;
  
  @override
  void initState() {
    super.initState();
    _assembler = ComputerAssembler(_gamingBuilder);
    _computer = _assembler.buildStandardComputer();
  }
  
  @override
  void dispose() {
    _cpuController.dispose();
    _memoryController.dispose();
    _storageController.dispose();
    _graphicsCardController.dispose();
    _monitorController.dispose();
    super.dispose();
  }
  
  void _switchBuilder(String builderType) {
    setState(() {
      _currentBuilder = builderType;
      
      if (builderType == '遊戲電腦') {
        _assembler.changeBuilder(_gamingBuilder);
      } else {
        _assembler.changeBuilder(_officeBuilder);
      }
      
      _computer = _assembler.buildStandardComputer();
      _isCustomizing = false;
      _resetCustomFields();
    });
  }
  
  void _buildStandardComputer() {
    setState(() {
      _computer = _assembler.buildStandardComputer();
      _isCustomizing = false;
      _resetCustomFields();
    });
  }
  
  void _buildPredefinedComputer(String type) {
    setState(() {
      if (type == '高階遊戲電腦') {
        _computer = _assembler.buildHighEndGamingComputer();
        _currentBuilder = '遊戲電腦';
      } else if (type == '基礎辦公電腦') {
        _computer = _assembler.buildBasicOfficeComputer();
        _currentBuilder = '辦公電腦';
      }
      _isCustomizing = false;
      _resetCustomFields();
    });
  }
  
  void _toggleCustomization() {
    setState(() {
      _isCustomizing = !_isCustomizing;
      if (_isCustomizing) {
        _populateCustomFields();
      }
    });
  }
  
  void _resetCustomFields() {
    _cpuController.text = '';
    _memoryController.text = '';
    _storageController.text = '';
    _graphicsCardController.text = '';
    _monitorController.text = '';
    
    _hasWifi = true;
    _hasBluetooth = true;
    _hasWebcam = true;
  }
  
  void _populateCustomFields() {
    _cpuController.text = _computer.cpu;
    _memoryController.text = _computer.memory;
    _storageController.text = _computer.storage;
    _graphicsCardController.text = _computer.graphicsCard;
    _monitorController.text = _computer.monitor;
    
    _hasWifi = _computer.hasWifi;
    _hasBluetooth = _computer.hasBluetooth;
    _hasWebcam = _computer.hasWebcam;
  }
  
  void _buildCustomComputer() {
    setState(() {
      _computer = _assembler.buildCustomComputer(
        cpu: _cpuController.text.isNotEmpty ? _cpuController.text : null,
        memory: _memoryController.text.isNotEmpty ? _memoryController.text : null,
        storage: _storageController.text.isNotEmpty ? _storageController.text : null,
        graphicsCard: _graphicsCardController.text.isNotEmpty ? _graphicsCardController.text : null,
        monitor: _monitorController.text.isNotEmpty ? _monitorController.text : null,
        hasWifi: _hasWifi,
        hasBluetooth: _hasBluetooth,
        hasWebcam: _hasWebcam,
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('建造者模式示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '建造者模式將複雜對象的構建與其表示分離，使同一構建過程可以創建不同的表示。本示例演示了如何使用不同的建造者來構建計算機，並通過指揮者來控制構建過程。',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            
            // 建造者選擇區域
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '選擇建造者類型',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('遊戲電腦建造者'),
                            value: '遊戲電腦',
                            groupValue: _currentBuilder,
                            onChanged: (value) => _switchBuilder(value!),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('辦公電腦建造者'),
                            value: '辦公電腦',
                            groupValue: _currentBuilder,
                            onChanged: (value) => _switchBuilder(value!),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 操作按鈕區域
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '構建選項',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ElevatedButton(
                          onPressed: _buildStandardComputer,
                          child: const Text('構建標準配置'),
                        ),
                        ElevatedButton(
                          onPressed: () => _buildPredefinedComputer('高階遊戲電腦'),
                          child: const Text('構建高階遊戲電腦'),
                        ),
                        ElevatedButton(
                          onPressed: () => _buildPredefinedComputer('基礎辦公電腦'),
                          child: const Text('構建基礎辦公電腦'),
                        ),
                        ElevatedButton(
                          onPressed: _toggleCustomization,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isCustomizing ? Colors.amber : null,
                          ),
                          child: Text(_isCustomizing ? '取消自定義' : '自定義配置'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            if (_isCustomizing) ...[
              const SizedBox(height: 16),
              
              // 自定義配置區域
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '自定義計算機配置',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      
                      // CPU
                      TextField(
                        controller: _cpuController,
                        decoration: const InputDecoration(
                          labelText: 'CPU',
                          hintText: '例如：Intel Core i7-12700K',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // 記憶體
                      TextField(
                        controller: _memoryController,
                        decoration: const InputDecoration(
                          labelText: '記憶體',
                          hintText: '例如：16GB DDR4 RAM',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // 存儲
                      TextField(
                        controller: _storageController,
                        decoration: const InputDecoration(
                          labelText: '存儲',
                          hintText: '例如：1TB SSD',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // 顯示卡
                      TextField(
                        controller: _graphicsCardController,
                        decoration: const InputDecoration(
                          labelText: '顯示卡',
                          hintText: '例如：NVIDIA RTX 3070',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // 顯示器
                      TextField(
                        controller: _monitorController,
                        decoration: const InputDecoration(
                          labelText: '顯示器',
                          hintText: '例如：27" 2K 144Hz 顯示器',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // 額外選項
                      CheckboxListTile(
                        title: const Text('WiFi'),
                        value: _hasWifi,
                        onChanged: (value) {
                          setState(() {
                            _hasWifi = value!;
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                      CheckboxListTile(
                        title: const Text('藍牙'),
                        value: _hasBluetooth,
                        onChanged: (value) {
                          setState(() {
                            _hasBluetooth = value!;
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                      CheckboxListTile(
                        title: const Text('網路攝影機'),
                        value: _hasWebcam,
                        onChanged: (value) {
                          setState(() {
                            _hasWebcam = value!;
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: 16),
                      
                      ElevatedButton(
                        onPressed: _buildCustomComputer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        child: const Text('應用自定義配置'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            
            const SizedBox(height: 16),
            
            // 計算機預覽區域
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '計算機預覽',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Chip(
                          label: Text(_currentBuilder),
                          backgroundColor: _currentBuilder == '遊戲電腦'
                              ? Colors.redAccent.withOpacity(0.2)
                              : Colors.blueAccent.withOpacity(0.2),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        _computer.toString(),
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 設計模式說明卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '建造者模式的組成部分',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• 產品（Computer）：被構建的複雜對象\n'
                      '• 抽象建造者（ComputerBuilder）：定義創建產品各個部分的抽象接口\n'
                      '• 具體建造者（GamingComputerBuilder, OfficeComputerBuilder）：實現抽象接口，構建產品的各個部分\n'
                      '• 指揮者（ComputerAssembler）：控制建造過程，隱藏產品的組裝細節',
                      style: TextStyle(height: 1.5),
                    ),
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