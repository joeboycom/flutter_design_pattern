import 'package:flutter/material.dart';
import 'creational_patterns_page.dart';
import 'structural_patterns_page.dart';
import 'behavioral_patterns_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 設計模式示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildPatternCategory(
              context,
              '創建型模式 (Creational Patterns)',
              '對象實例化的模式，通過抽象實例化過程來幫助系統獨立於對象的創建方式。',
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreationalPatternsPage(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildPatternCategory(
              context,
              '結構型模式 (Structural Patterns)',
              '關注類和對象的組合，繼承的概念被用來組合接口和定義組合對象獲得新功能的方式。',
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StructuralPatternsPage(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildPatternCategory(
              context,
              '行為型模式 (Behavioral Patterns)',
              '關注對象之間的通信，描述類或對象間怎樣交互和分配職責。',
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BehavioralPatternsPage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatternCategory(
    BuildContext context,
    String title,
    String description,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
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