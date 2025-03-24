import 'package:flutter/material.dart';
import '../design_patterns/structural/flyweight/tree.dart';
import 'dart:async';

class FlyweightExamplePage extends StatefulWidget {
  const FlyweightExamplePage({Key? key}) : super(key: key);

  @override
  _FlyweightExamplePageState createState() => _FlyweightExamplePageState();
}

class _FlyweightExamplePageState extends State<FlyweightExamplePage> {
  final Forest _forest = Forest();
  final ScrollController _scrollController = ScrollController();
  
  int _treesToPlant = 100;
  List<String> _logs = [];
  
  @override
  void initState() {
    super.initState();
    _resetExample();
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  
  void _resetExample() {
    setState(() {
      _forest.clear();
      _logs = ['已重置森林'];
    });
  }
  
  void _plantTrees() {
    // 記錄開始時間
    final startTime = DateTime.now();
    final memoryBefore = _forest.getTreeCount();
    final typesBefore = TreeFactory.getTreeTypesCount();
    
    setState(() {
      _logs.add('開始種植 $_treesToPlant 棵樹...');
      
      // 直接調用而不使用Zone
      _forest.plantRandomTrees(_treesToPlant, 400, 600);
      
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);
      final memoryAfter = _forest.getTreeCount();
      final typesAfter = TreeFactory.getTreeTypesCount();
      
      _logs.add('完成種植 $_treesToPlant 棵樹！');
      _logs.add('總耗時：${duration.inMilliseconds} 毫秒');
      _logs.add('總樹木數量：$memoryAfter (增加 ${memoryAfter - memoryBefore} 棵)');
      _logs.add('不同樹種類數量：$typesAfter (增加 ${typesAfter - typesBefore} 種)');
      _logs.add('記憶體節省：約 ${(memoryAfter - typesAfter) * 100 ~/ memoryAfter}%');
    });
    
    // 滾動到日誌底部
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final treeCount = _forest.getTreeCount();
    final typeCount = TreeFactory.getTreeTypesCount();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('享元模式示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '享元模式通過共享來有效支持大量細粒度的物件。這個示例創建一個森林，其中包含多種樹，但樹的種類（內在狀態）是共享的。',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '森林狀態',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text('樹木總數：$treeCount'),
                          Text('不同樹種類數：$typeCount'),
                          if (treeCount > 0)
                            Text(
                              '記憶體節省：約 ${(treeCount - typeCount) * 100 ~/ treeCount}%',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '添加更多樹',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Slider(
                                  value: _treesToPlant.toDouble(),
                                  min: 10,
                                  max: 1000,
                                  divisions: 99,
                                  label: _treesToPlant.toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      _treesToPlant = value.round();
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                child: Text(
                                  '$_treesToPlant',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: _plantTrees,
                                child: const Text('種植樹木'),
                              ),
                              TextButton(
                                onPressed: _resetExample,
                                child: const Text('重置森林'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 森林顯示區域
                  Expanded(
                    flex: 2,
                    child: Card(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Stack(
                          children: [
                            ..._forest.render(),
                            if (_forest.getTreeCount() == 0)
                              const Center(
                                child: Text(
                                  '森林是空的。\n點擊"種植樹木"按鈕來添加樹木。',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // 日誌區域
                  Expanded(
                    flex: 1,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '操作日誌',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(height: 1),
                          Expanded(
                            child: ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.all(8.0),
                              itemCount: _logs.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    _logs[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _logs[index].contains('創建新的')
                                          ? Colors.green.shade800
                                          : _logs[index].contains('重用現有的')
                                              ? Colors.blue.shade800
                                              : null,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 