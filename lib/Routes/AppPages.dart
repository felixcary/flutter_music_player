import 'package:get/route_manager.dart';
import 'package:music_player/Views/Views.dart';

part 'AppRoutes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
    ),
  ];
}
