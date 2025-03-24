import 'package:flutter/material.dart';
import '../design_patterns/structural/proxy/image.dart';
import '../design_patterns/structural/proxy/proxy_image.dart';

class ProxyExamplePage extends StatefulWidget {
  const ProxyExamplePage({Key? key}) : super(key: key);

  @override
  _ProxyExamplePageState createState() => _ProxyExamplePageState();
}

class _ProxyExamplePageState extends State<ProxyExamplePage> {
  final List<ProxyImage> _images = [
    ProxyImage('高解析度照片_1.jpg'),
    ProxyImage('使用者頭像.png'),
    ProxyImage('機密文件.jpg', hasAccessPermission: false),
  ];
  
  final List<String> _logs = [];

  void _addLog(String log) {
    setState(() {
      _logs.insert(0, '${DateTime.now().toString().substring(11, 19)} - $log');
      if (_logs.length > 15) {
        _logs.removeLast();
      }
    });
  }

  void _loadImage(int index) {
    if (index >= 0 && index < _images.length) {
      final image = _images[index];
      
      _addLog('嘗試顯示圖片: ${image.filename}');
      
      // 捕獲console輸出並添加到日誌
      void captureLog(String message) {
        _addLog(message);
      }
      
      // 模擬執行並擷取輸出
      if (!image.hasPermission) {
        captureLog('權限不足：無法顯示圖片 ${image.filename}');
      } else {
        if (!image.isLoaded) {
          captureLog('載入圖片：${image.filename}');
          captureLog('${image.filename} 已完成載入');
        }
        captureLog('顯示圖片：${image.filename}');
      }
      
      // 實際呼叫display方法
      image.display();
      
      setState(() {});  // 更新UI
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('代理模式示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '代理模式提供一個替身或佔位符，以控制對原始物件的存取。這個示例展示了一個圖片代理，實現了延遲載入和存取控制功能。',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            
            const Text(
              '可用圖片：',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  final image = _images[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Icon(
                        Icons.image,
                        color: image.hasPermission 
                            ? (image.isLoaded ? Colors.green : Colors.blue)
                            : Colors.red,
                      ),
                      title: Text(image.filename),
                      subtitle: Text(image.getInfo()),
                      trailing: ElevatedButton(
                        onPressed: () => _loadImage(index),
                        child: const Text('載入並顯示'),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            
            const Text(
              '操作日誌：',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: _logs.length,
                  itemBuilder: (context, index) {
                    return Text(
                      _logs[index],
                      style: const TextStyle(color: Colors.green, fontFamily: 'monospace'),
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