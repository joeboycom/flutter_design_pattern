// 咖啡接口
abstract class Coffee {
  String getDescription();
  double getCost();
}

// 基础咖啡实现
class SimpleCoffee implements Coffee {
  @override
  String getDescription() {
    return '簡單咖啡';
  }

  @override
  double getCost() {
    return 5.0;
  }
} 