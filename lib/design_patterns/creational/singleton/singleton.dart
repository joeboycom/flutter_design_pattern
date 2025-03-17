class Singleton {
  // 私有靜態實例
  static Singleton? _instance;
  
  // 實例創建計數器，用於演示目的
  static int instanceCount = 0;
  
  // 私有構造函數，防止外部直接實例化
  Singleton._internal() {
    instanceCount++;
  }
  
  // 工廠構造函數，返回單例實例
  factory Singleton() {
    // 如果實例不存在，則創建一個新實例
    _instance ??= Singleton._internal();
    return _instance!;
  }
  
  // 示例方法
  String getInfo() {
    return '這是單例實例 #$instanceCount';
  }
  
  // 重置單例（僅用於演示目的）
  static void reset() {
    _instance = null;
    instanceCount = 0;
  }
}

// 額外的示例：帶有日誌功能的單例
class LoggerSingleton {
  static LoggerSingleton? _instance;
  final List<String> _logs = [];
  
  LoggerSingleton._internal();
  
  factory LoggerSingleton() {
    _instance ??= LoggerSingleton._internal();
    return _instance!;
  }
  
  void log(String message) {
    final timestamp = DateTime.now().toString();
    _logs.add('[$timestamp] $message');
  }
  
  List<String> get logs => List.unmodifiable(_logs);
  
  void clearLogs() {
    _logs.clear();
  }
} 