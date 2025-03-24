import 'dart:math' as math;
import 'package:flutter/material.dart';

// 享元（Flyweight）：樹種類
class TreeType {
  final String name;
  final Color color;
  final String texture; // 樹的紋理描述

  const TreeType(this.name, this.color, this.texture);
  
  // 繪製樹的方法（這裡只是返回一個表示樹的 Widget）
  Widget render(double x, double y, double size) {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: size,
        height: size * 1.5,
        decoration: BoxDecoration(
          color: color.withOpacity(0.8),
          borderRadius: BorderRadius.circular(size / 3),
        ),
        alignment: Alignment.center,
        child: Text(
          name.substring(0, 1),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: size / 3,
          ),
        ),
      ),
    );
  }
}

// 享元工廠：管理樹種類的共享
class TreeFactory {
  static final Map<String, TreeType> _treeTypes = {};
  
  // 獲取或創建樹種類
  static TreeType getTreeType(String name, Color color, String texture) {
    final String key = '${name}_${color.value}_$texture';
    
    if (!_treeTypes.containsKey(key)) {
      print('創建新的樹種類: $name');
      _treeTypes[key] = TreeType(name, color, texture);
    } else {
      print('重用現有的樹種類: $name');
    }
    
    return _treeTypes[key]!;
  }
  
  // 獲取已創建的樹種類數量
  static int getTreeTypesCount() {
    return _treeTypes.length;
  }
  
  // 清除所有樹種類（用於重置示例）
  static void clear() {
    _treeTypes.clear();
  }
}

// 樹實例（使用享元模式）
class Tree {
  final double x;
  final double y;
  final double size;
  final TreeType type;
  
  Tree(this.x, this.y, this.size, this.type);
  
  Widget render() {
    return type.render(x, y, size);
  }
}

// 森林類（管理多棵樹）
class Forest {
  final List<Tree> _trees = [];
  
  // 種植一棵新樹
  void plantTree(double x, double y, double size, String name, Color color, String texture) {
    final treeType = TreeFactory.getTreeType(name, color, texture);
    final tree = Tree(x, y, size, treeType);
    _trees.add(tree);
  }
  
  // 隨機種植多棵樹
  void plantRandomTrees(int count, double maxX, double maxY) {
    final random = math.Random();
    final treeNames = ['松樹', '橡樹', '楓樹', '柳樹'];
    final treeColors = [
      Colors.green.shade800,
      Colors.green.shade700,
      Colors.green.shade600,
      Colors.green.shade500,
    ];
    final treeTextures = ['粗糙', '光滑', '有紋路', '細膩'];
    
    for (int i = 0; i < count; i++) {
      final x = random.nextDouble() * maxX;
      final y = random.nextDouble() * maxY;
      final size = 20.0 + random.nextDouble() * 30.0;
      final nameIndex = random.nextInt(treeNames.length);
      final colorIndex = random.nextInt(treeColors.length);
      final textureIndex = random.nextInt(treeTextures.length);
      
      plantTree(
        x, 
        y, 
        size, 
        treeNames[nameIndex], 
        treeColors[colorIndex], 
        treeTextures[textureIndex]
      );
    }
  }
  
  // 獲取所有樹的視覺表示
  List<Widget> render() {
    return _trees.map((tree) => tree.render()).toList();
  }
  
  // 獲取樹的數量
  int getTreeCount() {
    return _trees.length;
  }
  
  // 清除所有樹
  void clear() {
    _trees.clear();
    TreeFactory.clear();
  }
} 