// 抽象形狀類
abstract class Shape {
  String get name;
  String draw();
}

// 具體的形狀類 - 圓形
class Circle implements Shape {
  final double radius;
  
  Circle(this.radius);
  
  @override
  String get name => '圓形';
  
  @override
  String draw() {
    return '繪製了一個半徑為 $radius 的圓形';
  }
}

// 具體的形狀類 - 矩形
class Rectangle implements Shape {
  final double width;
  final double height;
  
  Rectangle(this.width, this.height);
  
  @override
  String get name => '矩形';
  
  @override
  String draw() {
    return '繪製了一個 $width x $height 的矩形';
  }
}

// 具體的形狀類 - 三角形
class Triangle implements Shape {
  final double sideA;
  final double sideB;
  final double sideC;
  
  Triangle(this.sideA, this.sideB, this.sideC);
  
  @override
  String get name => '三角形';
  
  @override
  String draw() {
    return '繪製了一個邊長為 $sideA, $sideB, $sideC 的三角形';
  }
}

// 形狀工廠類
class ShapeFactory {
  // 工廠方法，根據類型創建不同的形狀
  static Shape createShape(ShapeType type, Map<String, double> params) {
    switch (type) {
      case ShapeType.circle:
        return Circle(params['radius'] ?? 1.0);
      case ShapeType.rectangle:
        return Rectangle(
          params['width'] ?? 1.0,
          params['height'] ?? 1.0,
        );
      case ShapeType.triangle:
        return Triangle(
          params['sideA'] ?? 1.0,
          params['sideB'] ?? 1.0,
          params['sideC'] ?? 1.0,
        );
      default:
        throw Exception('不支持的形狀類型');
    }
  }
}

// 形狀類型枚舉
enum ShapeType { circle, rectangle, triangle } 