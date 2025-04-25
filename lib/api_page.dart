import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// Controllers
class PostController extends GetxController {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';
  var posts = <dynamic>[].obs;
  var isLoading = true.obs;
  var isGridView = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    isLoading(true);
    update();

    try {
      final response = await http.get(Uri.parse('$baseUrl/posts'));

      if (response.statusCode == 200) {
        posts.value = json.decode(response.body);
        isLoading(false);
        update();
      } else {
        Get.snackbar(
          'Error',
          'Lỗi khi tải dữ liệu: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
        isLoading(false);
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Lỗi kết nối: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading(false);
      update();
    }
  }

  void toggleView() {
    isGridView.value = !isGridView.value;
    update();
  }
}

class DetailController extends GetxController {
  final String baseUrl;
  final dynamic post;
  var comments = <dynamic>[].obs;
  var isLoadingComments = true.obs;

  DetailController({required this.baseUrl, required this.post});

  @override
  void onInit() {
    super.onInit();
    fetchComments();
  }

  Future<void> fetchComments() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts/${post['id']}/comments'),
      );

      if (response.statusCode == 200) {
        comments.value = json.decode(response.body);
        isLoadingComments(false);
        update();
      } else {
        Get.snackbar(
          'Error',
          'Lỗi khi tải bình luận: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
        isLoadingComments(false);
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Lỗi kết nối: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoadingComments(false);
      update();
    }
  }
}

class AddPostController extends GetxController {
  final String baseUrl;
  var isSubmitting = false.obs;
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final int userId = 1;

  AddPostController({required this.baseUrl});

  Future<bool> submitPost() async {
    isSubmitting(true);
    update();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        body: jsonEncode({
          'title': titleController.text,
          'body': bodyController.text,
          'userId': userId,
        }),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Bài viết đã được tạo thành công',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        isSubmitting(false);
        update();
        return true;
      } else {
        Get.snackbar(
          'Error',
          'Lỗi: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
        isSubmitting(false);
        update();
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Lỗi kết nối: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      isSubmitting(false);
      update();
      return false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    bodyController.dispose();
    super.onClose();
  }
}


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final PostController postController = Get.put(PostController(), permanent: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách API'),
        actions: [
          GetBuilder<PostController>(
            builder: (controller) => IconButton(
              icon: Icon(controller.isGridView.value
                  ? Icons.view_list
                  : Icons.grid_view),
              onPressed: controller.toggleView,
            ),
          ),
        ],
      ),
      body: GetBuilder<PostController>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.isGridView.value) {
            return _buildGridView(controller);
          } else {
            return _buildListView(controller);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          _navigateToAddPost(postController);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildListView(PostController controller) {
    return RefreshIndicator(
      onRefresh: controller.fetchPosts,
      child: ListView.builder(
        itemCount: controller.posts.length,
        itemBuilder: (context, index) {
          final post = controller.posts[index];
          return PostView(
            post: post,
            onTap: () => _navigateToDetail(post, controller.baseUrl),
            isGridView: false,
          );
        },
      ),
    );
  }

  Widget _buildGridView(PostController controller) {
    return RefreshIndicator(
      onRefresh: controller.fetchPosts,
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: controller.posts.length,
        itemBuilder: (context, index) {
          final post = controller.posts[index];
          return PostView(
            post: post,
            onTap: () => _navigateToDetail(post, controller.baseUrl),
            isGridView: true,
          );
        },
      ),
    );
  }

  void _navigateToDetail(dynamic post, String baseUrl) {
    Get.to(() => DetailPage(post: post, baseUrl: baseUrl));
  }

  void _navigateToAddPost(PostController controller) {

    Get.to(() => AddPostPage(baseUrl: controller.baseUrl))?.then((result) {
      if (result == true) {

        controller.fetchPosts();
      }
    });
  }
}

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

class DetailPage extends StatelessWidget {
  final dynamic post;
  final String baseUrl;

  const DetailPage({Key? key, required this.post, required this.baseUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(DetailController(baseUrl: baseUrl, post: post));

    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết bài viết số ${post['id']}'),
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
                      post['title'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tác giả: Unknow',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Text(post['body']),
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

            GetBuilder<DetailController>(
              builder: (controller) {
                if (controller.isLoadingComments.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.comments.isEmpty) {
                  return const Center(child: Text('No comment yet'));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.comments.length,
                    itemBuilder: (context, index) {
                      final comment = controller.comments[index];
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
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
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
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddPostPage extends StatelessWidget {
  final String baseUrl;

  const AddPostPage({Key? key, required this.baseUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(AddPostController(baseUrl: baseUrl));
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm bài viết mới'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: controller.titleController,
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
                controller: controller.bodyController,
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
              GetBuilder<AddPostController>(
                builder: (controller) => ElevatedButton(
                  onPressed: controller.isSubmitting.value
                      ? null
                      : () async {
                    if (formKey.currentState!.validate()) {
                      final success = await controller.submitPost();
                      if (success) {

                        Get.back(result: true);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: controller.isSubmitting.value
                      ? const CircularProgressIndicator()
                      : const Text(
                    'Đăng bài viết',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}