import 'package:flutter/material.dart';
import 'package:ltm/configs/style_configs.dart';
import 'package:ltm/provider/user_state.dart';
import 'package:ltm/screens/admin_screen/add_mp3.dart';
import 'package:ltm/screens/admin_screen/add_mp4.dart';
import 'package:ltm/screens/admin_screen/delete_mp3.dart';
import 'package:ltm/screens/admin_screen/delete_mp4.dart';
import 'package:ltm/screens/music_screen/list_item_music.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  static String id = "admin_screen";
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text("admin"),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return DeleteMp3();
                    });
              },
              child: Container(
                child: const Center(child: Text('Xóa mp3')),
                height: 50,
                width: 150,
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AddMp3();
                    });
              },
              child: Container(
                child: Center(child: Text('Thêm mp3')),
                height: 50,
                width: 150,
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return DeleteMp4();
                    });
              },
              child: Container(
                child: Center(child: Text('Xóa mp4')),
                height: 50,
                width: 150,
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AddMp4();
                    });
              },
              child: Container(
                child: Center(child: Text('Thêm Mp4')),
                height: 50,
                width: 150,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
