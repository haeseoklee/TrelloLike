import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trello_like/app/controllers/trello_controller.dart';
import 'package:trello_like/app/data/model/item.dart';

class TrelloTile extends GetView<TrelloController> {
  final int sectionId;

  const TrelloTile({Key? key, required this.sectionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void showAlert(title, oldItem, mode, context, buttonHandler) {
      if (mode == showAlertType.edit) {
        controller.updateTodo((oldItem as Item).title);
      }
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: CupertinoTextFormFieldRow(
              initialValue: controller.todo,
              padding: EdgeInsets.zero,
              placeholder: 'item',
              onChanged: (value) {
                controller.updateTodo(value);
              },
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('OK'),
                onPressed: () {
                  if (controller.todo.isEmpty) {
                    return;
                  }
                  Get.back();
                  final item =
                      Item(title: controller.todo, itemType: ItemType.todo);
                  buttonHandler(oldItem, item);
                },
              ),
            ],
          );
        },
      );
    }

    Widget _addItemButton(item) => CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            showAlert('Add Item', item, showAlertType.add, context,
                (oldItem, newItem) {
              controller.addSectionItem(sectionId, newItem);
              controller.resetTodo();
            });
          },
          child: Center(
            child: Text(
              item.title,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(color: CupertinoColors.black, fontSize: 18),
            ),
          ),
        );

    Widget _addItem(item) => Container(
          alignment: Alignment.center,
          height: 40.0,
          width: 250.0,
          color: CupertinoColors.white,
          child: Center(
            child: _addItemButton(item),
          ),
        );

    Widget _leftMoveButton(item) => sectionId == 0
        ? const SizedBox(width: 50.0)
        : CupertinoButton(
            padding: EdgeInsets.zero,
            child:
                const Text('<', style: TextStyle(color: CupertinoColors.black)),
            onPressed: () {
              controller.moveLeftSectionItem(sectionId, item);
            },
          );

    Widget _middleTitleButton(item) => CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            showAlert(
              'Edit Item',
              item,
              showAlertType.edit,
              context,
              (oldItem, newItem) {
                controller.updateSectionItem(sectionId, oldItem, newItem);
                controller.resetTodo();
              },
            );
          },
          child: SizedBox(
            width: 150,
            child: Text(
              item.title,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: const TextStyle(
                  color: CupertinoColors.black,
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
        );

    Widget _rightMoveButton(item) => sectionId == controller.sections.length - 1
        ? const SizedBox(width: 50.0)
        : CupertinoButton(
            padding: EdgeInsets.zero,
            child:
                const Text('>', style: TextStyle(color: CupertinoColors.black)),
            onPressed: () {
              controller.moveRightSectionItem(sectionId, item);
            },
          );

    Widget _todoItem(item) => Container(
          height: 40.0,
          width: 250.0,
          color: CupertinoColors.white,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _leftMoveButton(item),
                _middleTitleButton(item),
                _rightMoveButton(item),
              ],
            ),
          ),
        );

    Widget _sectionTitle = Container(
      decoration: BoxDecoration(
        color: const Color(0xffcfcfcf),
        border: Border.all(color: CupertinoColors.black),
      ),
      height: 40.0,
      width: double.infinity,
      child: Center(
        child: Text(
          controller.sections[sectionId].title,
          textAlign: TextAlign.center,
          style: const TextStyle(color: CupertinoColors.black, fontSize: 20),
        ),
      ),
    );

    Widget _sectionList = Container(
      height: 400,
      decoration: BoxDecoration(
        color: const Color(0xffcfcfcf),
        border: Border.all(color: CupertinoColors.black),
      ),
      child: GetBuilder<TrelloController>(
        builder: (controller) {
          return ListView.separated(
            padding: const EdgeInsets.all(10.0),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final item = controller.sections[sectionId].items[index];
              return item.itemType == ItemType.add
                  ? _addItem(item)
                  : _todoItem(item);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10.0);
            },
            itemCount: controller.sections[sectionId].items.length,
          );
        },
      ),
    );

    return Column(
      children: [
        _sectionTitle,
        _sectionList,
      ],
    );
  }
}

enum showAlertType { add, edit }
