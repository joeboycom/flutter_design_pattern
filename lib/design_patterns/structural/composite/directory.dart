import 'file_system_component.dart';

// 組合節點 - 目錄
class Directory implements FileSystemComponent {
  final String _name;
  final List<FileSystemComponent> _children = [];
  
  Directory(this._name);
  
  @override
  String getName() {
    return _name;
  }
  
  @override
  String getDetails() {
    return '$_name (目錄, ${_children.length} 個項目, ${_getFormattedSize()})';
  }
  
  @override
  int getSize() {
    // 計算所有子組件的總大小
    return _children.fold<int>(
      0, 
      (previousValue, component) => previousValue + component.getSize()
    );
  }
  
  String _getFormattedSize() {
    final totalSize = getSize();
    if (totalSize < 1024) {
      return '$totalSize B';
    } else if (totalSize < 1024 * 1024) {
      return '${(totalSize / 1024).toStringAsFixed(2)} KB';
    } else {
      return '${(totalSize / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
  }
  
  @override
  List<FileSystemComponent> getChildren() {
    return List.unmodifiable(_children);
  }
  
  @override
  bool isComposite() {
    return true;
  }
  
  @override
  void add(FileSystemComponent component) {
    _children.add(component);
  }
  
  @override
  void remove(FileSystemComponent component) {
    _children.remove(component);
  }
} 