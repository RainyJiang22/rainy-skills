# 常用代码模板

> 提供现代化改写的标准模板

## 1. 状态管理模板

### Provider 模板
```dart
// Model
class Counter extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

// 使用
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Counter(),
      child: MyApp(),
    ),
  );
}

// UI
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Counter>(
      builder: (context, counter, child) {
        return Text('${counter.count}');
      },
    );
  }
}
```

### Riverpod 模板（推荐）
```dart
// Provider
final counterProvider = StateProvider<int>((ref) => 0);

// UI
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Text('$count');
  }
}
```

## 2. 网络请求模板

### Dio 封装模板
```dart
class ApiService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://api.example.com',
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 3),
  ));

  static Future<T> get<T>(String path) async {
    try {
      final response = await _dio.get<T>(path);
      return response.data as T;
    } catch (e) {
      rethrow;
    }
  }
}
```

## 3. 表单模板
```dart
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _controller,
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
                // 提交
              }
            },
            child: Text('提交'),
          ),
        ],
      ),
    );
  }
}
```

## 4. 列表模板
```dart
class MyList extends StatelessWidget {
  final List<Item> items;

  const MyList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text(item.title),
          subtitle: Text(item.subtitle),
          onTap: () {
            // 处理点击
          },
        );
      },
    );
  }
}
```

## 5. 导航模板
```dart
// 路由定义
class Routes {
  static const home = '/';
  static const detail = '/detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case detail:
        final args = settings.arguments as DetailArgs;
        return MaterialPageRoute(builder: (_) => DetailPage(args: args));
      default:
        return MaterialPageRoute(builder: (_) => NotFoundPage());
    }
  }
}

// 使用
Navigator.pushNamed(context, Routes.detail, arguments: DetailArgs(id: 1));
```

## 6. 对话框模板
```dart
Future<bool?> showConfirmDialog(BuildContext context, String message) async {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('确认'),
        content: Text(message),
        actions: [
          TextButton(
            child: Text('取消'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: Text('确定'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      );
    },
  );
}
```

## 7. 动画模板
```dart
class FadeInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const FadeInWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  _FadeInWidgetState createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<FadeInWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
```

## 8. 异步UI模板
```dart
FutureBuilder<Data>(
  future: fetchData(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    }

    final data = snapshot.data!;
    return YourDataWidget(data);
  },
)
```
