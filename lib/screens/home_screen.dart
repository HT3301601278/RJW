import 'package:flutter/material.dart';

import '../services/websocket_service.dart';
import '../widgets/alert_widget.dart';
import 'alert_info_screen.dart';
import 'data_analysis_screen.dart';
import 'device_list_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _alertMessage;
  int _currentIndex = 0;

  final List<Widget> _screens = [
    DeviceListScreen(),
    DataAnalysisScreen(),
    AlertInfoScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WebSocketService.connect('ws://47.116.66.208:8080/ws', _handleWebSocketMessage);
  }

  void _showAlert(String message) {
    setState(() {
      _alertMessage = message;
    });
  }

  void _handleWebSocketMessage(dynamic message) {
    if (message is String) {
      _showAlert(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade300, Colors.blue.shade700],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              if (_alertMessage != null) AlertWidget(message: _alertMessage!),
              Expanded(
                child: _screens[_currentIndex],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue.shade700,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.devices),
            label: '设备管理',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: '数据分析',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: '警报信息',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '设置',
          ),
        ],
      ),
    );
  }
}