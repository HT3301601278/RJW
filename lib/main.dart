import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/device_list_page.dart';
import 'pages/device_detail_page.dart';
import 'pages/real_time_chart_page.dart';
import 'pages/history_data_page.dart';
import 'pages/alert_list_page.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '反应器压力监测系统',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/deviceList': (context) => DeviceListPage(),
        '/deviceDetail': (context) => DeviceDetailPage(),
        '/realTimeChart': (context) => RealTimeChartPage(),
        '/historyData': (context) => HistoryDataPage(),
        '/alertList': (context) => AlertListPage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}