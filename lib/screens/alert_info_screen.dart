import 'package:flutter/material.dart';

import '../services/websocket_service.dart';

class AlertInfoScreen extends StatefulWidget {
  @override
  _AlertInfoScreenState createState() => _AlertInfoScreenState();
}

class _AlertInfoScreenState extends State<AlertInfoScreen> {
  List<String> _alerts = [];

  @override
  void initState() {
    super.initState();
    WebSocketService.connect('ws://47.116.66.208:8080/ws/alerts', _handleAlertMessage);
  }

  void _handleAlertMessage(dynamic message) {
    setState(() {
      _alerts.add(message.toString());
    });
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.purple[700]),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      '警报信息',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[700],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _alerts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_off,
                              size: 80,
                              color: Colors.purple[300],
                            ),
                            SizedBox(height: 16),
                            Text(
                              '暂无警报信息',
                              style: TextStyle(
                                color: Colors.purple[700],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _alerts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              color: Colors.white.withOpacity(0.9),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.warning, color: Colors.white),
                                ),
                                title: Text(
                                  '压力警报',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple[700],
                                  ),
                                ),
                                subtitle: Text(
                                  _alerts[index],
                                  style: TextStyle(color: Colors.purple[300]),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.grey),
                                  onPressed: () {
                                    setState(() {
                                      _alerts.removeAt(index);
                                    });
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    WebSocketService.close('ws://47.116.66.208:8080/ws/alerts');
    super.dispose();
  }
}