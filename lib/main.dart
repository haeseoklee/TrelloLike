import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trello_like/app/routes/app_pages.dart';
import 'package:trello_like/app/routes/app_routes.dart';

void main() {
  runApp(GetCupertinoApp(
    initialRoute: Routes.HOME,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
  ));
}
