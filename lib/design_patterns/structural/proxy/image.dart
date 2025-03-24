// 圖片介面
abstract class Image {
  void display();
  String getInfo();
}

// 實體圖片類別
class RealImage implements Image {
  final String _filename;
  bool _isLoaded = false;
  
  RealImage(this._filename);
  
  // 從磁碟載入圖片（模擬耗時操作）
  void _loadFromDisk() {
    if (!_isLoaded) {
      print('載入圖片：$_filename');
      // 模擬載入時間
      Future.delayed(const Duration(seconds: 1), () {
        _isLoaded = true;
        print('$_filename 已完成載入');
      });
      _isLoaded = true; // 立即設為已載入，實際上應該在延遲後設定
    }
  }
  
  @override
  void display() {
    if (!_isLoaded) {
      _loadFromDisk();
    }
    print('顯示圖片：$_filename');
  }
  
  @override
  String getInfo() {
    return '圖片檔案名稱：$_filename | 是否已載入：${_isLoaded ? '是' : '否'}';
  }
} 