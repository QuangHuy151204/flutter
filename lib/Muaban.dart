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
  bool isGridView = false;
  List<Product> products = [
    Product(
        name: "Lốp xe",
        imageUrl:
            "https://www.bridgestone.com.vn/content/dam/bridgestone/consumer/bst/apac/vn/tyre-categories/alenza/ALENZA_001.jpg/_jcr_content/renditions/cq5dam.thumbnail.319.319.png",
        isFavorite: false,
        price: 200000),
    Product(
        name: "Đèn pha",
        imageUrl:
            "https://nclighting.vn/wp-content/uploads/2019/12/%C4%90%C3%A8n-Pha-Led-Cao-%C3%81p-100W-PNC02-org.jpg",
        isFavorite: false,
        price: 500000),
    Product(
        name: "Gương chiếu hậu",
        imageUrl:
            "https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-m07mqv0c9v5958",
        isFavorite: false,
        price: 300000),
    Product(
        name: "Cản trước",
        imageUrl:
            "https://static-cms-prod.vinfastauto.com/can-truoc-o-to-la-gi_16617849941.jpg",
        isFavorite: false,
        price: 700000),
    Product(
        name: "Cản sau",
        imageUrl:
            "https://file.sedanviet.vn/Images/AutoPart/86610h7230/can-sau-1.jpg",
        isFavorite: false,
        price: 600000),
    Product(
        name: "Bánh xe dự phòng",
        imageUrl:
            "https://www.bridgestone.com.vn/content/dam/bridgestone/consumer/bst/apac/vn/tyre-categories/alenza/ALENZA_001.jpg/_jcr_content/renditions/cq5dam.thumbnail.319.319.png",
        isFavorite: false,
        price: 250000),
    Product(
        name: "Bình ắc quy",
        imageUrl:
            "https://acquychinhhang.vn/upload/sanpham/wp12-12nse-5822.jpg",
        isFavorite: false,
        price: 350000),
    Product(
        name: "Má phanh",
        imageUrl:
            "https://cdn-prod-sg.yepgarage.info/upload/car-service-vn/file/66f67e890dd3a026b6e92ea3/cach-thay-ma-phanh-o-to.jpg",
        isFavorite: false,
        price: 150000),
  ];

  List<Product> cart = [];

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
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(cart: cart),
                ),
              );
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
        return _buildProductItem(products[index]);
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
        return _buildProductItem(products[index]);
      },
    );
  }

  Widget _buildProductItem(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(product: product),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.network(
                  product.imageUrl,
                  width: 200,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    icon: Icon(product.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    color: product.isFavorite ? Colors.red : Colors.grey,
                    onPressed: () {
                      setState(() {
                        product.isFavorite = !product.isFavorite;
                      });
                    },
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      setState(() {
                        cart.add(product);
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
            Text("${product.price} VNĐ",
                style: TextStyle(fontSize: 16, color: Colors.red)),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final String imageUrl;
  bool isFavorite;
  final double price;

  Product(
      {required this.name,
      required this.imageUrl,
      required this.isFavorite,
      required this.price});
}

class DetailScreen extends StatelessWidget {
  final Product product;

  DetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _showExitConfirmationDialog(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              product.imageUrl,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(product.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("${product.price} VNĐ",
                style: TextStyle(fontSize: 20, color: Colors.red)),
          ],
        ),
      ),
    );
  }
}

void _showExitConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Xác nhận"),
      content: Text("Bạn có chắc muốn quay lại?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Không"),
        ),
        TextButton(
          onPressed: () =>
              Navigator.of(context).popUntil((route) => route.isFirst),
          child: Text("Có"),
        ),
      ],
    ),
  );
}

class CartScreen extends StatelessWidget {
  final List<Product> cart;

  CartScreen({required this.cart});

  @override
  Widget build(BuildContext context) {
    double total = cart.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ hàng"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(cart[index].imageUrl,
                      width: 50, height: 50),
                  title: Text(cart[index].name),
                  trailing: Text("${cart[index].price} VNĐ"),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tổng cộng:", style: TextStyle(fontSize: 20)),
                Text("$total VNĐ",
                    style: TextStyle(fontSize: 20, color: Colors.red)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
