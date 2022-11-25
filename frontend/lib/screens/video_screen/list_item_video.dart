import 'package:flutter/material.dart';
import 'package:ltm/configs/style_configs.dart';
import 'package:ltm/models/video_model.dart';
import 'package:ltm/screens/video_screen/video_screen.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ListItemVideo extends StatefulWidget {
  VideoModel  videoModel;
  ListItemVideo(
      this.videoModel,
      {Key? key}) : super(key: key);

  @override
  State<ListItemVideo> createState() => _ListItemVideoState();
}

class _ListItemVideoState extends State<ListItemVideo> {
  var yt = YoutubeExplode();
  final video = YoutubeExplode().videos.get('https://youtube.com/watch?v=Dpp1sIL1m5Q');
  
  @override
  void initState() { 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => VideoScreen(widget.videoModel),));
      },
      child: Container(
        decoration: BoxDecoration(
          color: kColorBg2,
          borderRadius: BorderRadius.circular(10)
        ),
        margin: EdgeInsets.only(top: 15),
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Image.network(widget.videoModel.image,height: 100,width: 133,),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.videoModel.name,
                  style: TextStyle(
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis
                  ),),
                  SizedBox(height: 10,),
                  Text(widget.videoModel.des,
                    style: TextStyle(
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis
                    ),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
