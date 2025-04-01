import 'package:flutter/material.dart';
import 'laptop.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Wrap(
          children: [
            Text(
              'F',
              style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.blue),
            ),
            Text(
              'P',
              style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.orange),
            ),
            Text(
              'T',
              style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.green),
            ),
            SizedBox(width: 10,),
            Text(
              'Shop',
              style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Baseline(
              baseline: 17, // Điều chỉnh vị trí xuống dưới
              baselineType: TextBaseline.alphabetic,
              child: Text(
                '.com.vn',
                style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => Laptop(),
                      )
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(400, 200),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  backgroundColor: Colors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Positioned(
                      left: 40,
                      child: Text('Laptop', style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(width: 30,),
                    Image.network(
                      'https://i5.walmartimages.com/asr/1ba66cba-c16d-45b1-b051-536ddbc0ea94.f9c34f840f118549ad2fdbdfd931f3ae.jpeg',
                      width: 200,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  ],
                )
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => Laptop(),
                          )
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(180, 100),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Positioned(
                          left: 40,
                          child: Text('iPhone', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(width: 10,),
                        Image.network(
                          'https://cdn2.fptshop.com.vn/unsafe/750x0/filters:quality(100)/2023_9_20_638307989548944936_iphone-15-promax-xanh-1.jpg',
                          width: 70,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                      ],
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => Laptop(),
                          )
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(180, 100),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Positioned(
                          left: 40,
                          child: Text('Tủ lạnh', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(width: 10,),
                        Image.network(
                          'https://cdn2.fptshop.com.vn/unsafe/750x0/filters:quality(100)/2024_6_10_638536307431904817_casper-458-lit-rs-460pg-5.jpg',
                          width: 70,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                      ],
                    )
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => Laptop(),
                      )
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(400, 200),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  backgroundColor: Colors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Positioned(
                      left: 40,
                      child: Text('Phụ kiện', style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(width: 30,),
                    Image.network(
                      'https://cdn2.fptshop.com.vn/unsafe/640x0/filters:quality(100)/Phu_kien_41434d66e5.png',
                      width: 170,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  ],
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => Laptop(),
                      )
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(200, 100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  backgroundColor: Colors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Positioned(
                      left: 40,
                      child: Text('SIM FPT', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(width: 10,),
                    Image.network(
                      'https://cdn2.fptshop.com.vn/unsafe/180x0/filters:quality(100)/sim_fpt_thumb_2_d50e064a42.png',
                      width: 70,
                      height: 80,
                      fit: BoxFit.cover,
                    )
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }
}