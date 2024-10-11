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
            colors: [Colors.purple.shade100, Colors.purple.shade200],
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.purple[700],
            unselectedItemColor: Colors.purple[300],
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            items: [
              _buildBottomNavigationBarItem(Icons.devices, '设备管理'),
              _buildBottomNavigationBarItem(Icons.analytics, '数据分析'),
              _buildBottomNavigationBarItem(Icons.warning, '警报信息'),
              _buildBottomNavigationBarItem(Icons.settings, '设置'),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.purple[50],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon),
      ),
      activeIcon: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.purple[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon),
      ),
      label: label,
    );
  }
}