import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Name App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  final TextEditingController _nameController = TextEditingController();


  static const String nameKey = 'user_name';


  String _userName = '';


  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _loadUserName();
  }


  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString(nameKey) ?? '';
    });
  }


  Future<void> _saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(nameKey, name);

    setState(() {
      _userName = name;
    });


    _nameController.clear();


    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tên đã được lưu thành công')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lưu và Hiển thị Tên Người Dùng'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Tên người dùng hiện tại:',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _userName.isEmpty ? 'Chưa có tên' : _userName,
                      style: TextStyle(
                        fontSize: 24,
                        color: _userName.isEmpty ? Colors.grey : Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),


            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Nhập tên mới:',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Nhập tên của bạn',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Vui lòng nhập tên';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () {

                      if (_formKey.currentState!.validate()) {
                        _saveUserName(_nameController.text.trim());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Lưu tên',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),


            if (_userName.isNotEmpty) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove(nameKey);
                  setState(() {
                    _userName = '';
                  });
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đã xóa tên người dùng')),
                    );
                  }
                },
                icon: const Icon(Icons.delete),
                label: const Text('Xóa tên'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {

    _nameController.dispose();
    super.dispose();
  }
}


//Cách hoạt động của ứng dụng:
//
// Khi khởi động, ứng dụng sẽ kiểm tra xem đã có tên người dùng được lưu trong SharedPreferences chưa
// Nếu có, tên sẽ được hiển thị ở phần "Tên người dùng hiện tại"
// Người dùng có thể nhập tên mới vào form và nhấn "Lưu tên"
// Sau khi lưu, tên mới sẽ được hiển thị và một thông báo "Tên đã được lưu thành công" sẽ xuất hiện
// Khi tắt ứng dụng và mở lại, tên đã lưu sẽ vẫn được hiển thị
// Nút "Xóa tên" sẽ xuất hiện nếu đã có tên được lưu, cho phép xóa tên hiện tại