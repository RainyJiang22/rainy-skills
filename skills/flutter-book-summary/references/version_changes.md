# Flutter 版本变更对照表

> 书籍基于 Flutter 3.0，记录最新版本的重要变更

## Flutter 3.24+ 重要变更

### 1. 导航相关
**WillPopScope 已废弃 → 使用 PopScope**

```dart
// ❌ 旧版（已废弃）
WillPopScope(
  onWillPop: () async {
    // 处理返回逻辑
    return true; // true允许返回，false阻止返回
  },
  child: YourWidget(),
)

// ✅ 新版推荐
PopScope(
  canPop: false, // 是否允许返回
  onPopInvokedWithResult: (didPop, result) {
    if (!didPop) {
      // 处理返回逻辑
    }
  },
  child: YourWidget(),
)
```

### 2. 按钮组件
**FlatButton等已废弃 → 使用新按钮**

```dart
// ❌ 旧版（已废弃）
FlatButton(
  child: Text('按钮'),
  onPressed: () {},
)

// ✅ 新版推荐
TextButton(
  child: Text('按钮'),
  onPressed: () {},
)

// 其他按钮对照
RaisedButton → ElevatedButton
OutlineButton → OutlinedButton
```

### 3. Material 3 设计
**默认启用 Material 3**

```dart
MaterialApp(
  theme: ThemeData(
    useMaterial3: true, // Flutter 3.24+ 默认为 true
    colorSchemeSeed: Colors.blue, // 动态配色方案
  ),
)
```

### 4. 滚动性能优化
**ListView 性能改进**

```dart
// 新增 cacheExtent 参数更智能
ListView.builder(
  cacheExtent: 500, // 预缓存范围
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ItemWidget(items[index]);
  },
)
```

### 5. 图表组件
**新增 fl_chart 官方推荐图表库**

```yaml
dependencies:
  fl_chart: ^0.66.0
```

### 6. 网络请求
**Dio 5.x 重大更新**

```dart
// Dio 5.x 使用方式
final dio = Dio();
try {
  final response = await dio.get('https://api.example.com/data');
  print(response.data);
} catch (e) {
  print('Error: $e');
}
```

### 7. 状态管理
**Provider 新版本改进**

```dart
// Provider 6.x+
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => Counter()),
    Provider(create: (_) => SomeService()),
  ],
  child: MyApp(),
)
```

### 8. 表单验证
**Form 组件改进**

```dart
Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '请输入内容';
          }
          return null;
        },
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // 表单验证通过
          }
        },
        child: Text('提交'),
      ),
    ],
  ),
)
```

## 废弃 API 清单

| 旧API | 新API | 版本 |
|-------|-------|------|
| WillPopScope | PopScope | 3.12+ |
| FlatButton | TextButton | 1.20+ |
| RaisedButton | ElevatedButton | 1.20+ |
| OutlineButton | OutlinedButton | 1.20+ |
| ToggleButtons | ToggleButtons.selected | 3.10+ |
| TextField.textFieldKey | TextField.key | 3.0+ |

## 新增特性清单

### Flutter 3.24+
- Impeller 渲染引擎（iOS 默认启用）
- Material 3 动态配色
- 预测性返回手势支持
- Wasm 编译支持（Web）

### Flutter 3.10+
- Impeller 渲染引擎预览
- Web 画布Kit 改进
- iOS 编译优化

### Flutter 3.0+
- macOS、Linux 稳定支持
- Web 平台改进
- Firebase 集成增强

## 性能优化建议

### 1. 使用 const 构造器
```dart
// ✅ 推荐
const Text('Hello')
const SizedBox(height: 10)

// ❌ 不推荐（每次都重建）
Text('Hello')
SizedBox(height: 10)
```

### 2. 合理使用 ListView.builder
```dart
// ✅ 长列表
ListView.builder(
  itemCount: 1000,
  itemBuilder: (context, index) => Item(index),
)

// ❌ 避免
ListView(
  children: List.generate(1000, (i) => Item(i)),
)
```

### 3. 状态管理粒度
```dart
// ✅ 精确控制重建范围
Consumer<Model>(
  builder: (context, model, child) {
    return Text('${model.value}');
  },
)

// ❌ 过大范围
Consumer<Model>(
  builder: (context, model, child) {
    return Column(
      children: [
        // 大量不需要重建的组件
        Text('${model.value}'),
        HeavyWidget(),
        AnotherWidget(),
      ],
    );
  },
)
```

## 学习资源

- [Flutter 官方文档](https://docs.flutter.dev/)
- [Flutter SDK 更新日志](https://docs.flutter.dev/release/whats-new)
- [Dart SDK 更新](https://dart.dev/guides)
- [Flutter GitHub](https://github.com/flutter/flutter)
