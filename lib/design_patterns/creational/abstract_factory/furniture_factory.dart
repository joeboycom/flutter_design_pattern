// 抽象產品：椅子
abstract class Chair {
  String get name;
  String get style;
  String get material;
  double get price;
  String getDescription();
}

// 抽象產品：桌子
abstract class Table {
  String get name;
  String get style;
  String get material;
  double get price;
  String getDescription();
}

// 抽象產品：沙發
abstract class Sofa {
  String get name;
  String get style;
  String get material;
  double get price;
  String getDescription();
}

// 抽象工廠：家具工廠
abstract class FurnitureFactory {
  String get style;
  Chair createChair();
  Table createTable();
  Sofa createSofa();
}

// 具體產品：現代風格椅子
class ModernChair implements Chair {
  @override
  String get name => '現代風格椅子';
  
  @override
  String get style => '現代風格';
  
  @override
  String get material => '金屬與皮革';
  
  @override
  double get price => 1200.0;
  
  @override
  String getDescription() {
    return '$name - $style，由$material製成，簡潔流線型設計，價格：\$${price.toStringAsFixed(2)}';
  }
}

// 具體產品：現代風格桌子
class ModernTable implements Table {
  @override
  String get name => '現代風格桌子';
  
  @override
  String get style => '現代風格';
  
  @override
  String get material => '玻璃與金屬';
  
  @override
  double get price => 2500.0;
  
  @override
  String getDescription() {
    return '$name - $style，由$material製成，幾何圖案設計，價格：\$${price.toStringAsFixed(2)}';
  }
}

// 具體產品：現代風格沙發
class ModernSofa implements Sofa {
  @override
  String get name => '現代風格沙發';
  
  @override
  String get style => '現代風格';
  
  @override
  String get material => '布料與金屬';
  
  @override
  double get price => 3500.0;
  
  @override
  String getDescription() {
    return '$name - $style，由$material製成，時尚極簡，無扶手設計，價格：\$${price.toStringAsFixed(2)}';
  }
}

// 具體產品：傳統風格椅子
class TraditionalChair implements Chair {
  @override
  String get name => '傳統風格椅子';
  
  @override
  String get style => '傳統風格';
  
  @override
  String get material => '實木與布料';
  
  @override
  double get price => 1500.0;
  
  @override
  String getDescription() {
    return '$name - $style，由$material製成，雕花工藝，堅固耐用，價格：\$${price.toStringAsFixed(2)}';
  }
}

// 具體產品：傳統風格桌子
class TraditionalTable implements Table {
  @override
  String get name => '傳統風格桌子';
  
  @override
  String get style => '傳統風格';
  
  @override
  String get material => '實木';
  
  @override
  double get price => 3000.0;
  
  @override
  String getDescription() {
    return '$name - $style，由$material製成，工藝精湛，有抽屜設計，價格：\$${price.toStringAsFixed(2)}';
  }
}

// 具體產品：傳統風格沙發
class TraditionalSofa implements Sofa {
  @override
  String get name => '傳統風格沙發';
  
  @override
  String get style => '傳統風格';
  
  @override
  String get material => '實木與絨布';
  
  @override
  double get price => 4000.0;
  
  @override
  String getDescription() {
    return '$name - $style，由$material製成，舒適柔軟，帶滾邊裝飾，價格：\$${price.toStringAsFixed(2)}';
  }
}

// 具體工廠：現代風格家具工廠
class ModernFurnitureFactory implements FurnitureFactory {
  @override
  String get style => '現代風格';
  
  @override
  Chair createChair() {
    return ModernChair();
  }
  
  @override
  Table createTable() {
    return ModernTable();
  }
  
  @override
  Sofa createSofa() {
    return ModernSofa();
  }
}

// 具體工廠：傳統風格家具工廠
class TraditionalFurnitureFactory implements FurnitureFactory {
  @override
  String get style => '傳統風格';
  
  @override
  Chair createChair() {
    return TraditionalChair();
  }
  
  @override
  Table createTable() {
    return TraditionalTable();
  }
  
  @override
  Sofa createSofa() {
    return TraditionalSofa();
  }
} 