import 'package:get/get.dart';
import 'package:trello_like/app/controllers/trello_controller.dart';

class TrelloBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return TrelloController();
    });
  }
}
