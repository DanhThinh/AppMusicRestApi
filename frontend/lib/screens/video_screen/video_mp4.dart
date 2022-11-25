import 'package:flutter/material.dart';
import 'package:ltm/common/dummy_data.dart';
import 'package:ltm/configs/style_configs.dart';
import 'package:ltm/models/comment_model.dart';
import 'package:ltm/models/mp4_model.dart';
import 'package:ltm/provider/user_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:provider/provider.dart';

class VideoMp4 extends StatefulWidget {
  final Mp4Model mp4model;
  const VideoMp4(this.mp4model, {super.key});

  @override
  State<VideoMp4> createState() => _VideoMp4State();
}

class _VideoMp4State extends State<VideoMp4> {
  String text = "";
  final TextEditingController _controller = TextEditingController();
  Mp4Model? mp4model;

  @override
  void initState() {
    // TODO: implement initState
    mp4model = widget.mp4model;
    setState(() {
      
    });
    super.initState();
  }

  void post()async{
    await context.read<UserState>().updateMp4(widget.mp4model, text).then((value) => mp4model!.comment.add(CommentModel(username: context.read<UserState>().nameUser, comment: value)));
  }
  @override
  Widget build(BuildContext context) {
    print(widget.mp4model.comment.length);
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: kColorBg,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kColorBg,
          elevation: 0,
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
                  initialVideoId: widget.mp4model.keyId,
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
                widget.mp4model.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Text("Bình luận",
                  style: TextStyle(fontSize: 19, color: Colors.white)),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    margin: EdgeInsets.only(left: 12, right: 13),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(
                              "${mp4model!.comment[index].username}: ",
                              style:
                                  TextStyle(color: kColorWhite, fontSize: 18),
                            ),
                            Text(
                              mp4model!.comment[index].comment,
                              style:
                                  TextStyle(color: kColorWhite, fontSize: 14),
                            )
                          ],
                        );
                      },
                      itemCount: mp4model!.comment.length,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                    child: Row(children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) {
                        text = value;
                      },
                      style: TextStyle(fontSize: 14, color: kColorWhite),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
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
                  ),
                  Expanded(
                      child: IconButton(
                    onPressed: () {
                      _controller.clear();
                      setState(() {});
                      post();
                    },
                    icon: Icon(Icons.send),
                    color: kColorWhite,
                  ))
                ]))
              ],
            ))
          ],
        ));
  }
}
