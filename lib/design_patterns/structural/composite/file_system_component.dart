// 抽象組件，作為文件和目錄的基類
abstract class FileSystemComponent {
  String getName();
  String getDetails();
  int getSize();
  List<FileSystemComponent> getChildren();
  bool isComposite();
  
  void add(FileSystemComponent component) {
    throw UnsupportedError("無法添加組件到此對象");
  }
  
  void remove(FileSystemComponent component) {
    throw UnsupportedError("無法從此對象移除組件");
  }
} 