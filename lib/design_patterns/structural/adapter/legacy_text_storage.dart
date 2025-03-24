// 這是一個模擬的遺留系統類，它使用不兼容的接口
class LegacyTextStorage {
  String formatText(String text, bool isBold, bool isItalic) {
    String formattedText = text;
    
    if (isBold) {
      formattedText = '**$formattedText**';
    }
    
    if (isItalic) {
      formattedText = '_${formattedText}_';
    }
    
    return formattedText;
  }

  String saveText(String formattedText) {
    // 模擬保存到存儲
    print('LegacyTextStorage: 保存文本 "$formattedText"');
    return 'legacy-id-${DateTime.now().millisecondsSinceEpoch}';
  }
} 