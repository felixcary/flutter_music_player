import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_player/Adapters/ApiServices/MusicPlayerApiService.dart';
import 'package:music_player/Routes/AppPages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(App());
}

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MusicPlayerApiService>(
      () => MusicPlayerApiService(),
      fenix: true,
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      defaultTransition: Transition.native,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.pages,
      initialBinding: AppBinding(),
    );
  }
}
