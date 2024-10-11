import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RealTimeChartPage extends StatefulWidget {
  @override
  _RealTimeChartPageState createState() => _RealTimeChartPageState();
}

class _RealTimeChartPageState extends State<RealTimeChartPage> {
  String _selectedTimeRange = '1小时';
  final List<String> _timeRanges = ['1小时', '6小时', '24小时'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('实时数据'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '当前压力值: 75.5 kPa',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '变化趋势: 上升',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedTimeRange,
              items: _timeRanges.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTimeRange = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: LineChart(
                LineChartData(
                  // TODO: 实现实时数据图表
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 3),
                        FlSpot(1, 1),
                        FlSpot(2, 4),
                        FlSpot(3, 2),
                        FlSpot(4, 5),
                      ],
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 2,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}