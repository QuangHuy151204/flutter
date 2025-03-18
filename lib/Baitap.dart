import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Test')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '123',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 20),


                  SizedBox(width: 20),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 40,
                  ),
                ],
              ),
              SizedBox(height: 40),

              Column(
                children: [
                  Text(
                    '123',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),


                  SizedBox(height: 10),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 40

                  )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}