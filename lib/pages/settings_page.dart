import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _dataRefreshInterval = '5分钟';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('用户信息'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 导航到用户信息页面
            },
          ),
          Divider(),
          SwitchListTile(
            title: Text('启用通知'),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          ListTile(
            title: Text('数据刷新间隔'),
            trailing: DropdownButton<String>(
              value: _dataRefreshInterval,
              onChanged: (String? newValue) {
                setState(() {
                  _dataRefreshInterval = newValue!;
                });
              },
              items: <String>['1分钟', '5分钟', '10分钟', '30分钟']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          SwitchListTile(
            title: Text('夜间模式'),
            value: _darkModeEnabled,
            onChanged: (bool value) {
              setState(() {
                _darkModeEnabled = value;
              });
              // TODO: 实现夜间模式切换逻辑
            },
          ),
          Divider(),
          ListTile(
            title: Text('关于'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: '反应器压力监测系统',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2023 Your Company',
              );
            },
          ),
          ListTile(
            title: Text('退出登录'),
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            onTap: () {
              // TODO: 实现退出登录逻辑
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}