import 'package:flutter/material.dart';
import 'adapter_example_page.dart';
import 'decorator_example_page.dart';
import 'composite_example_page.dart';
import 'proxy_example_page.dart';
import 'facade_example_page.dart';

class StructuralPatternsPage extends StatelessWidget {
  const StructuralPatternsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('結構型模式 (Structural Patterns)'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildPatternItem(
              context,
              '適配器模式 (Adapter)',
              '適配器模式允許不兼容的接口能夠一起工作，它作為兩個不同接口之間的橋樑。',
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdapterExamplePage(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildPatternItem(
              context,
              '裝飾器模式 (Decorator)',
              '裝飾器模式動態地給對象添加額外的職責，比子類更靈活。',
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DecoratorExamplePage(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildPatternItem(
              context,
              '組合模式 (Composite)',
              '組合模式將對象組織成樹形結構，以表示"部分-整體"的層次結構，使單個對象和組合對象的使用具有一致性。',
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CompositeExamplePage(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildPatternItem(
              context,
              '代理模式 (Proxy)',
              '代理模式為其他物件提供一個替身或佔位符，以控制對這個物件的存取。',
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProxyExamplePage(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildPatternItem(
              context,
              '外觀模式 (Facade)',
              '外觀模式提供一個統一的介面，用來存取子系統中的一群介面，簡化複雜系統的使用。',
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FacadeExamplePage(),
                ),
              ),
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
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 