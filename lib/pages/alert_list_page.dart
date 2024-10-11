import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlertListPage extends StatefulWidget {
  @override
  _AlertListPageState createState() => _AlertListPageState();
}

class _AlertListPageState extends State<AlertListPage> {
  final List<Map<String, dynamic>> _alerts = [
    {'deviceName': '反应器1', 'time': DateTime.now().subtract(Duration(hours: 2)), 'value': 110.5},
    {'deviceName': '反应器2', 'time': DateTime.now().subtract(Duration(hours: 5)), 'value': 105.2},
    {'deviceName': '反应器3', 'time': DateTime.now().subtract(Duration(hours: 8)), 'value': 108.7},
  ];

  String _selectedDevice = '全部';
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('警报列表'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _alerts.length,
        itemBuilder: (context, index) {
          final alert = _alerts[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: Icon(Icons.warning, color: Colors.red),
              title: Text(alert['deviceName']),
              subtitle: Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(alert['time'])),
              trailing: Text('${alert['value']} kPa', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                // TODO: 实现查看警报详情的逻辑
              },
            ),
          );
        },
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('筛选警报'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: _selectedDevice,
                items: ['全部', '反应器1', '反应器2', '反应器3'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDevice = newValue!;
                  });
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text('选择开始日期'),
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _startDate ?? DateTime.now(),
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
              SizedBox(height: 10),
              ElevatedButton(
                child: Text('选择结束日期'),
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _endDate ?? DateTime.now(),
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
            ],
          ),
          actions: [
            TextButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('应用'),
              onPressed: () {
                // TODO: 实现筛选逻辑
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}