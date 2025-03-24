import 'package:flutter/material.dart';
import '../design_patterns/structural/facade/media_facade.dart';

class FacadeExamplePage extends StatefulWidget {
  const FacadeExamplePage({Key? key}) : super(key: key);

  @override
  _FacadeExamplePageState createState() => _FacadeExamplePageState();
}

class _FacadeExamplePageState extends State<FacadeExamplePage> {
  final MediaFacade _mediaFacade = MediaFacade();
  final List<String> _processLogs = [];
  
  // 影片處理設置
  String _selectedInputVideo = '我的假期影片.mp4';
  String _selectedOutputFormat = 'mp4';
  int _compressionLevel = 5;
  bool _enhanceBass = false;
  bool _reduceNoise = true;
  bool _addSubtitles = false;
  String _subtitleLanguage = '中文';

  // 可選的輸入影片檔案
  final List<String> _availableVideos = [
    '我的假期影片.mp4',
    '家人聚會.avi',
    '畢業典禮.mov',
    '生日派對.wmv',
  ];

  // 可選的輸出格式
  final List<String> _availableFormats = ['mp4', 'avi', 'mkv', 'webm'];

  void _processVideo() {
    setState(() {
      _processLogs.clear();
      _processLogs.add('開始處理影片...');
    });

    final logs = _mediaFacade.processVideo(
      inputVideo: _selectedInputVideo,
      outputFormat: _selectedOutputFormat,
      compressionLevel: _compressionLevel,
      enhanceBass: _enhanceBass,
      reduceNoise: _reduceNoise,
      subtitleFile: _addSubtitles ? '字幕檔案.srt' : null,
      subtitleLanguage: _subtitleLanguage,
    );

    setState(() {
      _processLogs.addAll(logs);
      _processLogs.add('影片處理完成！');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('外觀模式示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '外觀模式提供一個統一的介面，用來存取子系統中的一群介面。這個示例展示了一個影片處理外觀，它簡化了多個複雜子系統的操作。',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 左側設置面板
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '影片處理設置',
                              style: TextStyle(
                                fontSize: 18, 
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 16),
                            
                            // 選擇輸入影片
                            DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: '輸入影片',
                                border: OutlineInputBorder(),
                              ),
                              value: _selectedInputVideo,
                              items: _availableVideos.map((video) {
                                return DropdownMenuItem<String>(
                                  value: video,
                                  child: Text(video),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedInputVideo = value;
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            
                            // 選擇輸出格式
                            DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: '輸出格式',
                                border: OutlineInputBorder(),
                              ),
                              value: _selectedOutputFormat,
                              items: _availableFormats.map((format) {
                                return DropdownMenuItem<String>(
                                  value: format,
                                  child: Text(format),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedOutputFormat = value;
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            
                            // 壓縮等級滑桿
                            Row(
                              children: [
                                const Text('壓縮等級: '),
                                Expanded(
                                  child: Slider(
                                    value: _compressionLevel.toDouble(),
                                    min: 1,
                                    max: 10,
                                    divisions: 9,
                                    label: _compressionLevel.toString(),
                                    onChanged: (value) {
                                      setState(() {
                                        _compressionLevel = value.round();
                                      });
                                    },
                                  ),
                                ),
                                Text(_compressionLevel.toString()),
                              ],
                            ),
                            
                            // 音訊選項
                            CheckboxListTile(
                              title: const Text('增強低音'),
                              value: _enhanceBass,
                              onChanged: (value) {
                                setState(() {
                                  _enhanceBass = value ?? false;
                                });
                              },
                            ),
                            
                            CheckboxListTile(
                              title: const Text('降低雜訊'),
                              value: _reduceNoise,
                              onChanged: (value) {
                                setState(() {
                                  _reduceNoise = value ?? false;
                                });
                              },
                            ),
                            
                            // 字幕選項
                            CheckboxListTile(
                              title: const Text('添加字幕'),
                              value: _addSubtitles,
                              onChanged: (value) {
                                setState(() {
                                  _addSubtitles = value ?? false;
                                });
                              },
                            ),
                            
                            if (_addSubtitles) ...[
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    labelText: '字幕語言',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: _subtitleLanguage,
                                  items: const [
                                    DropdownMenuItem(value: '中文', child: Text('中文')),
                                    DropdownMenuItem(value: '英文', child: Text('英文')),
                                    DropdownMenuItem(value: '日文', child: Text('日文')),
                                  ],
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        _subtitleLanguage = value;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                            
                            const Spacer(),
                            
                            // 處理按鈕
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _processVideo,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: const Text('處理影片', style: TextStyle(fontSize: 16)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // 右側處理日誌
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '處理日誌',
                              style: TextStyle(
                                fontSize: 18, 
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 16),
                            
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ListView.builder(
                                  itemCount: _processLogs.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 2),
                                      child: Text(
                                        _processLogs[index],
                                        style: const TextStyle(
                                          color: Colors.green, 
                                          fontFamily: 'monospace'
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 