import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter GetX Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}


class CounterController extends GetxController {
  var count = 0.obs;

  void increment() {
    count++;
  }

  void decrement() {
    count--;
  }

  void reset() {
    count.value = 0;
  }
}

class HomePage extends StatelessWidget {
  final CounterController counterController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Counter values:',
              style: TextStyle(fontSize: 30),
            ),

            Obx(
                  () => Text(
                '${counterController.count}',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton(
                  onPressed: counterController.decrement,
                  child: Icon(Icons.remove),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                ),
                SizedBox(width: 20),

                ElevatedButton(
                  onPressed: counterController.reset,
                  child: Text('RESET', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
                SizedBox(width: 20),

                ElevatedButton(
                  onPressed: counterController.increment,
                  child: Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
//tạo một view thể hiện mảng to do list , mảng đc khai báo trong controller