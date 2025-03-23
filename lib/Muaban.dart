import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductScreen(),
    );
  }
}

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool isGridView = false; // Chuyển đổi giữa ListView và GridView
  List<Product> products = [
    Product(name: "Lốp xe", imageUrl: "https://www.bridgestone.com.vn/content/dam/bridgestone/consumer/bst/apac/vn/tyre-categories/alenza/ALENZA_001.jpg/_jcr_content/renditions/cq5dam.thumbnail.319.319.png", isFavorite: false),
    Product(name: "Đèn pha", imageUrl: "https://nclighting.vn/wp-content/uploads/2019/12/%C4%90%C3%A8n-Pha-Led-Cao-%C3%81p-100W-PNC02-org.jpg", isFavorite: false),
    Product(name: "Gương chiếu hậu", imageUrl: "https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-m07mqv0c9v5958", isFavorite: false),
    Product(name: "Cản trước", imageUrl: "https://static-cms-prod.vinfastauto.com/can-truoc-o-to-la-gi_16617849941.jpg", isFavorite: false),
    Product(name: "Cản sau", imageUrl: "https://file.sedanviet.vn/Images/AutoPart/86610h7230/can-sau-1.jpg", isFavorite: false),
    Product(name: "Bánh xe dự phòng", imageUrl: "https://dinhcam.com/cms/static/site/sale_dinhcam1/uploads/news/news.avatar.95dfacfbc1e21db4.6c6f702d64752d70686f6e672d312e6a7067.jpg", isFavorite: false),
    Product(name: "Bình ắc quy", imageUrl: "https://acquychinhhang.vn/upload/sanpham/wp12-12nse-5822.jpg", isFavorite: false),
    Product(name: "Má phanh", imageUrl: "https://cdn-prod-sg.yepgarage.info/upload/car-service-vn/file/66f67e890dd3a026b6e92ea3/cach-thay-ma-phanh-o-to.jpg", isFavorite: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh mục phụ tùng ô tô"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
        ],
      ),
      body: isGridView ? _buildGridView() : _buildListView(),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductItem(products[index], isGrid: false);
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductItem(products[index], isGrid: true);
      },
    );
  }

  Widget _buildProductItem(Product product, {required bool isGrid}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(product.imageUrl, width: 100, height: 100, fit: BoxFit.cover),
          SizedBox(height: 8),
          Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text("20,000 VNĐ", style: TextStyle(color: Colors.red, fontSize: 16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
                color: product.isFavorite ? Colors.red : Colors.grey,
                onPressed: () {
                  setState(() {
                    product.isFavorite = !product.isFavorite;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("${product.name} đã được thêm vào giỏ hàng!"),
                  ));
                },
                child: Text("Mua hàng"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final String imageUrl;
  bool isFavorite;

  Product({required this.name, required this.imageUrl, required this.isFavorite});
}