import 'package:flutter/material.dart';

class DeviceListPage extends StatefulWidget {
  @override
  _DeviceListPageState createState() => _DeviceListPageState();
}

class _DeviceListPageState extends State<DeviceListPage> {
  final List<Map<String, dynamic>> _devices = [
    {'name': '反应器1', 'macAddress': '00:11:22:33:44:55', 'status': true},
    {'name': '反应器2', 'macAddress': '66:77:88:99:AA:BB', 'status': false},
    {'name': '反应器3', 'macAddress': 'CC:DD:EE:FF:00:11', 'status': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设备列表'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _devices.length,
        itemBuilder: (context, index) {
          final device = _devices[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: Icon(
                Icons.device_hub,
                color: device['status'] ? Colors.green : Colors.red,
              ),
              title: Text(device['name']),
              subtitle: Text(device['macAddress']),
              trailing: Chip(
                label: Text(
                  device['status'] ? '在线' : '离线',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: device['status'] ? Colors.green : Colors.red,
              ),
              onTap: () => Navigator.pushNamed(context, '/deviceDetail'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // TODO: 实现添加新设备的逻辑
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.devices), label: '设备列表'),
          BottomNavigationBarItem(icon: Icon(Icons.warning), label: '警报列表'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '设置'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/alertList');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/settings');
          }
        },
      ),
    );
  }
}