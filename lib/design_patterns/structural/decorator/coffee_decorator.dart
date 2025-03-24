import 'coffee.dart';

// 咖啡裝飾器基類
abstract class CoffeeDecorator implements Coffee {
  final Coffee _coffee;
  
  CoffeeDecorator(this._coffee);
  
  @override
  String getDescription() {
    return _coffee.getDescription();
  }
  
  @override
  double getCost() {
    return _coffee.getCost();
  }
}

// 具體裝飾器: 牛奶
class MilkDecorator extends CoffeeDecorator {
  MilkDecorator(Coffee coffee) : super(coffee);
  
  @override
  String getDescription() {
    return '${super.getDescription()} + 牛奶';
  }
  
  @override
  double getCost() {
    return super.getCost() + 2.0;
  }
}

// 具體裝飾器: 糖
class SugarDecorator extends CoffeeDecorator {
  SugarDecorator(Coffee coffee) : super(coffee);
  
  @override
  String getDescription() {
    return '${super.getDescription()} + 糖';
  }
  
  @override
  double getCost() {
    return super.getCost() + 1.0;
  }
}

// 具體裝飾器: 巧克力
class ChocolateDecorator extends CoffeeDecorator {
  ChocolateDecorator(Coffee coffee) : super(coffee);
  
  @override
  String getDescription() {
    return '${super.getDescription()} + 巧克力';
  }
  
  @override
  double getCost() {
    return super.getCost() + 3.0;
  }
}

// 具體裝飾器: 肉桂
class CinnamonDecorator extends CoffeeDecorator {
  CinnamonDecorator(Coffee coffee) : super(coffee);
  
  @override
  String getDescription() {
    return '${super.getDescription()} + 肉桂';
  }
  
  @override
  double getCost() {
    return super.getCost() + 1.5;
  }
} 