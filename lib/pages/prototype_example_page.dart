import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../design_patterns/creational/prototype/shape.dart';

class PrototypeExamplePage extends StatefulWidget {
  const PrototypeExamplePage({Key? key}) : super(key: key);

  @override
  _PrototypeExamplePageState createState() => _PrototypeExamplePageState();
}

class _PrototypeExamplePageState extends State<PrototypeExamplePage> {
  final List<Shape> _shapes = [];
  final List<String> _logs = [];
  
  @override
  void initState() {
    super.initState();
    
    // 初始化形狀緩存
    ShapeCache.clearCache();
    ShapeCache.loadCache();
    
    _addLogMessage('已初始化形狀緩存，可以開始克隆形狀了。');
  }
  
  void _addLogMessage(String message) {
    setState(() {
      _logs.add('${DateTime.now().toString().substring(11, 19)} - $message');
    });
  }
  
  void _cloneShape(String shapeId) {
    final Shape? clonedShape = ShapeCache.getShape(shapeId);
    
    if (clonedShape != null) {
      // 給克隆的形狀設置一個略微不同的名稱
      clonedShape.name = '${clonedShape.name} 副本';
      
      // 添加到形狀列表中
      setState(() {
        _shapes.add(clonedShape);
      });
      
      _addLogMessage('已創建形狀: ${clonedShape.getInfo()}');
    }
  }
  
  void _clearShapes() {
    setState(() {
      _shapes.clear();
      _addLogMessage('已清除所有形狀。');
    });
  }
  
  void _modifyShapes() {
    if (_shapes.isEmpty) {
      _addLogMessage('沒有形狀可以修改。');
      return;
    }
    
    setState(() {
      // 對每個形狀做一些隨機修改
      for (var shape in _shapes) {
        final random = math.Random();
        
        if (shape is Circle) {
          final newRadius = 30.0 + random.nextDouble() * 70.0;
          shape.setRadius(newRadius);
          _addLogMessage('修改圓形: ${shape.name} 的半徑為 ${newRadius.toStringAsFixed(2)}');
        } else if (shape is Rectangle) {
          final newWidth = 50.0 + random.nextDouble() * 100.0;
          final newHeight = 30.0 + random.nextDouble() * 80.0;
          shape.setDimensions(newWidth, newHeight);
          _addLogMessage('修改矩形: ${shape.name} 的尺寸為 ${newWidth.toStringAsFixed(2)} x ${newHeight.toStringAsFixed(2)}');
        } else if (shape is Triangle) {
          final newSize = 50.0 + random.nextDouble() * 100.0;
          shape.setSize(newSize);
          _addLogMessage('修改三角形: ${shape.name} 的尺寸為 ${newSize.toStringAsFixed(2)}');
        }
      }
    });
  }
  
  void _createCustomShape() {
    // 隨機創建一個新的自定義形狀並添加到緩存
    final random = math.Random();
    final int shapeType = random.nextInt(3);
    final List<Color> colors = [
      Colors.purple,
      Colors.orange,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
    ];
    final Color randomColor = colors[random.nextInt(colors.length)];
    
    Shape newShape;
    String shapeId;
    
    if (shapeType == 0) {
      // 創建圓形
      newShape = Circle(
        name: '自定義圓形',
        color: randomColor,
        radius: 30.0 + random.nextDouble() * 50.0,
      );
      shapeId = 'customCircle${DateTime.now().millisecondsSinceEpoch}';
    } else if (shapeType == 1) {
      // 創建矩形
      newShape = Rectangle(
        name: '自定義矩形',
        color: randomColor,
        width: 60.0 + random.nextDouble() * 80.0,
        height: 40.0 + random.nextDouble() * 60.0,
      );
      shapeId = 'customRectangle${DateTime.now().millisecondsSinceEpoch}';
    } else {
      // 創建三角形
      newShape = Triangle(
        name: '自定義三角形',
        color: randomColor,
        size: 60.0 + random.nextDouble() * 80.0,
      );
      shapeId = 'customTriangle${DateTime.now().millisecondsSinceEpoch}';
    }
    
    // 添加到緩存
    ShapeCache.addShape(shapeId, newShape);
    _addLogMessage('已創建並添加新形狀到緩存: ${newShape.getInfo()}');
    
    // 克隆並添加到形狀列表
    Shape clonedShape = newShape.clone();
    clonedShape.name = '${clonedShape.name} 實例';
    
    setState(() {
      _shapes.add(clonedShape);
    });
    
    _addLogMessage('已克隆並添加新形狀: ${clonedShape.getInfo()}');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('原型模式示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '原型模式通過複製現有對象來創建新對象，而不是通過實例化類。在本示例中，我們可以從預定義的形狀原型中克隆出新的形狀，並對它們進行修改。',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                
                // 操作按鈕
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _cloneShape('redCircle'),
                      icon: const Icon(Icons.circle, color: Colors.red),
                      label: const Text('克隆紅色圓形'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () => _cloneShape('blueRectangle'),
                      icon: const Icon(Icons.rectangle, color: Colors.blue),
                      label: const Text('克隆藍色矩形'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _cloneShape('greenTriangle'),
                      icon: const Icon(Icons.change_history, color: Colors.green),
                      label: const Text('克隆綠色三角形'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: _createCustomShape,
                      icon: const Icon(Icons.add_circle),
                      label: const Text('創建自定義形狀'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: _modifyShapes,
                      icon: const Icon(Icons.edit),
                      label: const Text('隨機修改形狀'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: _clearShapes,
                      icon: const Icon(Icons.clear_all),
                      label: const Text('清除所有形狀'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade100,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // 形狀顯示區域
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                // 背景
                Container(color: Colors.grey.shade100),
                
                // 形狀列表
                if (_shapes.isEmpty)
                  const Center(
                    child: Text(
                      '點擊上方按鈕來克隆形狀',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: _shapes.map((shape) {
                        return Tooltip(
                          message: shape.getInfo(),
                          child: shape.render(),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // 日誌區域
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade900,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '操作日誌',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: _logs.length,
                      itemBuilder: (context, index) {
                        final logIndex = _logs.length - 1 - index;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 8,
                          ),
                          child: Text(
                            _logs[logIndex],
                            style: const TextStyle(
                              color: Colors.lightGreenAccent,
                              fontSize: 12,
                              fontFamily: 'monospace',
                            ),
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
    );
  }
} 