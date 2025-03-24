import 'package:flutter/material.dart';
import '../design_patterns/creational/abstract_factory/furniture_factory.dart' as furniture;

class AbstractFactoryExamplePage extends StatefulWidget {
  const AbstractFactoryExamplePage({Key? key}) : super(key: key);

  @override
  _AbstractFactoryExamplePageState createState() => _AbstractFactoryExamplePageState();
}

class _AbstractFactoryExamplePageState extends State<AbstractFactoryExamplePage> {
  final List<furniture.FurnitureFactory> _factories = [
    furniture.ModernFurnitureFactory(),
    furniture.TraditionalFurnitureFactory(),
  ];
  
  int _selectedFactoryIndex = 0;
  
  late furniture.Chair _chair;
  late furniture.Table _table;
  late furniture.Sofa _sofa;
  
  @override
  void initState() {
    super.initState();
    _createFurniture();
  }
  
  void _createFurniture() {
    final factory = _factories[_selectedFactoryIndex];
    _chair = factory.createChair();
    _table = factory.createTable();
    _sofa = factory.createSofa();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('抽象工廠模式示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '抽象工廠模式提供一個介面來創建一系列相關或相互依賴的對象，而無需指定它們的具體類。在本示例中，我們有不同風格（現代和傳統）的家具工廠，每個工廠可以創建配套的椅子、桌子和沙發。',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            
            // 工廠選擇區域
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '選擇家具風格',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(_factories.length, (index) {
                      return RadioListTile<int>(
                        title: Text('${_factories[index].style}家具'),
                        value: index,
                        groupValue: _selectedFactoryIndex,
                        onChanged: (int? value) {
                          if (value != null) {
                            setState(() {
                              _selectedFactoryIndex = value;
                              _createFurniture();
                            });
                          }
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 創建的家具展示
            Text(
              '${_factories[_selectedFactoryIndex].style}家具系列',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 椅子卡片
            _buildProductCard(
              title: '椅子',
              description: _chair.getDescription(),
              icon: Icons.chair,
              color: Colors.blue,
            ),
            
            const SizedBox(height: 12),
            
            // 桌子卡片
            _buildProductCard(
              title: '桌子',
              description: _table.getDescription(),
              icon: Icons.table_bar,
              color: Colors.green,
            ),
            
            const SizedBox(height: 12),
            
            // 沙發卡片
            _buildProductCard(
              title: '沙發',
              description: _sofa.getDescription(),
              icon: Icons.weekend,
              color: Colors.orange,
            ),
            
            const SizedBox(height: 24),
            
            // 代碼示例卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '客戶端代碼示例',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: const Text(
                        '''
// 客戶端代碼
FurnitureFactory factory = ModernFurnitureFactory();
// 或者
// FurnitureFactory factory = TraditionalFurnitureFactory();

// 創建一系列相關的產品
Chair chair = factory.createChair();
Table table = factory.createTable();
Sofa sofa = factory.createSofa();

// 客戶端使用這些產品但不依賴於具體類
print(chair.getDescription());
print(table.getDescription());
print(sofa.getDescription());
''',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProductCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            description,
            style: const TextStyle(height: 1.3),
          ),
        ),
        isThreeLine: true,
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
} 