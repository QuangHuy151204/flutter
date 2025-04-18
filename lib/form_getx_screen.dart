import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormGetXScreen extends StatefulWidget {
  @override
  _FormGetXScreenState createState() => _FormGetXScreenState();
}

class _FormGetXScreenState extends State<FormGetXScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Lesson 7',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Form với GetX',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Ví dụ form đăng ký sử dụng GetX:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Họ và tên:'),
                    SizedBox(height: 4),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 16),
                    Text('Email:'),
                    SizedBox(height: 4),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 16),
                    Text('Mật khẩu:'),
                    SizedBox(height: 4),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberLogin,
                          onChanged: (value) {
                            setState(() {
                              _rememberLogin = value!;
                            });
                          },
                        ),
                        Text('Ghi nhớ đăng nhập'),
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Giá trị hiện tại:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text('Tên: ${_nameController.text}'),
                          Text('Email: ${_emailController.text}'),
                          Text('Mật khẩu: ${_passwordController.text.isNotEmpty ? "••••••••" : ""}'),
                          Text('Ghi nhớ: ${_rememberLogin ? "true" : "false"}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Quay lại'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}