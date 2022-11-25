import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ltm/common/notification.dart';
import 'package:ltm/custom_icons_icons.dart';
import 'package:ltm/provider/audio_state.dart';
import 'package:ltm/provider/user_state.dart';
import 'package:ltm/screens/about_screen/about_screen.dart';
import 'package:ltm/screens/admin_screen/admin_screen.dart';
import 'package:ltm/screens/home_screen/home_screen.dart';
import 'package:ltm/screens/music_screen/list_music_screen.dart';
import 'package:ltm/screens/setting_screen/setting_screen.dart';
import 'package:ltm/screens/video_screen/list_video_screen.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        color: Colors.black38.withOpacity(0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                context.read<UserState>().anhNen != ""
                    ? Image.file(File(context.read<UserState>().anhNen))
                    : Image.asset("assets/images/hinh.jpg"),
                Positioned(
                  top: 0,
                  left: 0,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              context.read<UserState>().anhDaiDien != ""
                                  ? FileImage(File(
                                          context.read<UserState>().anhDaiDien))
                                      as ImageProvider
                                  : AssetImage("assets/images/logo.png"),
                          backgroundColor: Colors.pinkAccent,
                          radius: 50,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                context.read<UserState>().nameUser,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Selector<UserState, bool>(
              builder: ((context, value, child) {
                if (value) {
                  return InkWell(
                    onTap: (() {
                      Navigator.pushNamed(
                          context, AdminScreen.id,);
                    }),
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 20, left: 10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.white.withOpacity(0.2)))),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.admin_panel_settings_outlined,
                            color: Colors.white,
                            size: 35,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Admin",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  );
                }return SizedBox();
              }),
              selector: (ctx, state) => state.isRoleAdmin,
            ),
            InkWell(
              onTap: (() {
                Navigator.pushNamedAndRemoveUntil(
                    context, ListMusicScreen.id, (route) => false);
              }),
              child: Container(
                height: 50,
                margin: EdgeInsets.only(top: 20, left: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.white.withOpacity(0.2)))),
                child: Row(
                  children: const [
                    Icon(
                      Icons.music_note_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Music",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                context.read<AudioState>().pauseMusic();
                Navigator.pushNamedAndRemoveUntil(
                    context, ListVideoScreen.id, (route) => false);
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.only(top: 20, left: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.white.withOpacity(0.2)))),
                child: Row(
                  children: const [
                    Icon(
                      Icons.video_collection_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Video",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<AudioState>().pauseMusic();
                Navigator.pushNamedAndRemoveUntil(
                    context, SettingScreen.id, (route) => false);
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.only(top: 20, left: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.white.withOpacity(0.2)))),
                child: Row(
                  children: const [
                    Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 35,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Setting",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                context.read<AudioState>().pauseMusic();
                Navigator.pushNamedAndRemoveUntil(
                    context, AboutScreen.id, (route) => false);
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.only(top: 20, left: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.white.withOpacity(0.2)))),
                child: Row(
                  children: const [
                    Icon(
                      Icons.fiber_manual_record,
                      color: Colors.white,
                      size: 35,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "About",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                context.read<AudioState>().stop();
                context.read<AudioState>().cleanAll();
                context.read<UserState>().logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, MyHome.id, (route) => false);
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.only(top: 20, left: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.white.withOpacity(0.2)))),
                child: Row(
                  children: const [
                    Icon(
                      CustomIcons.arrow_in_left,
                      color: Colors.white,
                      size: 35,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Sign out",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
