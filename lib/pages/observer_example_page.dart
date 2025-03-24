import 'dart:async';
import 'package:flutter/material.dart';
import '../design_patterns/behavioral/observer/observer.dart';
import 'package:fl_chart/fl_chart.dart';

class ObserverExamplePage extends StatefulWidget {
  const ObserverExamplePage({Key? key}) : super(key: key);

  @override
  _ObserverExamplePageState createState() => _ObserverExamplePageState();
}

class _ObserverExamplePageState extends State<ObserverExamplePage> {
  late StockMarket _stockMarket;
  late List<Investor> _investors;
  
  Timer? _timer;
  final ScrollController _notificationController = ScrollController();
  int _selectedInvestorIndex = 0;
  
  @override
  void initState() {
    super.initState();
    _initializeExample();
  }
  
  void _initializeExample() {
    // 創建股票市場和股票
    _stockMarket = StockMarket();
    _stockMarket.addStock(Stock('AAPL', '蘋果公司', 185.92));
    _stockMarket.addStock(Stock('MSFT', '微軟公司', 378.85));
    _stockMarket.addStock(Stock('GOOGL', '谷歌公司', 138.21));
    _stockMarket.addStock(Stock('AMZN', '亞馬遜', 178.62));
    
    // 創建投資者
    _investors = [
      Investor('張先生'),
      Investor('李小姐'),
      Investor('王先生'),
    ];
    
    // 默認訂閱關係
    _investors[0].update('AAPL', _stockMarket.getStocks()[0].price);
    _investors[0].update('MSFT', _stockMarket.getStocks()[1].price);
    _stockMarket.getStocks()[0].registerObserver(_investors[0]);
    _stockMarket.getStocks()[1].registerObserver(_investors[0]);
    
    _investors[1].update('AAPL', _stockMarket.getStocks()[0].price);
    _investors[1].update('GOOGL', _stockMarket.getStocks()[2].price);
    _stockMarket.getStocks()[0].registerObserver(_investors[1]);
    _stockMarket.getStocks()[2].registerObserver(_investors[1]);
    
    _investors[2].update('MSFT', _stockMarket.getStocks()[1].price);
    _investors[2].update('AMZN', _stockMarket.getStocks()[3].price);
    _stockMarket.getStocks()[1].registerObserver(_investors[2]);
    _stockMarket.getStocks()[3].registerObserver(_investors[2]);
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    _notificationController.dispose();
    super.dispose();
  }
  
  // 開始自動更新股票價格
  void _startStockUpdates() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted) {
        setState(() {
          _stockMarket.fluctuateAllStocks(2.0); // 最多2%的波動
        });
        
        // 自動滾動到通知列表底部
        if (_notificationController.hasClients) {
          _notificationController.animateTo(
            _notificationController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      }
    });
  }
  
  // 停止自動更新
  void _stopStockUpdates() {
    _timer?.cancel();
    _timer = null;
  }
  
  // 手動更新所有股票價格
  void _manuallyUpdateStocks() {
    setState(() {
      _stockMarket.fluctuateAllStocks(3.0); // 最多3%的波動
    });
    
    // 滾動到通知列表底部
    if (_notificationController.hasClients) {
      _notificationController.animateTo(
        _notificationController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
  
  // 訂閱或取消訂閱股票
  void _toggleSubscription(Stock stock, Investor investor) {
    setState(() {
      if (stock.observers.any((obs) => obs.getName() == investor.getName())) {
        stock.removeObserver(investor);
      } else {
        stock.registerObserver(investor);
        investor.update(stock.symbol, stock.price);
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final selectedInvestor = _investors[_selectedInvestorIndex];
    final stocks = _stockMarket.getStocks();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('觀察者模式示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // 開始/停止更新按鈕
          _timer == null
              ? IconButton(
                  icon: const Icon(Icons.play_arrow),
                  tooltip: '開始自動更新',
                  onPressed: _startStockUpdates,
                )
              : IconButton(
                  icon: const Icon(Icons.stop),
                  tooltip: '停止自動更新',
                  onPressed: _stopStockUpdates,
                ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '手動更新',
            onPressed: _manuallyUpdateStocks,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '觀察者模式定義了一種一對多的依賴關係，讓多個觀察者對象同時監聽某一個主題對象。當主題對象狀態發生變化時，會通知所有觀察者對象，使它們自動更新。',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 左側股票列表
                  Expanded(
                    flex: 3,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '股票市場（主題）',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: ListView.builder(
                                itemCount: stocks.length,
                                itemBuilder: (context, index) {
                                  final stock = stocks[index];
                                  final isSubscribed = stock.observers.any(
                                    (obs) => obs.getName() == selectedInvestor.getName()
                                  );
                                  
                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    color: isSubscribed ? Colors.green.shade50 : null,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${stock.name} (${stock.symbol})',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      '價格: \$${stock.price.toStringAsFixed(2)}',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: stock.priceHistory.length > 1
                                                            ? stock.price > stock.priceHistory[stock.priceHistory.length - 2]
                                                                ? Colors.green
                                                                : Colors.red
                                                            : null,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ElevatedButton.icon(
                                                onPressed: () => _toggleSubscription(stock, selectedInvestor),
                                                icon: Icon(
                                                  isSubscribed ? Icons.notifications_active : Icons.notifications_none,
                                                ),
                                                label: Text(isSubscribed ? '取消關注' : '關注'),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: isSubscribed ? Colors.orange : Colors.blue,
                                                  foregroundColor: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          if (stock.priceHistory.length > 1)
                                            SizedBox(
                                              height: 80,
                                              child: LineChart(
                                                LineChartData(
                                                  gridData: FlGridData(show: false),
                                                  titlesData: FlTitlesData(show: false),
                                                  borderData: FlBorderData(show: false),
                                                  lineBarsData: [
                                                    LineChartBarData(
                                                      spots: List.generate(
                                                        stock.priceHistory.length, 
                                                        (i) => FlSpot(i.toDouble(), stock.priceHistory[i].toDouble())
                                                      ),
                                                      isCurved: true,
                                                      color: stock.price >= stock.priceHistory[0] ? Colors.green : Colors.red,
                                                      barWidth: 3,
                                                      dotData: FlDotData(show: false),
                                                      belowBarData: BarAreaData(
                                                        show: true,
                                                        color: (stock.price >= stock.priceHistory[0] ? Colors.green : Colors.red).withOpacity(0.15),
                                                      ),
                                                    ),
                                                  ],
                                                  lineTouchData: LineTouchData(enabled: false),
                                                ),
                                              ),
                                            ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                '關注者: ${stock.observers.length}',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
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
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // 右側投資者和通知
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // 投資者選擇區域
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '選擇投資者（觀察者）',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                DropdownButton<int>(
                                  isExpanded: true,
                                  value: _selectedInvestorIndex,
                                  items: List.generate(_investors.length, (index) {
                                    return DropdownMenuItem<int>(
                                      value: index,
                                      child: Text(_investors[index].getName()),
                                    );
                                  }),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedInvestorIndex = value!;
                                    });
                                  },
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '關注股票: ${selectedInvestor.stockPrices.keys.join(', ')}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // 通知區域
                        Expanded(
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    '股票更新通知',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Divider(height: 1),
                                Expanded(
                                  child: selectedInvestor.notifications.isEmpty
                                      ? const Center(
                                          child: Text('尚無通知'),
                                        )
                                      : ListView.separated(
                                          controller: _notificationController,
                                          padding: const EdgeInsets.all(12.0),
                                          itemCount: selectedInvestor.notifications.length,
                                          separatorBuilder: (context, index) => const Divider(),
                                          itemBuilder: (context, index) {
                                            final notification = selectedInvestor.notifications[index];
                                            
                                            Color textColor = Colors.black;
                                            if (notification.contains('上漲')) {
                                              textColor = Colors.green;
                                            } else if (notification.contains('下跌')) {
                                              textColor = Colors.red;
                                            }
                                            
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                                              child: Text(
                                                notification,
                                                style: TextStyle(color: textColor),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 