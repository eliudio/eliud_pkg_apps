import 'package:eliud_core_main/model/drawer_model.dart';
import 'package:eliud_core_main/model/home_menu_model.dart';
import 'package:eliud_pkg_apps/apps/shared/about/founders/founders.dart';

import '../../install_app.dart';

class Who extends Founders {
  Who({
    InstallApp? installApp,
    HomeMenuModel? homeMenu,
    DrawerModel? drawer,
    DrawerModel? endDrawer,
  }) : super(
          installApp,
          homeMenu,
          drawer,
          endDrawer,
        );

  Future<void> run() {
    return doItForFounders();
  }

  @override
  String aboutText() =>
      "Hello guys. We are Thomas and Charlotte and we are the authors of Eliud. We need to build lots of websites ourselves, and we don't like to repeat, repeat is boring. So, we've built this platform to allow to quickly present lovely content, through all devices available. Flutter is technology that allows to quickly do this. However, it still requires coding. We like content management systems. However, they don't support future platforms, don't support apps. Bringing these 2 ideas together and eliud was born.";

  @override
  String aboutTitle() => "Who's who and why?";

  @override
  String aboutDescription() => "Who's who and why?";
}
