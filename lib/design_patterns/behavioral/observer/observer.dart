import 'dart:math';

// 觀察者接口
abstract class Observer {
  void update(String stockSymbol, double price);
  String getName();
}

// 主題接口
abstract class Subject {
  void registerObserver(Observer observer);
  void removeObserver(Observer observer);
  void notifyObservers();
}

// 具體主題：股票
class Stock implements Subject {
  final String symbol;
  final String name;
  double _price;
  final List<Observer> _observers = [];
  final List<double> _priceHistory = [];
  
  Stock(this.symbol, this.name, this._price) {
    _priceHistory.add(_price);
  }
  
  double get price => _price;
  List<double> get priceHistory => _priceHistory;
  List<Observer> get observers => _observers;
  
  // 設置新價格
  void setPrice(double newPrice) {
    if (_price != newPrice) {
      _price = newPrice;
      _priceHistory.add(newPrice);
      print('$name ($symbol) 價格更新為: \$${newPrice.toStringAsFixed(2)}');
      notifyObservers();
    }
  }
  
  @override
  void registerObserver(Observer observer) {
    if (!_observers.contains(observer)) {
      _observers.add(observer);
      print('${observer.getName()} 開始關注 $name ($symbol)');
    }
  }
  
  @override
  void removeObserver(Observer observer) {
    if (_observers.contains(observer)) {
      _observers.remove(observer);
      print('${observer.getName()} 不再關注 $name ($symbol)');
    }
  }
  
  @override
  void notifyObservers() {
    for (var observer in _observers) {
      observer.update(symbol, _price);
    }
  }
  
  // 隨機波動價格
  void fluctuate(double maxPercentChange) {
    final random = Random();
    final percentChange = (random.nextDouble() * maxPercentChange * 2) - maxPercentChange;
    final newPrice = _price * (1 + percentChange / 100);
    setPrice(newPrice);
  }
}

// 具體觀察者：投資者
class Investor implements Observer {
  final String name;
  final Map<String, double> _stockPrices = {};
  final Map<String, double> _initialPrices = {};
  final List<String> _notifications = [];
  
  Investor(this.name);
  
  Map<String, double> get stockPrices => _stockPrices;
  List<String> get notifications => _notifications;
  
  @override
  String getName() {
    return name;
  }
  
  @override
  void update(String stockSymbol, double price) {
    // 保存初始價格用於計算變化百分比
    if (!_initialPrices.containsKey(stockSymbol)) {
      _initialPrices[stockSymbol] = price;
    }
    
    // 更新當前價格
    final oldPrice = _stockPrices[stockSymbol];
    _stockPrices[stockSymbol] = price;
    
    // 計算價格變化
    final initialPrice = _initialPrices[stockSymbol]!;
    final totalChangePercent = ((price - initialPrice) / initialPrice * 100).toStringAsFixed(2);
    
    // 添加通知
    String changeDesc = '';
    if (oldPrice != null) {
      final changePercent = ((price - oldPrice) / oldPrice * 100);
      final changeDirection = changePercent > 0 ? '上漲' : '下跌';
      changeDesc = ' (${changeDirection}了 ${changePercent.abs().toStringAsFixed(2)}%)';
    }
    
    final notification = '$stockSymbol 價格: \$${price.toStringAsFixed(2)}$changeDesc，總變化: $totalChangePercent%';
    _notifications.add(notification);
    
    print('$name 收到通知: $notification');
  }
}

// 股票市場：管理多個股票
class StockMarket {
  final List<Stock> _stocks = [];
  
  void addStock(Stock stock) {
    _stocks.add(stock);
  }
  
  List<Stock> getStocks() {
    return _stocks;
  }
  
  // 隨機波動所有股票價格
  void fluctuateAllStocks(double maxPercentChange) {
    for (var stock in _stocks) {
      stock.fluctuate(maxPercentChange);
    }
  }
} 