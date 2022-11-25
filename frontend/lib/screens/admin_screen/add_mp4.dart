import 'package:flutter/material.dart';
import 'package:ltm/common/notification.dart';
import 'package:ltm/configs/style_configs.dart';
import 'package:ltm/models/mp4_model.dart';
import 'package:ltm/provider/user_state.dart';
import 'package:provider/provider.dart';

class AddMp4 extends StatefulWidget {
  const AddMp4({super.key});

  @override
  State<AddMp4> createState() => _AddMp4State();
}

class _AddMp4State extends State<AddMp4> {
  String keyId ="";
  String name = "";

  void addMp4()async{
    Mp4Model data = Mp4Model(keyId: keyId, name: name, comment: []);
    await context.read<UserState>().addMp4(data).then((value) => alert(context, "tạo bài hát thành công"));
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
                  keyId = value;
                });
              },
              style: TextStyle(fontSize: 14, color: kColorWhite),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "   KeyId",
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
            GestureDetector(
              onTap: () {
                addMp4();
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