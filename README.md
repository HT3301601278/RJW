# 反应器温度在线监测系统

## 项目简介

这是一个使用Flutter开发的反应器温度在线监测系统移动应用。该系统允许用户登录、注册、添加设备、查看设备详情、编辑设备信息、分析数据以及查看警报信息等功能。

## 项目结构

```
lib/
├── main.dart
├── models/
│   └── device.dart
├── screens/
│   ├── login_screen.dart
│   ├── register_screen.dart
│   ├── add_device_screen.dart
│   ├── device_detail_screen.dart
│   ├── device_edit_screen.dart
│   ├── settings_screen.dart
│   ├── alert_info_screen.dart
│   └── data_analysis_screen.dart
├── services/
│   ├── auth_service.dart
│   └── device_service.dart
└── widgets/
    └── device_list_item.dart
```

## 主要功能模块

### 1. 登录和注册

- 登录界面: `lib/screens/login_screen.dart`
- 注册界面: `lib/screens/register_screen.dart`

这两个界面允许用户进行账号登录和新用户注册。

### 2. 设备管理

- 添加设备: `lib/screens/add_device_screen.dart`
- 设备详情: `lib/screens/device_detail_screen.dart`
- 编辑设备: `lib/screens/device_edit_screen.dart`
- 设备列表项: `lib/widgets/device_list_item.dart`

这些文件处理设备的添加、查看详情和编辑功能。

### 3. 数据分析

- 数据分析界面: `lib/screens/data_analysis_screen.dart`

该界面提供了数据的表格和图表展示，支持分页和搜索功能。

### 4. 警报信息

- 警报信息界面: `lib/screens/alert_info_screen.dart`

显示系统的警报信息。

### 5. 设置

- 设置界面: `lib/screens/settings_screen.dart`

允许用户修改密码和进行其他系统设置。

### 6. 服务

- 认证服务: `lib/services/auth_service.dart`
- 设备服务: `lib/services/device_service.dart`

这些服务文件处理与后端API的通信，包括用户认证和设备数据的CRUD操作。

## 关键代码解析

### 1. 主程序入口


这是应用的主入口，设置了应用的主题和初始路由。

### 2. 登录界面


登录界面的主要构建逻辑，包括用户名和密码输入框，以及登录按钮。

### 3. 设备详情界面


设备详情界面的构建逻辑，显示设备的各项信息。

### 4. 数据分析界面


数据分析界面的构建逻辑，包括表格和图表视图的切换，以及分页控制。

## 如何开始

1. 确保您的开发环境已经安装了Flutter SDK。
2. 克隆此项目到本地。
3. 在项目根目录运行 `flutter pub get` 安装依赖。
4. 使用 `flutter run` 命令运行项目。

## 学习建议

1. 从 `main.dart` 开始，理解应用的整体结构。
2. 逐个查看 `screens` 目录下的文件，了解各个界面的构建逻辑。
3. 研究 `services` 目录下的文件，了解如何与后端API进行通信。
4. 查看 `widgets` 目录，学习如何创建可重用的UI组件。
5. 尝试修改一些UI元素或添加新功能，以加深对项目的理解。