// 新系統的接口
abstract class TextFormatter {
  String formatAndSave(String text, TextFormattingOptions options);
}

// 新系統中的文本格式化選項
class TextFormattingOptions {
  final bool bold;
  final bool italic;
  final bool underline;
  
  const TextFormattingOptions({
    this.bold = false,
    this.italic = false,
    this.underline = false,
  });
} 