import 'package:get/get.dart';

class ToDoListController extends GetxController {
  RxList<String> noteList = <String>[].obs;

  ToDoListController() {
    noteList.addAll(["To do 1", "To do 2"]);
  }

  void addNote(String title) {
    noteList.add(title);
  }

  void editNote(int index, String newTitle) {
    noteList[index] = newTitle;
  }

  void deleteNote(int index) {
    noteList.removeAt(index);
  }
}
