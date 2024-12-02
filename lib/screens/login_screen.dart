import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  bool _isLoading = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        bool success = await AuthService.login(_username, _password);
        if (success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('登录失败，请检查用户名和密码')),
          );
        }
      } catch (e) {
        print('登录错误: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('登录时发生错误：$e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
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
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.analytics,
                    size: 100,
                    color: Colors.purple[300],
                  ),
                  SizedBox(height: 24),
                  Text(
                    '反应器温度在线监测系统',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[700],
                    ),
                  ),
                  SizedBox(height: 48),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: '用户名',
                            prefixIcon: Icon(Icons.person, color: Colors.purple[300]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.9),
                          ),
                          validator: (value) => value!.isEmpty ? '请输入用户名' : null,
                          onSaved: (value) => _username = value!,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: '密码',
                            prefixIcon: Icon(Icons.lock, color: Colors.purple[300]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.9),
                          ),
                          obscureText: true,
                          validator: (value) => value!.isEmpty ? '请输入密码' : null,
                          onSaved: (value) => _password = value!,
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _login,
                          child: _isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text('登录', style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple[300],
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterScreen()),
                            );
                          },
                          child: Text('没有账号？点击注册', style: TextStyle(color: Colors.purple[700])),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}