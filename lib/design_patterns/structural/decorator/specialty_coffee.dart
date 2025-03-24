import 'coffee.dart';

// 另一種基礎咖啡實現 - 濃縮咖啡
class EspressoCoffee implements Coffee {
  @override
  String getDescription() {
    return '意式濃縮咖啡';
  }

  @override
  double getCost() {
    return 7.0;
  }
}

// 另一種基礎咖啡實現 - 冰咖啡
class IcedCoffee implements Coffee {
  @override
  String getDescription() {
    return '冰咖啡';
  }

  @override
  double getCost() {
    return 6.0;
  }
} 