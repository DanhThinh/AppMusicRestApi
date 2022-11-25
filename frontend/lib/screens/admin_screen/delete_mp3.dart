import 'package:flutter/material.dart';
import 'package:ltm/models/music_model.dart';
import 'package:ltm/provider/user_state.dart';
import 'package:ltm/screens/music_screen/list_item_music.dart';
import 'package:provider/provider.dart';

class DeleteMp3 extends StatefulWidget {
  const DeleteMp3({super.key});

  @override
  State<DeleteMp3> createState() => _DeleteMp3State();
}

class _DeleteMp3State extends State<DeleteMp3> {

  void delete(String value) async{
    await context.read<UserState>().deleteMp3(value);
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(
            child: Selector<UserState, List<MusicModel>>(
              selector: (context, state) => state.dataMusic,
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
                              child: ListItemMusic(value[index]),
                            ),
                            IconButton(
                                onPressed: () {
                                  delete(value[index].name);
                                }, icon: Icon(Icons.delete))
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
