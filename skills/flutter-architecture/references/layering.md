# 合理分层与各层最优方案

依赖方向：**表现层 → 领域层 → 数据层 → 核心/基础设施层**（上层仅依赖下层，不反向、不跨层直调）。

## 分层示意

```
┌─────────────────────────────────────────────────────────┐
│  表现层 (Presentation)  UI、路由、状态展示、用户输入      │
├─────────────────────────────────────────────────────────┤
│  领域层 (Domain) [可选]  实体、用例、业务规则             │
├─────────────────────────────────────────────────────────┤
│  数据层 (Data)  Repository 实现、远程/本地数据源、DTO 转换 │
├─────────────────────────────────────────────────────────┤
│  核心层 (Core)  网络封装、存储封装、DI、错误类型、常量     │
└─────────────────────────────────────────────────────────┘
```

## 2.1 表现层 (Presentation)

**职责**：UI 渲染、用户交互、路由与导航、将状态展示为界面；不直接调网络/DB，不写业务规则。

| 方面 | 推荐方案 |
|------|----------|
| UI 框架 | Flutter 3.x + Material 3；复杂列表用 Sliver、CustomScrollView。 |
| 状态管理 | **Riverpod 2.x** 或 **Bloc 8.x**，全项目统一。 |
| 路由 | **GoRouter 2.x** 声明式；深链、redirect、ShellRoute。 |
| 异步与加载 | AsyncValue / Loading↔Data↔Error；UI 只做分支展示。 |
| 依赖获取 | 只拿 Repository/UseCase 接口，不拿 Dio、不拿 DataSource。 |

**禁止**：在 Widget/Controller 内直接 `Dio().get()`、读 Hive/SQLite；在 build 里发起请求或重计算。

## 2.2 领域层 (Domain) [可选]

**职责**：实体、业务规则、用例编排；纯 Dart，不依赖 Flutter、不依赖具体数据源。

| 方面 | 推荐方案 |
|------|----------|
| 实体 | 纯 Dart 类，无注解；与 DTO/表结构解耦。 |
| 用例 | 单职责 UseCase 类，内部只调 Repository 接口。 |
| 错误与结果 | Result / Either 或 sealed class。 |

**何时采用**：中大型项目、多端共享业务、强可测试性时引入；小型项目可将用例合并到 Repository 或 ViewModel。

## 2.3 数据层 (Data)

**职责**：实现 Repository 接口；调用远程 API 与本地存储；DTO↔Entity 转换、分页与错误映射。

| 方面 | 推荐方案 |
|------|----------|
| 抽象 | Repository 接口；数据层提供 XxxRepositoryImpl。 |
| 远程 | 调用 Core 的 ApiClient/XxxApi（Dio+Retrofit 风格）。 |
| 本地 | 调用 Core 的 IKVStorage / 本地 DB 抽象。 |
| 转换 | DTO → Entity 在 Repository 内完成；列表/分页用 PageResult<T>。 |
| 流式 | Stream 或 Future；错误统一向上传递。 |

**禁止**：在 Repository 里写 UI 逻辑、弹 Toast、依赖 BuildContext。

## 2.4 核心/基础设施层 (Core)

**职责**：网络 Client 封装、本地存储封装、DI 注册、全局错误类型与常量。

| 方面 | 推荐方案 |
|------|----------|
| 网络 | Dio + 单例 Client + 拦截器 + Retrofit 风格 API；暴露 IApiClient/XxxApi。 |
| 本地存储 | 抽象接口 + 实现（shared_preferences/Hive/Isar/secure_storage）。 |
| DI | Riverpod 或 get_it + injectable。 |
| 错误类型 | 统一 ApiException/AppException。 |
| 配置 | 单文件或按环境注入；不散落魔法值。 |

**禁止**：Core 依赖表现层或领域层；不在 Core 写业务分支逻辑。

## 2.5 推荐目录结构

```
lib/
├── app/                    # 入口、路由表、DI 注册、主题
├── core/                   # network、storage、di、error、constants
├── domain/                 # [可选] 实体、用例、Repository 接口
├── data/                   # Repository 实现、DataSource、DTO、Mapper
├── features/
│   └── feature_xxx/
│       └── presentation/   # screens/、widgets/、providers 或 blocs
└── shared/                 # 跨 feature 的公共 UI、工具、常量
```
