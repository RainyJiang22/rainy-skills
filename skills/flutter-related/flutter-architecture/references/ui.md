# UI 界面规范（生产可用）

主题与设计体系统一、加载/空/错误态完整、响应式与无障碍、性能与目录可复用。

## 3.1 主题与设计体系

| 项 | 方案 |
|----|------|
| 组件库与主题 | **Material 3**（ThemeData.useMaterial3）；ColorScheme、Typography。 |
| 颜色 | ColorScheme + 语义 Token；业务色为扩展或常量，不硬编码 hex。 |
| 字体与排版 | theme.textTheme（titleMedium、bodyLarge 等）；品牌字体在 ThemeData 统一配置。 |
| 间距与圆角 | 统一常量（4/8/12/16/24）；在 core/theme 或 shared/constants 定义。 |
| 亮/暗色 | ThemeData.light()/dark()；支持系统或应用设置。 |

**目录**：`app/theme/` 或 `shared/theme/`（app_theme.dart、app_colors.dart、app_text_styles.dart）。

## 3.2 页面与组件结构

| 项 | 方案 |
|----|------|
| 页面 | Screen = Scaffold + 状态驱动 Body；不在此写业务请求，由状态层 init/load 拉数。 |
| 状态驱动 | AsyncValue / Loading↔Data↔Error；统一 Loading/Data/Error 组件。 |
| 可复用组件 | `shared/widgets/` 或 feature 内 `widgets/`；弹窗/sheet 统一封装。 |

**禁止**：在 Page 的 build 里直接发起 Future；在 Widget 内写死颜色/尺寸（除仅此处使用）。

## 3.3 加载 / 空态 / 错误态（必做）

| 态 | 方案 |
|----|------|
| Loading | 全屏或局部骨架/菊花；首屏统一 AppLoading 或骨架屏。 |
| 空态 | 统一 Empty 组件（插画+文案+主操作）；文案走 l10n。 |
| 错误态 | 统一 Error 组件（文案+重试）；文案从统一错误模型或 l10n。 |
| 部分失败 | 列表单条失败用占位或 Toast，不整页报错。 |

组件放在 `shared/widgets/`（app_loading.dart、app_empty.dart、app_error.dart），全项目统一。

## 3.4 响应式与多端适配

| 项 | 方案 |
|----|------|
| 断点 | LayoutBuilder/MediaQuery；breakpoint（如 600/900）；窄屏单列、宽屏多列。 |
| 安全区 | SafeArea；固定底部按钮考虑安全区与键盘。 |
| 横竖屏/多端 | OrientationBuilder 或断点；手机/平板/桌面可共用或 Platform 分支。 |

## 3.5 无障碍与体验

| 项 | 方案 |
|----|------|
| 语义 | Semantics/semanticsLabel；图标按钮、图片、自定义控件补充。 |
| 点击区域 | 最小 48×48 dp；InkWell 外包或 minTouchTargetSize。 |
| 字体缩放 | 文案用 theme 继承；不写死 fontSize。 |
| 对比度 | 主文案与背景对比度达标（可选 WCAG AA）。 |

## 3.6 性能与规范

| 项 | 方案 |
|----|------|
| const | 无状态静态子树用 const。 |
| 列表 | 长列表用 ListView.builder/SliverList；禁止 ListView(children: List.generate(...))。 |
| Key | 动态列表项设置 Key（如 item.id）。 |
| build 内 | 不发起请求、不重计算、不 new 大对象。 |

## 3.7 UI 层目录

```
features/.../presentation/
  screens/     # 页面，对应路由
  widgets/     # feature 内复用
shared/
  theme/       # 主题、颜色、字体、间距
  widgets/     # AppLoading、AppEmpty、AppError、通用按钮/输入框等
```
