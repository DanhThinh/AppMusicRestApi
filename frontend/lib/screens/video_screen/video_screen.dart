import 'package:flutter/material.dart';
import 'package:ltm/configs/style_configs.dart';
import 'package:ltm/models/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  VideoModel videoModel;
  VideoScreen(this.videoModel, {Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kColorBg,
        appBar: AppBar(
          backgroundColor:kColorBg,
          elevation: 0,
          centerTitle: true,
          title: Text("Video Screen"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId: widget.videoModel.url,
                  flags: YoutubePlayerFlags(
                    autoPlay: false,
                    mute: false,
                  ),
                ),
                liveUIColor: Colors.amber,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 12),
              child: Text(
                widget.videoModel.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 12),
              child: Text("Tác Giả: "+
                widget.videoModel.des,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ));
  }
}
