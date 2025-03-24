import 'package:flutter/material.dart';
import 'command_example_page.dart';
import 'observer_example_page.dart';

class BehavioralPatternsPage extends StatelessWidget {
  const BehavioralPatternsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('行為模式'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          _buildPatternItem(
            context,
            title: '命令模式',
            description: '將請求封裝為對象，從而使你可以用不同的請求對客戶進行參數化，對請求排隊或記錄請求日誌，以及支持可撤銷的操作。',
            navigateTo: const CommandExamplePage(),
          ),
          _buildPatternItem(
            context,
            title: '觀察者模式',
            description: '定義了一種一對多的依賴關係，讓多個觀察者對象同時監聽某一個主題對象，當主題對象狀態發生變化時，會通知所有觀察者對象。',
            navigateTo: const ObserverExamplePage(),
          ),
          _buildComingSoonPatternItem(
            context,
            title: '策略模式',
            description: '定義了一系列算法，並將每個算法封裝起來，使它們可以相互替換，讓算法的變化獨立於使用算法的客戶。',
          ),
          _buildComingSoonPatternItem(
            context,
            title: '模板方法模式',
            description: '定義一個操作中的算法骨架，而將一些步驟延遲到子類中，使得子類可以不改變算法結構即可重新定義該算法的某些特定步驟。',
          ),
          _buildComingSoonPatternItem(
            context,
            title: '迭代器模式',
            description: '提供一種方法順序訪問一個聚合對象中的各個元素，而又不暴露該對象的內部表示。',
          ),
          _buildComingSoonPatternItem(
            context,
            title: '狀態模式',
            description: '允許對象在內部狀態改變時改變其行為，對象看起來好像修改了它的類。',
          ),
          _buildComingSoonPatternItem(
            context,
            title: '責任鏈模式',
            description: '避免請求發送者與接收者耦合在一起，讓多個對象都有可能接收請求，將這些對象連接成一條鏈，並且沿著這條鏈傳遞請求，直到有對象處理它為止。',
          ),
          _buildComingSoonPatternItem(
            context,
            title: '中介者模式',
            description: '用一個中介對象來封裝一系列的對象交互，中介者使各對象不需要顯式地相互引用，從而使其耦合松散，而且可以獨立地改變它們之間的交互。',
          ),
          _buildComingSoonPatternItem(
            context,
            title: '訪問者模式',
            description: '表示一個作用於某對象結構中的各元素的操作，它使你可以在不改變各元素類的前提下定義作用於這些元素的新操作。',
          ),
          _buildComingSoonPatternItem(
            context,
            title: '解釋器模式',
            description: '給定一個語言，定義它的文法的一種表示，並定義一個解釋器，這個解釋器使用該表示來解釋語言中的句子。',
          ),
          _buildComingSoonPatternItem(
            context,
            title: '備忘錄模式',
            description: '在不破壞封裝性的前提下，捕獲一個對象的內部狀態，並在該對象之外保存這個狀態，以便之後恢復對象到原先保存的狀態。',
          ),
        ],
      ),
    );
  }

  Widget _buildPatternItem(
    BuildContext context, {
    required String title,
    required String description,
    required Widget navigateTo,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => navigateTo),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, size: 16.0),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(description),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComingSoonPatternItem(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      color: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                const Icon(
                  Icons.hourglass_empty,
                  color: Colors.grey,
                ),
                const SizedBox(width: 8.0),
                Text(
                  '$title (即將推出)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
} 