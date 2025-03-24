import 'package:flutter/material.dart';
import '../design_patterns/structural/composite/directory.dart';
import '../design_patterns/structural/composite/file.dart';
import '../design_patterns/structural/composite/file_system_component.dart';

class CompositeExamplePage extends StatefulWidget {
  const CompositeExamplePage({Key? key}) : super(key: key);

  @override
  _CompositeExamplePageState createState() => _CompositeExamplePageState();
}

class _CompositeExamplePageState extends State<CompositeExamplePage> {
  late FileSystemComponent _rootDirectory;
  late FileSystemComponent _selectedComponent;
  
  final TextEditingController _fileNameController = TextEditingController();
  final TextEditingController _fileSizeController = TextEditingController();
  final TextEditingController _fileTypeController = TextEditingController();
  final TextEditingController _dirNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _createFileSystem();
  }

  @override
  void dispose() {
    _fileNameController.dispose();
    _fileSizeController.dispose();
    _fileTypeController.dispose();
    _dirNameController.dispose();
    super.dispose();
  }

  void _createFileSystem() {
    // 創建根目錄
    final rootDir = Directory('根目錄');
    
    // 創建文檔目錄
    final docsDir = Directory('文檔');
    docsDir.add(File('簡歷.docx', 2560000, 'Word文檔'));
    docsDir.add(File('報告.pdf', 5240000, 'PDF文檔'));
    
    // 創建圖片目錄
    final imgDir = Directory('圖片');
    imgDir.add(File('假期照片.jpg', 4300000, '圖片'));
    
    // 創建項目目錄
    final projectsDir = Directory('項目');
    
    // 創建Flutter項目子目錄
    final flutterDir = Directory('Flutter項目');
    flutterDir.add(File('main.dart', 5200, '代碼'));
    flutterDir.add(File('pubspec.yaml', 1800, '配置'));
    
    // 添加子目錄到對應父目錄
    projectsDir.add(flutterDir);
    
    // 添加所有一級目錄到根目錄
    rootDir.add(docsDir);
    rootDir.add(imgDir);
    rootDir.add(projectsDir);
    rootDir.add(File('notes.txt', 1240, '文本'));
    
    // 設置初始狀態
    _rootDirectory = rootDir;
    _selectedComponent = rootDir;
  }

  void _addFile() {
    if (_fileNameController.text.isEmpty ||
        _fileSizeController.text.isEmpty ||
        _fileTypeController.text.isEmpty ||
        !_selectedComponent.isComposite()) {
      return;
    }

    final int? size = int.tryParse(_fileSizeController.text);
    if (size == null) return;

    final file = File(
      _fileNameController.text,
      size,
      _fileTypeController.text,
    );

    setState(() {
      _selectedComponent.add(file);
      _fileNameController.clear();
      _fileSizeController.clear();
      _fileTypeController.clear();
    });
  }

  void _addDirectory() {
    if (_dirNameController.text.isEmpty || !_selectedComponent.isComposite()) {
      return;
    }

    final directory = Directory(_dirNameController.text);

    setState(() {
      _selectedComponent.add(directory);
      _dirNameController.clear();
    });
  }

  void _selectComponent(FileSystemComponent component) {
    setState(() {
      _selectedComponent = component;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('組合模式示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '組合模式將對象組織成樹形結構，使單個對象和組合對象的使用具有一致性。這個例子模擬了一個文件系統，其中目錄可以包含文件或其他目錄。',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            
            // 顯示當前選中組件信息
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '當前選中: ${_selectedComponent.getDetails()}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (_selectedComponent.isComposite()) ...[
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _fileNameController,
                              decoration: const InputDecoration(
                                labelText: '文件名',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _fileSizeController,
                              decoration: const InputDecoration(
                                labelText: '大小 (字節)',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _fileTypeController,
                              decoration: const InputDecoration(
                                labelText: '類型',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: _addFile,
                            child: const Text('添加文件'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _dirNameController,
                              decoration: const InputDecoration(
                                labelText: '目錄名',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: _addDirectory,
                            child: const Text('添加目錄'),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            // 顯示文件系統樹
            const Text(
              '文件系統樹:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            
            Expanded(
              child: _buildFileSystemTree(_rootDirectory, 0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileSystemTree(FileSystemComponent component, int level) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => _selectComponent(component),
          child: Container(
            color: component == _selectedComponent
                ? Colors.blue.withOpacity(0.2)
                : Colors.transparent,
            padding: EdgeInsets.only(left: level * 20.0, top: 8, bottom: 8),
            child: Row(
              children: [
                Icon(
                  component.isComposite() ? Icons.folder : Icons.insert_drive_file,
                  color: component.isComposite() ? Colors.amber : Colors.blue,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(component.getDetails()),
                ),
              ],
            ),
          ),
        ),
        if (component.isComposite())
          for (var child in component.getChildren())
            _buildFileSystemTree(child, level + 1),
      ],
    );
  }
} 