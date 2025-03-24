import 'dart:math' as math;
import 'package:flutter/material.dart';

// 原型接口：定義克隆方法
abstract class Shape {
  String name;
  Color color;
  
  Shape(this.name, this.color);
  
  Shape clone(); // 克隆方法
  
  Widget render();
  String getInfo();
}

// 具體原型：圓形
class Circle extends Shape {
  double radius;
  
  Circle({
    required String name,
    required Color color,
    required this.radius,
  }) : super(name, color);
  
  // 深度克隆
  @override
  Circle clone() {
    return Circle(
      name: name,
      color: color,
      radius: radius,
    );
  }
  
  @override
  Widget render() {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: color.withOpacity(0.8),
        shape: BoxShape.circle,
      ),
    );
  }
  
  @override
  String getInfo() {
    return '圓形 - 名稱: $name, 顏色: ${colorToHex(color)}, 半徑: ${radius.toStringAsFixed(2)}';
  }
  
  // 修改屬性的方法
  void setRadius(double newRadius) {
    radius = newRadius;
  }
}

// 具體原型：矩形
class Rectangle extends Shape {
  double width;
  double height;
  
  Rectangle({
    required String name,
    required Color color,
    required this.width,
    required this.height,
  }) : super(name, color);
  
  // 深度克隆
  @override
  Rectangle clone() {
    return Rectangle(
      name: name,
      color: color,
      width: width,
      height: height,
    );
  }
  
  @override
  Widget render() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
  
  @override
  String getInfo() {
    return '矩形 - 名稱: $name, 顏色: ${colorToHex(color)}, 寬度: ${width.toStringAsFixed(2)}, 高度: ${height.toStringAsFixed(2)}';
  }
  
  // 修改屬性的方法
  void setDimensions(double newWidth, double newHeight) {
    width = newWidth;
    height = newHeight;
  }
}

// 具體原型：三角形
class Triangle extends Shape {
  double size;
  
  Triangle({
    required String name,
    required Color color,
    required this.size,
  }) : super(name, color);
  
  // 深度克隆
  @override
  Triangle clone() {
    return Triangle(
      name: name,
      color: color,
      size: size,
    );
  }
  
  @override
  Widget render() {
    return CustomPaint(
      size: Size(size, size),
      painter: TrianglePainter(color: color),
    );
  }
  
  @override
  String getInfo() {
    return '三角形 - 名稱: $name, 顏色: ${colorToHex(color)}, 邊長: ${size.toStringAsFixed(2)}';
  }
  
  // 修改屬性的方法
  void setSize(double newSize) {
    size = newSize;
  }
}

// 三角形自定義繪製
class TrianglePainter extends CustomPainter {
  final Color color;
  
  TrianglePainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color.withOpacity(0.8)
      ..style = PaintingStyle.fill;
      
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    
    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// 形狀工廠：管理形狀原型
class ShapeCache {
  static final Map<String, Shape> _shapeCache = {};
  
  static void loadCache() {
    _shapeCache['redCircle'] = Circle(
      name: '紅色圓形',
      color: Colors.red,
      radius: 50,
    );
    
    _shapeCache['blueRectangle'] = Rectangle(
      name: '藍色矩形',
      color: Colors.blue,
      width: 100,
      height: 80,
    );
    
    _shapeCache['greenTriangle'] = Triangle(
      name: '綠色三角形',
      color: Colors.green,
      size: 100,
    );
  }
  
  static Shape? getShape(String shapeId) {
    Shape? cachedShape = _shapeCache[shapeId];
    return cachedShape?.clone();
  }
  
  static void addShape(String shapeId, Shape shape) {
    _shapeCache[shapeId] = shape;
  }
  
  static Map<String, Shape> getAllShapes() {
    return Map.from(_shapeCache);
  }
  
  static void clearCache() {
    _shapeCache.clear();
  }
}

// 輔助函數：顏色轉十六進制
String colorToHex(Color color) {
  return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
} 