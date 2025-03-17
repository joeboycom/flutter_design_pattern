import 'package:flutter/material.dart';
import '../design_patterns/creational/singleton/singleton.dart';

class SingletonExamplePage extends StatefulWidget {
  const SingletonExamplePage({Key? key}) : super(key: key);

  @override
  State<SingletonExamplePage> createState() => _SingletonExamplePageState();
}

class _SingletonExamplePageState extends State<SingletonExamplePage> {
  final List<String> _logs = [];
  final LoggerSingleton _logger = LoggerSingleton();
  
  @override
  void initState() {
    super.initState();
    _addLog('頁面已初始化');
  }
  
  void _createSingletonInstance() {
    final singleton = Singleton();
    _addLog('創建實例: ${singleton.getInfo()}');
  }
  
  void _resetSingleton() {
    Singleton.reset();
    _addLog('單例已重置');
  }
  
  void _addLog(String message) {
    setState(() {
      _logger.log(message);
      _logs.clear();
      _logs.addAll(_logger.logs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('單例模式'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '單例模式',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '單例模式確保一個類只有一個實例，並提供一個全局訪問點。這在需要協調系統中的操作時特別有用，例如配置管理、連接池、緩存等。',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _createSingletonInstance,
                  child: const Text('創建單例實例'),
                ),
                ElevatedButton(
                  onPressed: _resetSingleton,
                  child: const Text('重置單例'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              '操作日誌:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: _logs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(_logs[index]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 