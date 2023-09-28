import 'package:flutter/material.dart';
import 'package:media_player/views/screen/first_page.dart';
import 'package:media_player/views/screen/home_page.dart';
import 'package:media_player/views/screen/song_page.dart';
import 'package:media_player/views/screen/splash_screen.dart';
import 'package:media_player/views/screen/tab_page.dart';
import 'package:media_player/views/screen/video_page.dart';
import 'package:provider/provider.dart';

import 'controller/indicator_controller.dart';
import 'controller/songs_controller.dart';
import 'controller/tab_bar_controller.dart';
import 'controller/video_controller.dart';
import 'modals/myRoutes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => audio_controller(),
        ),
        ChangeNotifierProvider(
          create: (context) => indicator(),
        ),
        ChangeNotifierProvider(
          create: (context) => VideoController(),
        ),
        ChangeNotifierProvider(
          create: (context) => TabBarController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.yellow,
      ),
      initialRoute: MyRoutes.Splash_Screen_Page,
      routes: {
        MyRoutes.HomePage: (context) => HomePage(),
        MyRoutes.First_Page: (context) => First_Page(),
        MyRoutes.songs_page: (context) => const songs_page(),
        MyRoutes.video_page: (context) => const video_page(),
        MyRoutes.Tab_Page: (context) => const Tab_Page(),
        MyRoutes.Splash_Screen_Page: (context) => const Splash_Screen_Page(),
      },
    );
  }
}
