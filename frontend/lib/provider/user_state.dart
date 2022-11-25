import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ltm/common/dummy_data.dart';
import 'package:ltm/configs/api.dart';
import 'package:ltm/configs/basic_configs.dart';
import 'package:ltm/models/comment_model.dart';
import 'package:ltm/models/mp4_model.dart';
import 'package:ltm/models/music_model.dart';
import 'package:ltm/models/register_model.dart';
import 'package:ltm/models/updateMp3.dart';
import 'package:ltm/models/user_model.dart';
import 'package:ltm/models/video_model.dart';
import 'package:ltm/services/api_service.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class UserState extends ChangeNotifier {
  bool isLoged = false;
  bool isFetchData = false;
  String baseUrl = 
  // "https://musicfivestar.onrender.com";
  "http://10.0.2.2:8080";
  late final Box boxUserSetting = Hive.box(boxUserSettingName);
  List<Mp4Model> dataVideo = [];
  List<MusicModel> dataMusic = [];
  List<UpdateMp3> dataUpdateMp3 =[];
  String nameUser = "";
  String anhDaiDien = "";
  String anhNen= "";
  bool isRoleAdmin = false;


  void initData(){
    isLoged = boxUserSetting.get("isLoged",defaultValue: false);
    nameUser = boxUserSetting.get("nameUser",defaultValue: "");
    anhNen = boxUserSetting.get("anhnen",defaultValue: "");
    anhDaiDien = boxUserSetting.get("anhDaiDien",defaultValue: "");
    isRoleAdmin = boxUserSetting.get("isAdmin",defaultValue: false);
    getAllMp3();
    getAllMp4();
  }

  void chageLog(){
    isLoged = !isLoged;
    boxUserSetting.put("isLoged",isLoged);
    notifyListeners();
  }

  void saveAnhNen(String s){
    anhNen = s;
    boxUserSetting.put("anhNen", s);
    notifyListeners();
  }

  void saveAnhDaiDien(String s){
    anhDaiDien = s;
    boxUserSetting.put("anhDaiDien", s);
    notifyListeners();
  }

  void saveUser(String name){
    nameUser = name;
    boxUserSetting.put("nameUser",name);
    notifyListeners();
  }

  Future<List<VideoModel>> searchVideo(String keyword) async {
    final List<VideoModel> result = [];
    final Response response =
        await ApiService().get(Api().searchVideo(keyword), {});
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    final data = json["items"];
    for (var i in data) {
      VideoModel hihi = VideoModel(
          name: i["snippet"]["title"] ?? "video",
          image: i["snippet"]["thumbnails"]["high"]["url"] ??
              "assets/images/logo.png",
          des: i["snippet"]["channelTitle"] ?? "Danh Thinh",
          url: i["id"]["videoId"] ?? "");
      result.add(hihi);
    }
    return result;
  }

  Future<bool> login(String user, String password) async {
    // "http://10.0.2.2:8080/login" với máy ảo
    try {
      final UserModel userModel = UserModel(username: user, password: password);
      final Response response = await ApiService().post(
          "$baseUrl/login", userModel.toJson(), {});
      if (response.statusCode == 200) {
        saveUser(user);
        print('đăng nhập thành công');
        chageLog();
        final json = jsonDecode(response.body);
        String role = json["user"]["role"];
        print(role);
        if(role == "admin"){
          isRoleAdmin = true;
          boxUserSetting.put("isAdmin",true);
          notifyListeners();
        }
        isLoged = true;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future logout() async{
    try {
      final Response response = await ApiService().get(
          "$baseUrl/logout",{});
          print(response.statusCode);
      if (response.statusCode == 200) {
        boxUserSetting.delete("isLoged");
        boxUserSetting.delete("nameUser");
        boxUserSetting.delete("anhnen");
        boxUserSetting.delete("anhDaiDien");
        boxUserSetting.delete("isAdmin");
        String nameUser = "";
        String anhDaiDien = "";
        String anhNen= "";
        isRoleAdmin = false;
        chageLog();
        return true;
      }
      return false;
    } catch(e) {
      rethrow;
    }
  }

  Future registe(String user, String password) async{
    try {
      final Registe userModel = Registe(username: user, password: password);
      final Response response = await ApiService().post(
          "$baseUrl/register", userModel.toJson(), {});
      if (response.statusCode == 200) {
        saveUser(user);
        print('đăng kí thành công');
        final json = jsonDecode(response.body);
        chageLog();
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future getAllMp3() async{
    dataMusic.clear();
    final Response response = await ApiService().get("$baseUrl/mp3/getAllMp3", null);
    print(response.statusCode);
    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      final datas = json["result"];
      print(json["result"]);
      for(var data in datas){
        dataMusic.add(MusicModel.fromMap(data));
        dataUpdateMp3.add(UpdateMp3.fromMap(data));
      }
    }
    isFetchData = true;
    notifyListeners();
  }

  Future<List<CommentModel>> getMp3(String nameMusic) async{
    List<CommentModel> a = [];
    final Response response = await ApiService().post("$baseUrl/mp3/getMp3", {"name": nameMusic},{});
    print(response.statusCode);
    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      final datas = json["result"]["comment"];
      print(datas);
      for(var data in datas){
        a.add(CommentModel.fromMap(data));
      }
    }
    return a;
  }

  Future updateCmt(UpdateMp3 data, String value) async{
    data.username = nameUser;
    CommentModel a = CommentModel(username: nameUser, comment: value);
    data.comment.add(a);
    final Response response = await ApiService().patch("$baseUrl/mp3/updateMp3", data.toJson(), {});
    print(response.statusCode);
  }

  Future updateLike(UpdateMp3 data, bool value) async{
    data.username = nameUser;
    if(value){
      data.like.add(nameUser);
    }else{
      data.like.remove(nameUser);
    }
    
    final Response response = await ApiService().patch("$baseUrl/mp3/updateMp3", data.toJson(), {});
    print(response.statusCode);
    if(response.statusCode == 200){
      getAllMp3();
    }
  }

  Future deleteMp3 ( String value)async{
    UpdateMp3 data = UpdateMp3(username: nameUser, name: value, like: [], comment: []);
    final Response response = await ApiService().delete("$baseUrl/mp3/deleteMp3", data.toDeleteMp3Json(), {});
    print(response.statusCode);
    if(response.statusCode == 200){
      getAllMp3();
    }
  }

  Future addmp3(MusicModel data) async {
    final Response response = await ApiService().post("$baseUrl/mp3/createMp3", data.toJson(), {});
    print(response.statusCode);
    if(response.statusCode == 200){
      getAllMp3();
    }
  }


  Future getAllMp4() async{
    dataVideo.clear();
    final Response response = await ApiService().get("$baseUrl/mp4/getAllMp4", null);
    print(response.statusCode);
    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      final datas = json["result"];
      print(json["result"]);
      for(var data in datas){
        dataVideo.add(Mp4Model.fromJson(data));
      }
    }
    notifyListeners();
  }

  Future updateMp4(Mp4Model data,String value) async{
    data.comment.add(CommentModel(username: nameUser, comment: value));
    final Response response = await ApiService().patch("$baseUrl/mp4/updateMp4", data.toJson(value), {});
    print(response.statusCode);
    if(response.statusCode==200) getAllMp4();
  }

   Future deleteMp4 ( String value)async{
    Mp4Model data = Mp4Model(keyId: value, name: 'name', comment: []);
    final Response response = await ApiService().delete("$baseUrl/mp4/deleteMp4", data.toJsonKey(), {});
    print(response.statusCode);
    if(response.statusCode == 200){
      getAllMp4();
    }
  }

  Future addMp4(Mp4Model data)async{
    final Response response = await ApiService().post("$baseUrl/mp4/createMp4", data.toJsonAddMp4(), {});
    print(response.statusCode);
    if(response.statusCode == 200){
      getAllMp4();
    }
  }
}
