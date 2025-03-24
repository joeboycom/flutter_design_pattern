import 'legacy_text_storage.dart';
import 'text_formatter.dart';

// 適配器 - 將LegacyTextStorage適配到TextFormatter接口
class LegacyTextStorageAdapter implements TextFormatter {
  final LegacyTextStorage _legacyStorage;

  LegacyTextStorageAdapter(this._legacyStorage);

  @override
  String formatAndSave(String text, TextFormattingOptions options) {
    // 轉換新接口調用到舊接口
    String formattedText = _legacyStorage.formatText(
      text, 
      options.bold, 
      options.italic
    );
    
    // 處理新增的功能
    if (options.underline) {
      formattedText = '~$formattedText~'; // 簡單模擬下劃線功能
    }
    
    // 調用舊系統的保存功能
    String id = _legacyStorage.saveText(formattedText);
    return 'Adapted-$id';
  }
} 