import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class HistoryDataPage extends StatefulWidget {
  @override
  _HistoryDataPageState createState() => _HistoryDataPageState();
}

class _HistoryDataPageState extends State<HistoryDataPage> {
  DateTime _startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime _endDate = DateTime.now();
  bool _showChart = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('历史数据'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    child: Text('开始日期: ${DateFormat('yyyy-MM-dd').format(_startDate)}'),
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _startDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null && picked != _startDate) {
                        setState(() {
                          _startDate = picked;
                        });
                      }
                    },
                  ),
                ),
                Expanded(
                  child: TextButton(
                    child: Text('结束日期: ${DateFormat('yyyy-MM-dd').format(_endDate)}'),
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _endDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null && picked != _endDate) {
                        setState(() {
                          _endDate = picked;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ToggleButtons(
                  children: [
                    Icon(Icons.show_chart),
                    Icon(Icons.table_chart),
                  ],
                  isSelected: [_showChart, !_showChart],
                  onPressed: (int index) {
                    setState(() {
                      _showChart = index == 0;
                    });
                  },
                ),
                ElevatedButton(
                  child: Text('导出数据'),
                  onPressed: () {
                    // TODO: 实现数据导出功能
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: _showChart ? _buildChart() : _buildTable(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    return LineChart(
      LineChartData(
        // TODO: 实现历史数据图表
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
    );
  }

  Widget _buildTable() {
    return ListView.builder(
      itemCount: 10, // TODO: 替换为实际的数据条数
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('2023-06-${index + 1}'),
          trailing: Text('${70 + index}.5 kPa'),
        );
      },
    );
  }
}