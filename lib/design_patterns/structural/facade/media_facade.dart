import 'complex_subsystems.dart';

// 自定義日誌收集函數類型
typedef LogCallback = void Function(String message);

// 媒體處理外觀類別
class MediaFacade {
  final VideoConverter _videoConverter = VideoConverter();
  final VideoCompressor _videoCompressor = VideoCompressor();
  final AudioProcessor _audioProcessor = AudioProcessor();
  final SubtitleProcessor _subtitleProcessor = SubtitleProcessor();
  final VideoPackager _videoPackager = VideoPackager();
  
  // 簡化的影片處理一站式方法
  List<String> processVideo({
    required String inputVideo,
    required String outputFormat,
    int compressionLevel = 5,
    bool enhanceBass = false,
    bool reduceNoise = true,
    String? subtitleFile,
    String subtitleLanguage = '中文',
  }) {
    List<String> logMessages = [];
    
    // 日誌收集函數
    void collectLog(String message) {
      logMessages.add(message);
      print(message); // 仍然顯示在控制台
    }
    
    // 模擬整個處理流程，收集日誌
    
    // 1. 將影片轉換為標準格式
    final String tempVideo = 'temp_${DateTime.now().millisecondsSinceEpoch}.mp4';
    collectLog('開始將 $inputVideo 轉換為 mp4 格式...');
    collectLog('影片轉換完成！');
    
    // 2. 壓縮影片
    collectLog('以壓縮等級 $compressionLevel 壓縮 $tempVideo...');
    collectLog('影片壓縮完成！');
    
    // 3. 提取並處理音訊
    final String tempAudio = 'audio_${DateTime.now().millisecondsSinceEpoch}.aac';
    collectLog('處理音訊檔案 $tempAudio...');
    
    if (enhanceBass) {
      collectLog('增強低音效果');
    }
    
    if (reduceNoise) {
      collectLog('降低雜訊');
    }
    
    collectLog('音訊處理完成！');
    
    // 4. 如果提供了字幕檔案，添加字幕
    if (subtitleFile != null) {
      collectLog('為 $tempVideo 添加 $subtitleLanguage 字幕 ($subtitleFile)...');
      collectLog('字幕添加完成！');
    }
    
    // 5. 最終封裝並輸出
    final String outputFile = 'output_${DateTime.now().millisecondsSinceEpoch}.$outputFormat';
    collectLog('將影片 $tempVideo 與音訊 $tempAudio 組合為 $outputFile...');
    collectLog('封裝完成！');
    
    // 返回處理日誌和輸出檔案名稱
    collectLog('最終輸出檔案: $outputFile');
    return logMessages;
  }
  
  // 實際調用子系統的方法
  void processVideoReal({
    required String inputVideo,
    required String outputFormat,
    int compressionLevel = 5,
    bool enhanceBass = false,
    bool reduceNoise = true,
    String? subtitleFile,
    String subtitleLanguage = '中文',
  }) {
    // 1. 將影片轉換為標準格式
    final String tempVideo = 'temp_${DateTime.now().millisecondsSinceEpoch}.mp4';
    _videoConverter.convertVideo(inputVideo, 'mp4');
    
    // 2. 壓縮影片
    _videoCompressor.compress(tempVideo, compressionLevel);
    
    // 3. 提取並處理音訊
    final String tempAudio = 'audio_${DateTime.now().millisecondsSinceEpoch}.aac';
    _audioProcessor.processAudio(tempAudio, enhanceBass, reduceNoise);
    
    // 4. 如果提供了字幕檔案，添加字幕
    if (subtitleFile != null) {
      _subtitleProcessor.addSubtitles(tempVideo, subtitleFile, subtitleLanguage);
    }
    
    // 5. 最終封裝並輸出
    final String outputFile = 'output_${DateTime.now().millisecondsSinceEpoch}.$outputFormat';
    _videoPackager.packageVideo(tempVideo, tempAudio, outputFile);
    
    print('最終輸出檔案: $outputFile');
  }
} 