
import 'package:flutter/material.dart';

void main() {
  runApp(HWApp());
}

class HWApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("Homework",style: TextStyle(color: Colors.black),),

            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed:() {},
                color: Colors.black
            ),
            actions:[
              Icon(Icons.menu, size: 30,color: Colors.black,),
            ]
        ),
        body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://kenh14cdn.com/203336854389633024/2024/3/8/photo-1-17099064375121449383356.jpg',
                height: 300,
                width: 300,
                fit: BoxFit.fill,),
              SizedBox(width: 15,),
              Text("Dragonball")
            ],
          ),

        )
    );

  }
}
