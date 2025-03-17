import 'package:flutter/material.dart';
import '../design_patterns/creational/factory/shape_factory.dart';

class FactoryExamplePage extends StatefulWidget {
  const FactoryExamplePage({Key? key}) : super(key: key);

  @override
  State<FactoryExamplePage> createState() => _FactoryExamplePageState();
}

class _FactoryExamplePageState extends State<FactoryExamplePage> {
  final List<String> _logs = [];
  ShapeType _selectedShapeType = ShapeType.circle;
  
  // 形狀參數
  final Map<String, double> _circleParams = {'radius': 5.0};
  final Map<String, double> _rectangleParams = {'width': 10.0, 'height': 5.0};
  final Map<String, double> _triangleParams = {'sideA': 3.0, 'sideB': 4.0, 'sideC': 5.0};
  
  void _createShape() {
    Map<String, double> params;
    switch (_selectedShapeType) {
      case ShapeType.circle:
        params = _circleParams;
        break;
      case ShapeType.rectangle:
        params = _rectangleParams;
        break;
      case ShapeType.triangle:
        params = _triangleParams;
        break;
    }
    
    try {
      final shape = ShapeFactory.createShape(_selectedShapeType, params);
      _addLog('創建了 ${shape.name}: ${shape.draw()}');
    } catch (e) {
      _addLog('錯誤: $e');
    }
  }
  
  void _addLog(String message) {
    setState(() {
      _logs.add(message);
      if (_logs.length > 10) {
        _logs.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('工廠方法模式'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '工廠方法模式',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '工廠方法模式定義一個用於創建對象的接口，讓子類決定實例化哪一個類。Factory Method使一個類的實例化延遲到其子類。',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            
            // 形狀選擇
            const Text(
              '選擇要創建的形狀:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButton<ShapeType>(
              value: _selectedShapeType,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedShapeType = value;
                  });
                }
              },
              items: const [
                DropdownMenuItem(
                  value: ShapeType.circle,
                  child: Text('圓形'),
                ),
                DropdownMenuItem(
                  value: ShapeType.rectangle,
                  child: Text('矩形'),
                ),
                DropdownMenuItem(
                  value: ShapeType.triangle,
                  child: Text('三角形'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // 參數顯示
            if (_selectedShapeType == ShapeType.circle)
              Text('半徑: ${_circleParams['radius']}')
            else if (_selectedShapeType == ShapeType.rectangle)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('寬度: ${_rectangleParams['width']}'),
                  Text('高度: ${_rectangleParams['height']}'),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('邊A: ${_triangleParams['sideA']}'),
                  Text('邊B: ${_triangleParams['sideB']}'),
                  Text('邊C: ${_triangleParams['sideC']}'),
                ],
              ),
            
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _createShape,
              child: const Text('創建形狀'),
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