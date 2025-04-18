import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'to_do_list_controller.dart';

class ToDoListPage extends StatelessWidget {
  final controller = Get.put(ToDoListController());
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: "Enter new task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (textController.text.trim().isNotEmpty) {
                      controller.addNote(textController.text.trim());
                      textController.clear();
                    }
                  },
                  child: Text("Add"),
                )
              ],
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.noteList.length,
              itemBuilder: (context, index) {
                final note = controller.noteList[index];
                return Card(
                  child: ListTile(
                    title: Text(note),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.orange),
                          onPressed: () {
                            final editController = TextEditingController(text: note);
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text('Edit Task'),
                                content: TextField(
                                  controller: editController,
                                  decoration: InputDecoration(
                                    hintText: 'New title',
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      controller.editNote(index, editController.text.trim());
                                      Get.back();
                                    },
                                    child: Text('Save'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            controller.deleteNote(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
          )
        ],
      ),
    );
  }
}
