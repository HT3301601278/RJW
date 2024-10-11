import 'package:flutter/material.dart';

import '../models/device.dart';
import '../services/device_service.dart';
import '../widgets/device_list_item.dart';
import 'add_device_screen.dart';
import 'device_detail_screen.dart';

class DeviceListScreen extends StatefulWidget {
  @override
  _DeviceListScreenState createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  List<Device> _devices = [];
  int _currentPage = 0;
  int _totalPages = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDevices();
  }

  void _loadDevices() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Map<String, dynamic> result = await DeviceService.getDevices(page: _currentPage);
      setState(() {
        _devices = result['devices'];
        _totalPages = result['totalPages'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('加载设备列表失败：$e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '设备管理',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[700],
                  ),
                ),
              ),
              Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator(color: Colors.purple[300]))
                    : _devices.isEmpty
                        ? Center(
                            child: Text(
                              '暂无设备',
                              style: TextStyle(color: Colors.purple[700], fontSize: 18),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _devices.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  color: Colors.white.withOpacity(0.9),
                                  child: DeviceListItem(
                                    device: _devices[index],
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DeviceDetailScreen(device: _devices[index]),
                                        ),
                                      ).then((_) => _loadDevices());
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
              ),
              if (_totalPages > 1)
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _currentPage > 0 ? () {
                          setState(() {
                            _currentPage--;
                            _loadDevices();
                          });
                        } : null,
                        child: Text('上一页'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple[300],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        '${_currentPage + 1} / $_totalPages',
                        style: TextStyle(color: Colors.purple[700]),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _currentPage < _totalPages - 1 ? () {
                          setState(() {
                            _currentPage++;
                            _loadDevices();
                          });
                        } : null,
                        child: Text('下一页'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple[300],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDeviceScreen()),
          ).then((_) => _loadDevices());
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple[300],
        foregroundColor: Colors.white,
      ),
    );
  }
}