import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DeviceDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设备详情'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('设备名称: 反应器1', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('MAC地址: 00:11:22:33:44:55'),
                    Text('通信通道: WiFi'),
                    Text('阈值: 100 kPa'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('当前压力', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('75.5 kPa', style: TextStyle(fontSize: 36, color: Colors.blue)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('实时数据图表 (最近1小时)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    Container(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                          // TODO: 实现实时数据图表
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.history),
                  label: Text('查看历史数据'),
                  onPressed: () => Navigator.pushNamed(context, '/historyData'),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.tune),
                  label: Text('设置阈值'),
                  onPressed: () {
                    // TODO: 实现设置阈值的逻辑
                  },
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.power_settings_new),
                  label: Text('切换状态'),
                  onPressed: () {
                    // TODO: 实现切换设备开关状态的逻辑
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}