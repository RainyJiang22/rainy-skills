---
name: flutter-book-summary
description: 专为《Flutter实战·第二版》设计的章节总结学习工具。当用户请求学习或总结Flutter书籍的特定章节时触发此技能。使用场景：(1) 用户明确提到"第X章"、"Flutter实战"、"书籍总结"等关键词；(2) 用户请求Flutter某个知识点的系统学习；(3) 用户需要快速掌握Flutter某个专题内容。该技能会提供核心概念、代码示例、版本变更、实践建议等完整学习内容。
---

# Flutter 实战书籍章节总结

快速学习和掌握《Flutter实战·第二版》各章节内容，提供现代化代码示例和实践建议。

## 快速开始

当用户请求总结某个章节时，按以下流程处理：

### 1. 询问章节范围
如果用户未指定具体章节，先询问：
```
请告诉我您想学习哪个章节？可以是：
- 具体章节号（如"第7章"）
- 知识点（如"状态管理"、"动画"）
- 章节范围（如"第6-8章"）
```

### 2. 获取章节内容
使用 `mcp__fetch__imageFetch` 工具获取对应章节内容：

**基础URL格式**：
```
https://book.flutterchina.club/chapter{N}/
https://book.flutterchina.club/chapter{N}/{section}.html
```

**示例**：
```
第7章：https://book.flutterchina.club/chapter7/
第7.1节：https://book.flutterchina.club/chapter7/willpopscope.html
```

### 3. 输出总结内容

为每个章节提供以下结构化内容：

#### 📖 章节概述
- 章节主题和学习目标
- 知识点列表
- 学习难度评估

#### 💡 核心概念
- 关键概念解释
- 原理说明
- 概念之间的关系

#### 📝 代码示例
- 基础用法示例
- 进阶用法示例
- **重要**：提供现代化改写（参考 `references/version_changes.md`）

#### ⚠️ 版本变更
标注书籍版本与当前版本的差异：
- 已废弃的API
- 新增特性
- 推荐写法对比

#### 🎯 实践建议
- 学习重点
- 常见错误
- 性能优化建议
- 实战练习建议

#### 📚 扩展学习
- 相关章节推荐
- 进阶学习路径
- 官方文档链接

## 章节内容组织规则

### 针对不同类型章节

**UI组件类章节（第3-6章）**：
- 重点讲解组件属性和用法
- 提供完整示例代码
- 强调布局约束原理
- 对比不同组件的使用场景

**功能机制类章节（第7-8章）**：
- 重点讲解底层原理
- 提供状态管理、事件处理的最佳实践
- 对比不同方案优劣

**进阶特性类章节（第9-14章）**：
- 重点讲解核心原理
- 提供性能优化建议
- 结合实际案例讲解

**实战类章节（第15章）**：
- 重点讲解项目架构
- 提供完整的开发流程
- 总结最佳实践

## 代码示例规范

### 必须包含
1. **完整可运行代码**
2. **现代化写法**（参考 `references/version_changes.md`）
3. **注释说明**

### 代码对比格式
```dart
// ❌ 书籍原版（已废弃）
FlatButton(
  child: Text('按钮'),
  onPressed: () {},
)

// ✅ 现代化写法（推荐）
TextButton(
  child: Text('按钮'),
  onPressed: () {},
)
```

### 示例代码模板
参考 `references/code_templates.md` 中的标准模板：
- 状态管理模板
- 网络请求模板
- 表单模板
- 列表模板
- 导航模板
- 对话框模板
- 动画模板
- 异步UI模板

## 实战练习代码规范

### 必须提供完整代码
所有实战练习必须提供**完整可运行**的代码，包括：

1. **必要的导入**
```dart
import 'package:flutter/material.dart';
```

2. **main函数入口**
```dart
void main() {
  runApp(const MyApp());
}
```

3. **完整的Widget定义**
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PracticePage(),
    );
  }
}
```

4. **详细注释**
- 每个关键步骤都要有注释
- 解释为什么这样做
- 标注易错点

### 实战练习模板

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const PracticeApp());
}

/// 练习App
class PracticeApp extends StatelessWidget {
  const PracticeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter 实战练习',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const PracticePage(),
    );
  }
}

/// 练习页面
class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  // 状态变量
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('练习标题'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // UI 组件
            Text('计数: $_counter'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _increment,
              child: const Text('增加'),
            ),
          ],
        ),
      ),
    );
  }

  // 业务逻辑方法
  void _increment() {
    setState(() {
      _counter++;
    });
  }
}
```

### 代码规范要求

1. **命名规范**
   - 类名：大驼峰（MyWidget）
   - 变量/方法：小驼峰（myVariable）
   - 常量：小驼峰或全大写（maxCount 或 MAX_COUNT）
   - 私有成员：下划线前缀（_counter）

2. **注释规范**
   ```dart
   /// 这是文档注释，用于类和公共方法
   class MyClass { }

   // 这是普通注释，用于代码内说明
   int value = 0; // 行尾注释

   /* 多行注释
      用于较长的说明 */
   ```

3. **代码组织**
   ```dart
   class _MyState extends State<MyWidget> {
     // 1. 状态变量
     int _count = 0;

     // 2. 初始化方法
     @override
     void initState() {
       super.initState();
     }

     // 3. 生命周期方法
     @override
     void dispose() {
       super.dispose();
     }

     // 4. build方法
     @override
     Widget build(BuildContext context) {
       return Container();
     }

     // 5. 私有方法
     void _handleTap() {}
   }
   ```

4. **必须包含的内容**
   - ✅ 完整的 import 语句
   - ✅ main() 函数入口
   - ✅ MaterialApp/CupertinoApp 配置
   - ✅ 主题配置（推荐 Material 3）
   - ✅ 详细注释
   - ✅ 错误处理（如果有网络/异步操作）
   - ✅ 资源释放（如果有 Controller）

5. **禁止的内容**
   - ❌ 不完整的代码片段
   - ❌ 省略 import 的代码
   - ❌ 缺少 main 函数的代码
   - ❌ 过度简化的示例（无法直接运行）

## 版本差异标注

### 标注规则
使用醒目的标记提示版本差异：

**废弃API**：
```
⚠️ 已废弃：`WillPopScope` → 使用 `PopScope`（Flutter 3.12+）
```

**新增特性**：
```
🆕 新增：Material 3 动态配色（Flutter 3.24+）
```

**推荐变更**：
```
💡 推荐：使用 `ListView.builder` 替代 `ListView(children: [])` 处理长列表
```

### 版本对照
详细版本变更参考 `references/version_changes.md`

## 学习建议输出

### 根据用户水平调整
**初学者**：
- 提供详细的概念解释
- 提供完整的示例代码
- 强调基础用法

**进阶者**：
- 重点讲解原理
- 提供性能优化建议
- 探讨最佳实践

**高级开发者**：
- 深入源码分析
- 提供架构建议
- 讨论性能极限

### 学习路径建议
参考 `references/learning_tips.md`：
- 基础入门路径
- 进阶提升路径
- 实战应用路径

## 输出格式模板

```markdown
# 第X章：章节名称

## 📖 章节概述
[1-2句话概述章节内容]

### 学习目标
- 目标1
- 目标2
- 目标3

## 💡 核心概念

### 概念1
[概念解释]

### 概念2
[概念解释]

## 📝 代码示例

### 示例1：基础用法
[代码]

### 示例2：进阶用法
[代码]

## ⚠️ 版本变更

### 废弃API
[对比新旧写法]

### 新增特性
[新特性说明]

## 🎯 实践建议

### 学习重点
- 重点1
- 重点2

### 常见错误
- 错误1及解决方案
- 错误2及解决方案

### 性能优化
- 优化建议1
- 优化建议2

### 实战练习

#### 练习1：[练习名称]
**目标**：[练习目标说明]

**完整代码**：
```dart
// 完整可运行的示例代码
// 包含必要的import、main函数、完整的类定义
// 添加详细注释说明
```

**运行效果**：
- [描述预期效果]
- [关键点说明]

#### 练习2：[练习名称]
**目标**：[练习目标说明]

**完整代码**：
```dart
// 完整可运行的示例代码
```

**扩展挑战**：
- [可选的进阶要求]

## 📚 扩展学习

### 相关章节
- 第X章：[关联内容]
- 第Y章：[关联内容]

### 进阶路径
[学习建议]

### 参考资料
- [官方文档链接]
- [相关文章]
```

## 特殊处理场景

### 跨章节知识点
某些知识点涉及多个章节，需要交叉引用：
- **状态管理**：第2章、第7章、第10章
- **动画**：第9章、第10章
- **性能优化**：第6章、第7章、第14章

### 实战案例推荐
根据章节内容，推荐相关实战项目：
- 第3-5章：简单的展示型页面
- 第6章：新闻列表、商品列表
- 第7章：购物车、设置页
- 第8章：手势交互页面
- 第9章：动画效果页面
- 第10章：自定义组件库

## 参考资源

### 章节索引
完整的章节目录参考 `references/chapter_index.md`

### 版本变更
详细的版本变更对照参考 `references/version_changes.md`

### 代码模板
常用代码模板参考 `references/code_templates.md`

### 学习建议
详细的学习建议参考 `references/learning_tips.md`

## 示例交互

**用户**：帮我总结第7章

**Claude**：
[获取第7章内容]
[输出结构化总结]
[提供代码示例]
[标注版本变更]
[给出学习建议]

**用户**：我想学习状态管理

**Claude**：
[识别相关章节：第2章、第7章]
[询问用户水平]
[提供学习路径]
[输出核心内容]
[提供实践项目建议]
