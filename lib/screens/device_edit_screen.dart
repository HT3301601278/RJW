import 'package:flutter/material.dart';

import '../models/device.dart';
import '../services/device_service.dart';

class DeviceEditScreen extends StatefulWidget {
  final Device device;

  DeviceEditScreen({required this.device});

  @override
  _DeviceEditScreenState createState() => _DeviceEditScreenState();
}

class _DeviceEditScreenState extends State<DeviceEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late double _threshold;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _name = widget.device.name;
    _threshold = widget.device.threshold ?? 0.0;
  }

  void _saveDevice() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      Device updatedDevice = widget.device.copyWith(
        name: _name,
        threshold: _threshold,
        isOn: widget.device.isOn,
      );
      try {
        bool success = await DeviceService.updateDevice(updatedDevice);
        if (success) {
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('更新设备失败，请稍后重试')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('更新设备时发生错误：$e')),
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
          child: Column(
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
                      '编辑设备',
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
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.white.withOpacity(0.9),
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildTextField(
                              label: '设备名称',
                              initialValue: _name,
                              onSaved: (value) => _name = value!,
                              validator: (value) => value!.isEmpty ? '请输入设备名称' : null,
                            ),
                            SizedBox(height: 20),
                            _buildTextField(
                              label: '压力阈值',
                              initialValue: _threshold.toString(),
                              keyboardType: TextInputType.number,
                              onSaved: (value) => _threshold = double.parse(value!),
                              validator: (value) {
                                if (value!.isEmpty) return '请输入阈值';
                                if (double.tryParse(value) == null) return '请输入有效的数字';
                                return null;
                              },
                            ),
                            SizedBox(height: 40),
                            ElevatedButton(
                              onPressed: _isLoading ? null : _saveDevice,
                              child: _isLoading
                                  ? CircularProgressIndicator(color: Colors.white)
                                  : Text('保存', style: TextStyle(fontSize: 18)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple[300],
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.purple[700]),
        prefixIcon: Icon(label == '设备名称' ? Icons.devices : Icons.speed, color: Colors.purple[300]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
      ),
      style: TextStyle(color: Colors.purple[700]),
      keyboardType: keyboardType,
      onSaved: onSaved,
      validator: validator,
    );
  }
}