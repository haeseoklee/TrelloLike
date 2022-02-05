import 'package:trello_like/app/data/model/item.dart';

class Section {
  int id;
  String title;
  List<Item> items;

  Section({required this.id, required this.title, required this.items});
}
