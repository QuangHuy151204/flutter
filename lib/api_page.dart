import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';
  List<dynamic> _posts = [];
  bool _isLoading = true;
  bool _isGridView = false;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse('$baseUrl/posts'));

      if (response.statusCode == 200) {
        setState(() {
          _posts = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        _showErrorSnackBar('Lỗi khi tải dữ liệu: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      _showErrorSnackBar('Lỗi kết nối: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _navigateToDetail(dynamic post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(post: post, baseUrl: baseUrl),
      ),
    );
  }

  void _navigateToAddPost() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPostPage(baseUrl: baseUrl),
      ),
    ).then((value) {
      if (value == true) {
        _fetchPosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách API'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _isGridView
          ? _buildGridView()
          : _buildListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddPost,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildListView() {
    return RefreshIndicator(
      onRefresh: _fetchPosts,
      child: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return PostView(
            post: post,
            onTap: () => _navigateToDetail(post),
            isGridView: false,
          );
        },
      ),
    );
  }

  Widget _buildGridView() {
    return RefreshIndicator(
      onRefresh: _fetchPosts,
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return PostView(
            post: post,
            onTap: () => _navigateToDetail(post),
            isGridView: true,
          );
        },
      ),
    );
  }
}

// Widget PostView được tạo mới
class PostView extends StatelessWidget {
  final dynamic post;
  final VoidCallback onTap;
  final bool isGridView;

  const PostView({
    Key? key,
    required this.post,
    required this.onTap,
    required this.isGridView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isGridView) {
      return _buildGridItem();
    } else {
      return _buildListItem();
    }
  }

  Widget _buildListItem() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(
          post['title'],
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          post['body'],
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildGridItem() {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID: ${post['id']}',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                post['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  post['body'],
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final dynamic post;
  final String baseUrl;

  const DetailPage({Key? key, required this.post, required this.baseUrl}) : super(key: key);

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  List<dynamic> _comments = [];
  bool _isLoadingComments = true;

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    try {
      final response = await http.get(
        Uri.parse('${widget.baseUrl}/posts/${widget.post['id']}/comments'),
      );

      if (response.statusCode == 200) {
        setState(() {
          _comments = json.decode(response.body);
          _isLoadingComments = false;
        });
      } else {
        _showErrorSnackBar('Lỗi khi tải bình luận: ${response.statusCode}');
        setState(() {
          _isLoadingComments = false;
        });
      }
    } catch (e) {
      _showErrorSnackBar('Lỗi kết nối: $e');
      setState(() {
        _isLoadingComments = false;
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết bài viết số ${widget.post['id']}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post details
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post['title'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tác giả: Unknow',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Text(widget.post['body']),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Comments section
            const Text(
              'Comment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            _isLoadingComments
                ? const Center(child: CircularProgressIndicator())
                : _comments.isEmpty
                ? const Center(child: Text('No comment yet'))
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                final comment = _comments[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person, size: 16),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                comment['name'],
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.email, size: 16),
                            const SizedBox(width: 8),
                            Text(comment['email']),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(comment['body']),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddPostPage extends StatefulWidget {
  final String baseUrl;

  const AddPostPage({Key? key, required this.baseUrl}) : super(key: key);

  @override
  AddPostPageState createState() => AddPostPageState();
}

class AddPostPageState extends State<AddPostPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final int _userId = 1;
  bool _isSubmitting = false;

  Future<void> _submitPost() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final response = await http.post(
        Uri.parse('${widget.baseUrl}/posts'),
        body: jsonEncode({
          'title': _titleController.text,
          'body': _bodyController.text,
          'userId': _userId,
        }),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
      );

      if (context.mounted) {
        if (response.statusCode == 201) {

          final createdPost = json.decode(response.body);



          Navigator.pop(context, true);
        } else {

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lỗi: ${response.statusCode}')),
          );
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi kết nối: $e')),
        );
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm bài viết mới'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Tiêu đề',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tiêu đề';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(
                  labelText: 'Nội dung',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập nội dung';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitPost,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text(
                  'Đăng bài viết',
                  style: TextStyle(fontSize: 16),
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
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
}