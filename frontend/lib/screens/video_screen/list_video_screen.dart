import 'dart:async';
import 'package:ltm/configs/style_configs.dart';
import 'package:ltm/models/mp4_model.dart';
import 'package:ltm/screens/video_screen/video_mp4.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:flutter/material.dart';
import 'package:ltm/common/drawer.dart';
import 'package:ltm/models/video_model.dart';
import 'package:ltm/provider/user_state.dart';
import 'package:ltm/screens/music_screen/list_item_music.dart';
import 'package:ltm/screens/video_screen/list_item_video.dart';
import 'package:provider/provider.dart';

class ListVideoScreen extends StatefulWidget {
  static const String id = "video_screen";
  const ListVideoScreen({Key? key}) : super(key: key);

  @override
  State<ListVideoScreen> createState() => _ListVideoScreenState();
}

class _ListVideoScreenState extends State<ListVideoScreen> {
  String _searchValue = "";
  final TextEditingController _controller = TextEditingController();
  Timer? _debounceTimer;
  bool _isShowloading = false;
  int page = 1;
  bool checkSearch = false;
  final ScrollController _scrollController = ScrollController();
  bool check = false;
  List<VideoModel> dataSearch = [];

  Future _searchApi(String value) async {
    if (value.isEmpty) return;
    return await context.read<UserState>().searchVideo(value);
  }

  Future _onTextFieldValueChange(String value) async {
    checkSearch = true;
    if (_debounceTimer != null) _debounceTimer!.cancel();
    if (value.trim().isEmpty) {
      setState(() {
        _searchValue = value.trim();
        _isShowloading = false;
      });
      return;
    }
    _debounceTimer = Timer.periodic(Duration(milliseconds: 500), (timer) async {
      if (!mounted) return;
      setState(() {
        _isShowloading = true;
      });
      timer.cancel();
      _searchValue = value.trim();
      page = 1;
      dataSearch = await _searchApi(_searchValue);
      setState(() {
        _isShowloading = false;
        checkSearch = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBg,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kColorBg,
        title: Text(
          "Video",
          style: TextStyle(fontSize: 25),
        ),
      ),
      drawer: DrawerScreen(),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(top: 20, left: 12, right: 13),
        child: Column(
          children: [
            TextField(
                controller: _controller,
                style: TextStyle(fontSize: 14, color: Colors.white),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(2))),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 18,
                    color: Colors.white,
                  ),
                  suffixIcon: _searchValue.isEmpty
                      ? SizedBox(
                          height: 1,
                          width: 1,
                        )
                      : IconButton(
                          onPressed: () {
                            _controller.clear();
                            dataSearch = [];
                            setState(() {
                              _searchValue = "";
                            });
                          },
                          icon: Icon(
                            Icons.clear,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                  ),
                  hintText: "Search video for a youtobe",
                  fillColor: Colors.blueGrey,
                  border: OutlineInputBorder(),
                ),
                onChanged: _onTextFieldValueChange),
            Expanded(
                child: _searchValue != ""
                    ? (_isShowloading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ListView.builder(
                              itemCount: dataSearch.length,
                              itemBuilder: (context, index) {
                                return ListItemVideo(dataSearch[index]);
                              },
                            ),
                          ))
                    : Selector<UserState, List<Mp4Model>>(
                      shouldRebuild: (previous, next) => true,
                        builder: (context, value, child) {
                          return ListView.builder(
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideoMp4(value[index]),));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: kColorBg2
                                  ),
                                  height: 85,
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(
                                      top: index == 0 ? 20 : 0, bottom: 15),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/logo.png"),
                                      SizedBox(width: 20,),
                                      Text(value[index].name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white                                    ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        selector: (context, state) => state.dataVideo,
                      ))
          ],
        ),
      )),
    );
  }
}
