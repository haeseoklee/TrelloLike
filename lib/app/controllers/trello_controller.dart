import 'package:get/get.dart';
import 'package:trello_like/app/data/model/item.dart';
import 'package:trello_like/app/data/model/section.dart';

class TrelloController extends GetxController {
  List<Section> sections = [
    Section(
        id: 0, title: 'A', items: [Item(title: '+', itemType: ItemType.add)]),
    Section(
        id: 1, title: 'B', items: [Item(title: '+', itemType: ItemType.add)]),
    Section(
        id: 2, title: 'C', items: [Item(title: '+', itemType: ItemType.add)]),
    Section(
        id: 3, title: 'D', items: [Item(title: '+', itemType: ItemType.add)]),
  ];

  String todo = '';

  void addSectionItem(int id, Item item) {
    sections[id].items.insert(sections[id].items.length - 1, item);
    update();
  }

  void updateSectionItem(int id, Item oldItem, Item newItem) {
    var idx = sections[id].items.indexOf(oldItem);
    sections[id].items[idx] = newItem;
    update();
  }

  void moveRightSectionItem(int id, Item item) {
    int newId = (id + 1) % sections.length;
    deleteSectionItem(id, item);
    addSectionItem(newId, item);
  }

  void moveLeftSectionItem(int id, Item item) {
    int newId = (id - 1) < 0 ? sections.length - 1 : id - 1;
    deleteSectionItem(id, item);
    addSectionItem(newId, item);
  }

  void deleteSectionItem(int id, Item item) {
    sections[id].items.remove(item);
    update();
  }

  void updateTodo(String newTodo) {
    todo = newTodo;
    update();
  }

  void resetTodo() {
    todo = '';
  }
}
