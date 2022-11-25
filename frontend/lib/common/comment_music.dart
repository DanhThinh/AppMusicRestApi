import 'package:flutter/material.dart';
import 'package:ltm/configs/style_configs.dart';
import 'package:ltm/models/comment_model.dart';
import 'package:ltm/models/updateMp3.dart';
import 'package:ltm/provider/user_state.dart';
import 'package:provider/provider.dart';

class CommentMusic extends StatefulWidget {
  final String name;
  final UpdateMp3 updateMp3;
  const CommentMusic(this.name, this.updateMp3, {super.key});

  @override
  State<CommentMusic> createState() => _CommentMusicState();
}

class _CommentMusicState extends State<CommentMusic> {
  List<CommentModel> data = [];
  bool isLoading = true;
  String text ="";
   final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    fetchData();
    print(widget.updateMp3);
    super.initState();
  }

  fetchData() async {
    data = await context.read<UserState>().getMp3(widget.name);
    setState(() {
      isLoading = false;
    });
  }

  postComment() async {
    await context.read<UserState>().updateCmt(widget.updateMp3,text);
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: kColorBg2.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.7,
          width: double.infinity,
          child: Builder(
            builder: (context) {
              if (isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(
                              "${data[index].username}: ",
                              style:
                                  TextStyle(color: kColorWhite, fontSize: 24),
                            ),
                            Text(
                              data[index].comment,
                              style:
                                  TextStyle(color: kColorWhite, fontSize: 20),
                            )
                          ],
                        );
                      },
                      itemCount: data.length,
                    ),
                  ),
                  Expanded(
                      child: Row(children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        controller: _controller,
                        onChanged: (value){
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
                        setState(() {
                          
                        });
                        postComment();
                      },
                      icon: Icon(Icons.send),
                      color: kColorWhite,
                    ))
                  ]))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
