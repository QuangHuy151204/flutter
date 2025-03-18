import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'Welcome to Flutter!',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Align(
                alignment: Alignment.center,
                child: Image.network(
                  'https://inkythuatso.com/uploads/thumbnails/800/2023/02/hinh-anh-cho-con-de-thuong-chay-tung-tang-1-24-11-43-28.jpg',
                  width: 400,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 40),

            Align(
              alignment: Alignment.center,
              child: Builder(
                builder: (context) => TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Snackbar'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ảnh về những chú chó',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(width: 20),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                        size: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      'https://i.pinimg.com/736x/72/c2/cb/72c2cb9433178f6deab0bc9ea5abfea9.jpg',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      "Theo một báo cáo cuối năm 2024, trong năm qua cả...",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: 50),

            Builder(
              builder: (context) => TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Read more about dogs: https://vnexpress.net/tag/cho-23677',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      duration: Duration(seconds: 5),
                      backgroundColor: Colors.blueGrey,
                    ),
                  );
                },
                child: Text(
                  'More about Dogs 🐶',
                  style: TextStyle(fontSize: 30, color: Colors.green),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ));
}
