import 'package:get/get.dart';
import 'package:trello_like/app/bindings/trello_binding.dart';
import 'package:trello_like/app/routes/app_routes.dart';
import 'package:trello_like/app/ui/pages/trello_page.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => const TrelloPage(),
      binding: TrelloBinding(),
    ),
  ];
}
