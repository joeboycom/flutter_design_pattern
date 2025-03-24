import 'package:flutter/material.dart';
import '../design_patterns/structural/adapter/legacy_text_storage.dart';
import '../design_patterns/structural/adapter/legacy_text_storage_adapter.dart';
import '../design_patterns/structural/adapter/modern_text_formatter.dart';
import '../design_patterns/structural/adapter/text_formatter.dart';

class AdapterExamplePage extends StatefulWidget {
  const AdapterExamplePage({Key? key}) : super(key: key);

  @override
  _AdapterExamplePageState createState() => _AdapterExamplePageState();
}

class _AdapterExamplePageState extends State<AdapterExamplePage> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _log = [];
  
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;
  
  // 創建文本格式化器
  late final TextFormatter _modernFormatter = ModernTextFormatter();
  late final LegacyTextStorage _legacyStorage = LegacyTextStorage();
  late final TextFormatter _legacyAdapter = LegacyTextStorageAdapter(_legacyStorage);
  
  bool _useModernFormatter = true;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _formatAndSaveText() {
    if (_textController.text.isEmpty) return;
    
    final options = TextFormattingOptions(
      bold: _isBold,
      italic: _isItalic,
      underline: _isUnderline,
    );
    
    // 根據選擇使用現代格式化器或適配的遺留系統
    final TextFormatter formatter = _useModernFormatter ? _modernFormatter : _legacyAdapter;
    
    final String id = formatter.formatAndSave(_textController.text, options);
    
    setState(() {
      _log.insert(0, '保存的文本ID: $id');
      if (_log.length > 10) {
        _log.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('適配器模式示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '適配器模式允許不兼容的接口能夠一起工作。本例中，我們將舊的文本存儲系統適配到新的文本格式化接口。',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '請輸入文本...',
              ),
            ),
            const SizedBox(height: 16),
            
            // 格式化選項
            Row(
              children: [
                ChoiceChip(
                  label: const Text('粗體'),
                  selected: _isBold,
                  onSelected: (selected) {
                    setState(() {
                      _isBold = selected;
                    });
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('斜體'),
                  selected: _isItalic,
                  onSelected: (selected) {
                    setState(() {
                      _isItalic = selected;
                    });
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('下劃線'),
                  selected: _isUnderline,
                  onSelected: (selected) {
                    setState(() {
                      _isUnderline = selected;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // 系統選擇
            Row(
              children: [
                const Text('選擇系統: '),
                Radio<bool>(
                  value: true,
                  groupValue: _useModernFormatter,
                  onChanged: (value) {
                    setState(() {
                      _useModernFormatter = value!;
                    });
                  },
                ),
                const Text('現代系統'),
                Radio<bool>(
                  value: false,
                  groupValue: _useModernFormatter,
                  onChanged: (value) {
                    setState(() {
                      _useModernFormatter = value!;
                    });
                  },
                ),
                const Text('遺留系統 (通過適配器)'),
              ],
            ),
            const SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: _formatAndSaveText,
              child: const Text('格式化並保存'),
            ),
            const SizedBox(height: 16),
            
            const Text('操作日誌:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: _log.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    dense: true,
                    title: Text(_log[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 