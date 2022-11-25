import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:ltm/provider/audio_state.dart';
import 'package:ltm/provider/user_state.dart';
import 'package:ltm/screens/about_screen/about_screen.dart';
import 'package:ltm/screens/admin_screen/admin_screen.dart';
import 'package:ltm/screens/home_screen/home_screen.dart';
import 'package:ltm/screens/setting_screen/setting_screen.dart';
import 'package:ltm/screens/welcome_screen/login.dart';
import 'package:ltm/screens/music_screen/list_music_screen.dart';
import 'package:ltm/screens/video_screen/list_video_screen.dart';
import 'package:ltm/screens/welcome_screen/registration_screen.dart';
import 'package:ltm/screens/welcome_screen/welcome.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'configs/basic_configs.dart';

Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await setupHive();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserState()),
      ChangeNotifierProvider(create: (_) => AudioState())
    ],
    builder: (context, child) {
      context.read<UserState>().initData();
      return const MyApp();
    },
  ));
}


//TODO innit Hive storage
Future setupHive() async {
  Directory documents = await getApplicationDocumentsDirectory();
  Hive.init(documents.path);
  await Hive.openBox(boxUserSettingName);

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
@override
  void initState() {
    super.initState();
    offFlashScreen();
  }

   void offFlashScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
        home: MyHome(),
        routes: {
          MyHome.id: (BuildContext ctx) => MyHome(),
          AdminScreen.id : (BuildContext ctx) => AdminScreen(),
          WelcomeScreen.id: (BuildContext ctx) => WelcomeScreen(),
          ListMusicScreen.id: (BuildContext ctx) => ListMusicScreen(),
          ListVideoScreen.id: (BuildContext ctx) => ListVideoScreen(),
          AboutScreen.id: (BuildContext ctx) => AboutScreen(),
          Login.id: (BuildContext ctx) => Login(),
          RegistrationScreen.id: (BuildContext ctx) => RegistrationScreen(),
          SettingScreen.id: (BuildContext ctx) => SettingScreen()
        },
      ),
    );
  }
}
