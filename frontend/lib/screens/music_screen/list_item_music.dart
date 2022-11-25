import 'package:flutter/material.dart';
import 'package:ltm/configs/style_configs.dart';
import 'package:ltm/models/music_model.dart';

class ListItemMusic extends StatefulWidget {
  MusicModel musicModel;
  ListItemMusic(
      this.musicModel,
      {Key? key}) : super(key: key);

  @override
  State<ListItemMusic> createState() => _ListItemMusicState();
}

class _ListItemMusicState extends State<ListItemMusic> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kColorBg2,
        borderRadius: BorderRadius.circular(10)
      ),
      margin: const EdgeInsets.only(left: 12,right: 13, bottom: 20),
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Image.asset(widget.musicModel.image),
            const SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.musicModel.name,style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),),
                Text(widget.musicModel.des,style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                ),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
