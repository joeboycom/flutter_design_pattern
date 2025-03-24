import 'image.dart';

// 代理圖片類別
class ProxyImage implements Image {
  final String _filename;
  RealImage? _realImage;
  final bool _hasAccessPermission;
  
  ProxyImage(this._filename, {bool hasAccessPermission = true}) 
      : _hasAccessPermission = hasAccessPermission;
  
  @override
  void display() {
    if (!_hasAccessPermission) {
      print('權限不足：無法顯示圖片 $_filename');
      return;
    }
    
    // 延遲載入：僅在需要時建立實體圖片物件
    _realImage ??= RealImage(_filename);
    _realImage!.display();
  }
  
  @override
  String getInfo() {
    if (!_hasAccessPermission) {
      return '圖片檔案名稱：$_filename | 狀態：權限不足';
    }
    
    if (_realImage == null) {
      return '圖片檔案名稱：$_filename | 狀態：尚未載入';
    } else {
      return _realImage!.getInfo();
    }
  }
  
  bool get isLoaded => _realImage != null;
  bool get hasPermission => _hasAccessPermission;
  String get filename => _filename;
} 