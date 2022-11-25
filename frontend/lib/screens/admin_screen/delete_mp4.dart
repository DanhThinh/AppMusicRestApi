import 'package:flutter/material.dart';
import 'package:ltm/configs/style_configs.dart';
import 'package:ltm/models/mp4_model.dart';
import 'package:ltm/provider/user_state.dart';
import 'package:provider/provider.dart';

class DeleteMp4 extends StatefulWidget {
  const DeleteMp4({super.key});

  @override
  State<DeleteMp4> createState() => _DeleteMp4State();
}

class _DeleteMp4State extends State<DeleteMp4> {
  void delete(String value) async{
    await context.read<UserState>().deleteMp4(value);
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(
            child: Selector<UserState, List<Mp4Model>>(
              selector: (context, state) => state.dataVideo,
              shouldRebuild: (previous, next) => true,
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                        padding: EdgeInsets.only(top: index == 0 ? 20 : 0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.height * 0.5,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: kColorBg2),
                                height: 85,
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: index == 0 ? 20 : 0, bottom: 15),
                                child: Row(
                                  children: [
                                    Image.asset("assets/images/logo.png"),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      value[index].name,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  delete(value[index].keyId);
                                },
                                icon: Icon(Icons.delete))
                          ],
                        ));
                  }),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
