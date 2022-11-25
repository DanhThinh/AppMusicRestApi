import 'package:flutter/material.dart';
import 'package:ltm/provider/user_state.dart';
import 'package:ltm/screens/music_screen/list_music_screen.dart';
import 'package:ltm/screens/welcome_screen/welcome.dart';
import 'package:provider/provider.dart';

class MyHome extends StatelessWidget {
  static String id = "home_screen";
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<UserState,bool>(
      builder: (context, value, child) {
        if(value){
          return ListMusicScreen();
        }
        return WelcomeScreen();
      },
      selector: (ctx, state)=> state.isLoged,
      shouldRebuild: (previous, next) => true,);
  }
}