import 'package:flutter/material.dart';
import 'singleton_example_page.dart';
import 'factory_example_page.dart';

class CreationalPatternsPage extends StatelessWidget {
  const CreationalPatternsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('創建型模式'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildPatternItem(
              context,
              '單例模式 (Singleton)',
              '確保一個類只有一個實例，並提供全局訪問點。',
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SingletonExamplePage(),
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildPatternItem(
              context,
              '工廠方法模式 (Factory Method)',
              '定義一個用於創建對象的接口，讓子類決定實例化哪一個類。',
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FactoryExamplePage(),
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildPatternItem(
              context,
              '抽象工廠模式 (Abstract Factory)',
              '提供一個創建一系列相關或相互依賴對象的接口，而無需指定它們具體的類。',
              () {},
            ),
            const SizedBox(height: 8),
            _buildPatternItem(
              context,
              '建造者模式 (Builder)',
              '將一個複雜對象的構建與它的表示分離，使得同樣的構建過程可以創建不同的表示。',
              () {},
            ),
            const SizedBox(height: 8),
            _buildPatternItem(
              context,
              '原型模式 (Prototype)',
              '用原型實例指定創建對象的種類，並且通過拷貝這些原型創建新的對象。',
              () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatternItem(
    BuildContext context,
    String title,
    String description,
    VoidCallback onTap,
  ) {
    return Card(
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
} 