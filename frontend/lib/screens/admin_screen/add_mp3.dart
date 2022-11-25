import 'package:flutter/material.dart';
import 'package:ltm/common/notification.dart';
import 'package:ltm/configs/style_configs.dart';
import 'package:ltm/models/music_model.dart';
import 'package:ltm/provider/user_state.dart';
import 'package:provider/provider.dart';

class AddMp3 extends StatefulWidget {
  const AddMp3({super.key});

  @override
  State<AddMp3> createState() => _AddMp3State();
}

class _AddMp3State extends State<AddMp3> {
  String name ='';
  String describe = "";
  String image = "";
  String link = "";

  void addMp3()async{
    MusicModel data = MusicModel(name: name, image: image, des: describe, url: link, like: []);
    await context.read<UserState>().addmp3(data).then((value) => alert(context, "tạo bài hát thành công"));
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kColorBg2,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              style: TextStyle(fontSize: 14, color: kColorWhite),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "   Name",
                hintStyle: TextStyle(color: Colors.white),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  borderSide: BorderSide(color: kColorWhite),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  borderSide: BorderSide(color: kColorWhite),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  describe = value;
                });
              },
              style: TextStyle(fontSize: 14, color: kColorWhite),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "   Describe",
                hintStyle: TextStyle(color: Colors.white),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  borderSide: BorderSide(color: kColorWhite),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  borderSide: BorderSide(color: kColorWhite),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  image = value;
                });
              },
              style: TextStyle(fontSize: 14, color: kColorWhite),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "   Image",
                hintStyle: TextStyle(color: Colors.white),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  borderSide: BorderSide(color: kColorWhite),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  borderSide: BorderSide(color: kColorWhite),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  link = value;
                });
              },
              style: TextStyle(fontSize: 14, color: kColorWhite),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "   Link",
                hintStyle: TextStyle(color: Colors.white),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  borderSide: BorderSide(color: kColorWhite),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  borderSide: BorderSide(color: kColorWhite),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                addMp3();
              },
              child: Container(
                child: Center(child: const Text("Thêm")),
                color: Colors.red,
                height: 50,
                width: 150,
              ),
            )
          ],
        ),
      ),
    );
  }
}
