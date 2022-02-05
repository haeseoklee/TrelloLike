import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trello_like/app/controllers/trello_controller.dart';
import 'package:trello_like/app/ui/widgets/trello_tile.dart';

class TrelloPage extends GetView<TrelloController> {
  const TrelloPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Trello Like'),
      ),
      child: SafeArea(child: GetBuilder<TrelloController>(
        builder: (controller) {
          return GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 40,
              childAspectRatio: 1.33,
              mainAxisExtent: 300,
            ),
            itemCount: controller.sections.length,
            itemBuilder: (context, index) {
              final sectionId = index;
              return TrelloTile(sectionId: sectionId);
            },
          );
        },
      )),
    );
  }
}
