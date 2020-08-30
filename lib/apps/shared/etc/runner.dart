import 'package:eliud_core/model/menu_def_model.dart';

abstract class Runner {
  Future<void> run();
}

abstract class MenuRunner {
  Future<MenuDefModel> run(MenuDefModel adminMenu);
}

