import 'package:flutter/material.dart';
import '../design_patterns/structural/decorator/coffee.dart';
import '../design_patterns/structural/decorator/coffee_decorator.dart';
import '../design_patterns/structural/decorator/specialty_coffee.dart';

class DecoratorExamplePage extends StatefulWidget {
  const DecoratorExamplePage({Key? key}) : super(key: key);

  @override
  _DecoratorExamplePageState createState() => _DecoratorExamplePageState();
}

class _DecoratorExamplePageState extends State<DecoratorExamplePage> {
  Coffee? _coffee;
  int _selectedCoffeeIndex = 0;
  
  bool _withMilk = false;
  bool _withSugar = false;
  bool _withChocolate = false;
  bool _withCinnamon = false;
  
  final List<String> _orderHistory = [];

  // 創建咖啡基礎類型
  Coffee _createBaseCoffee() {
    switch (_selectedCoffeeIndex) {
      case 0:
        return SimpleCoffee();
      case 1:
        return EspressoCoffee();
      case 2:
        return IcedCoffee();
      default:
        return SimpleCoffee();
    }
  }

  // 裝飾咖啡
  Coffee _decorateCoffee(Coffee coffee) {
    Coffee decoratedCoffee = coffee;
    
    if (_withMilk) {
      decoratedCoffee = MilkDecorator(decoratedCoffee);
    }
    
    if (_withSugar) {
      decoratedCoffee = SugarDecorator(decoratedCoffee);
    }
    
    if (_withChocolate) {
      decoratedCoffee = ChocolateDecorator(decoratedCoffee);
    }
    
    if (_withCinnamon) {
      decoratedCoffee = CinnamonDecorator(decoratedCoffee);
    }
    
    return decoratedCoffee;
  }

  void _prepareCoffee() {
    Coffee baseCoffee = _createBaseCoffee();
    _coffee = _decorateCoffee(baseCoffee);
    
    setState(() {
      _orderHistory.insert(0, 
        '${_coffee!.getDescription()} - ¥${_coffee!.getCost().toStringAsFixed(2)}'
      );
      if (_orderHistory.length > 5) {
        _orderHistory.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('裝飾器模式示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '裝飾器模式動態地給對象添加額外的職責。這個例子中，我們將創建一個咖啡訂單系統，可以動態添加配料。',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            
            // 選擇基礎咖啡類型
            const Text('選擇基礎咖啡:', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Radio<int>(
                  value: 0,
                  groupValue: _selectedCoffeeIndex,
                  onChanged: (value) {
                    setState(() {
                      _selectedCoffeeIndex = value!;
                    });
                  },
                ),
                const Text('簡單咖啡 (¥5.00)'),
              ],
            ),
            Row(
              children: [
                Radio<int>(
                  value: 1,
                  groupValue: _selectedCoffeeIndex,
                  onChanged: (value) {
                    setState(() {
                      _selectedCoffeeIndex = value!;
                    });
                  },
                ),
                const Text('意式濃縮咖啡 (¥7.00)'),
              ],
            ),
            Row(
              children: [
                Radio<int>(
                  value: 2,
                  groupValue: _selectedCoffeeIndex,
                  onChanged: (value) {
                    setState(() {
                      _selectedCoffeeIndex = value!;
                    });
                  },
                ),
                const Text('冰咖啡 (¥6.00)'),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // 添加配料
            const Text('添加配料:', style: TextStyle(fontWeight: FontWeight.bold)),
            
            CheckboxListTile(
              title: const Text('牛奶 (+¥2.00)'),
              value: _withMilk,
              onChanged: (value) {
                setState(() {
                  _withMilk = value!;
                });
              },
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
            ),
            
            CheckboxListTile(
              title: const Text('糖 (+¥1.00)'),
              value: _withSugar,
              onChanged: (value) {
                setState(() {
                  _withSugar = value!;
                });
              },
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
            ),
            
            CheckboxListTile(
              title: const Text('巧克力 (+¥3.00)'),
              value: _withChocolate,
              onChanged: (value) {
                setState(() {
                  _withChocolate = value!;
                });
              },
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
            ),
            
            CheckboxListTile(
              title: const Text('肉桂 (+¥1.50)'),
              value: _withCinnamon,
              onChanged: (value) {
                setState(() {
                  _withCinnamon = value!;
                });
              },
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
            ),
            
            const SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: _prepareCoffee,
              child: const Text('製作咖啡'),
            ),
            
            const SizedBox(height: 20),
            
            // 當前咖啡信息
            if (_coffee != null) ...[
              const Divider(),
              Text(
                '當前咖啡: ${_coffee!.getDescription()}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '價格: ¥${_coffee!.getCost().toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Divider(),
            ],
            
            // 訂單歷史
            if (_orderHistory.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text('訂單歷史:', style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView.builder(
                  itemCount: _orderHistory.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      dense: true,
                      leading: const Icon(Icons.coffee, size: 20),
                      title: Text(_orderHistory[index]),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 