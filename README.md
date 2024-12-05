# 反应器压力在线监测系统

## 项目简介

这是一个使用 Flutter 开发的反应器压力在线监测系统移动应用。该系统主要用于实时监控和管理工业反应器的压力数据,具有设备管理、数据分析、报警提醒等功能。

## 系统架构

### 前端技术栈
- Flutter SDK
- Dart 语言
- WebSocket 用于实时数据传输
- HTTP 用于 REST API 通信
- 第三方库:
  - fl_chart: 数据可视化图表
  - shared_preferences: 本地数据存储
  - http: 网络请求
  - web_socket_channel: WebSocket 通信

### 后端服务
- REST API 服务器: `http://8.155.16.118:8080/api`
- WebSocket 服务器: `ws://8.155.16.118:8080/ws`

## 项目结构

```
lib/
├── main.dart                 # 应用程序入口
├── models/                   # 数据模型
│   ├── device.dart          # 设备模型
│   └── user.dart            # 用户模型
├── screens/                  # 页面
│   ├── add_device_screen.dart    # 添加设备
│   ├── alert_info_screen.dart    # 警报信息
│   ├── data_analysis_screen.dart # 数据分析
│   ├── device_detail_screen.dart # 设备详情
│   ├── device_edit_screen.dart   # 设备编辑
│   ├── device_list_screen.dart   # 设备列表
│   ├── home_screen.dart          # 主页
│   ├── login_screen.dart         # 登录
│   ├── register_screen.dart      # 注册
│   └── settings_screen.dart      # 设置
├── services/                 # 服务
│   ├── auth_service.dart         # 认证服务
│   ├── device_service.dart       # 设备服务
│   └── websocket_service.dart    # WebSocket服务
└── widgets/                  # 组件
    ├── alert_widget.dart         # 警报组件
    ├── chart_widget.dart         # 图表组件
    └── device_list_item.dart     # 设备列表项组件
```

## 核心功能模块

### 1. 用户认证模块
- 用户登录
- 用户注册
- 密码修改
- 会话管理

### 2. 设备管理模块
- 设备列表显示
- 添加新设备
- 设备详情查看
- 设备信息编辑
- 设备状态监控

### 3. 数据分析模块
- 压力数据图表展示
- 历史数据查询
- 数据分页显示
- 时间范围筛选

### 4. 报警监控模块
- 实时压力监控
- 超阈值报警
- 报警信息推送
- 报警历史记录

### 5. 系统设置模块
- 密码修改
- 压力单位设置
- 系统配置

## 数据模型

### Device 设备模型
```dart
{
  id: int,                    // 设备ID
  name: String,               // 设备名称
  macAddress: String,         // MAC地址
  communicationChannel: String,// 通信通道
  threshold: double?,         // 压力阈值
  isOn: bool,                // 设备状态
  currentPressure: double?,   // 当前压力
}
```

### User 用户模型
```dart
{
  id: int,           // 用户ID
  username: String,  // 用户名
}
```

## 网络通信

### REST API
- 用户认证
- 设备管理
- 数据查询

### WebSocket
- 实时压力数据推送
- 报警信息推送

## UI 设计特点

- 采用 Material Design 设计规范
- 紫色主题配色方案
- 响应式布局设计
- 流畅的动画过渡效果
- 直观的数据可视化展示

## 开发环境配置

1. 安装 Flutter SDK
2. 配置 Android Studio 或 VS Code
3. 安装必要的依赖包:
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.0
  web_socket_channel: ^2.1.0
  fl_chart: ^0.36.0
  shared_preferences: ^2.0.0
```

## 如何运行

1. 克隆项目代码
```bash
git clone [项目地址]
```

2. 安装依赖
```bash
flutter pub get
```

3. 运行项目
```bash
flutter run
```

## 注意事项

1. 确保设备已连接到网络
2. 后端服务器需要正常运行
3. WebSocket 连接需要保持稳定
4. 注意数据安全性和隐私保护