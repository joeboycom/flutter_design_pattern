import 'file_system_component.dart';

// 葉子節點 - 文件
class File implements FileSystemComponent {
  final String _name;
  final int _size;
  final String _type;
  
  File(this._name, this._size, this._type);
  
  @override
  String getName() {
    return _name;
  }
  
  @override
  String getDetails() {
    return '$_name (${_getFormattedSize()}, $_type)';
  }
  
  @override
  int getSize() {
    return _size;
  }
  
  String _getFormattedSize() {
    if (_size < 1024) {
      return '$_size B';
    } else if (_size < 1024 * 1024) {
      return '${(_size / 1024).toStringAsFixed(2)} KB';
    } else {
      return '${(_size / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
  }
  
  @override
  List<FileSystemComponent> getChildren() {
    return [];
  }
  
  @override
  bool isComposite() {
    return false;
  }
  
  @override
  void add(FileSystemComponent component) {
    throw UnsupportedError("不能向文件添加組件");
  }
  
  @override
  void remove(FileSystemComponent component) {
    throw UnsupportedError("不能從文件移除組件");
  }
} 