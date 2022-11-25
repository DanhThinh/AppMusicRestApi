import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ltm/common/drawer.dart';
import 'package:ltm/configs/style_configs.dart';
import 'package:ltm/provider/user_state.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:image_cropper/image_cropper.dart';

class SettingScreen extends StatefulWidget {
  static String id = "setting_screen";
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String name = "";
  bool isDarkMode = false;
  @override
  void initState() {
    name = context.read<UserState>().nameUser;
    super.initState();
  }

  Future<void> getImage(String method) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final path = await path_provider.getApplicationDocumentsDirectory();
      CroppedFile? images = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [CropAspectRatioPreset.square,CropAspectRatioPreset.ratio5x3]);
      if (images != null) {
        File i = File(images.path);
        String name = image.name;
        i.copy("${path.path}/$name");
        if (method == "anh_nen") {
          context.read<UserState>().saveAnhNen("${path.path}/$name");
        } else {
          context.read<UserState>().saveAnhDaiDien("${path.path}/$name");
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBg,
      drawer: DrawerScreen(),
      appBar: AppBar(
        backgroundColor: kColorBg,
        title: Text("Setting"),
        centerTitle: true,
      ),
      body: Column(
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
                        backgroundImage: context.read<UserState>().anhDaiDien !=
                                ""
                            ? FileImage(
                                    File(context.read<UserState>().anhDaiDien))
                                as ImageProvider
                            : AssetImage("assets/images/logo.png"),
                        backgroundColor: Colors.pinkAccent,
                        radius: 50,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Đổi ảnh đại diện",
                  style: TextStyle(fontSize: 20, color: kColorWhite),
                ),
                IconButton(
                    onPressed: () {
                      getImage("anh_dai_dien");
                    },
                    icon: Icon(
                      Icons.image_outlined,
                      size: 30,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Đổi ảnh nền",
                  style: TextStyle(fontSize: 20, color: kColorWhite),
                ),
                IconButton(
                    onPressed: () {
                      getImage("anh_nen");
                    },
                    icon: Icon(
                      Icons.image_outlined,
                      size: 30,
                      color: Colors.white,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
