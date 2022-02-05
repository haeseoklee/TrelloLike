class Item {
  String title;
  ItemType itemType;

  Item({required this.title, required this.itemType});
}

enum ItemType { todo, add }
