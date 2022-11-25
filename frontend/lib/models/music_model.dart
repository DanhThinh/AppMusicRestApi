class MusicModel {
  late String name;
  late String image;
  late String des;
  late String url;
  late List<String> like;

  MusicModel(
      {required this.name,
      required this.image,
      required this.des,
      required this.url,
      required this.like});

  MusicModel.fromMap(Map<String,dynamic> data){
    name = data["name"] ?? "";
    image = "assets/images/logo.png";
    //  data["image"] ?? "";
    des = data["describe"] ?? "";
    url =  
    // "https://wpdb.mindfulnessapps.com/wp-content/uploads/2019/12/Introduktion-5-min.mp3";
    data["link"] ?? "";
    List<String> a =[];
    for(var b in data["like"]){
      a.add(b[0]??"");
    }
    like = a;
  }

  Map<String, dynamic> toJson() => {
    "name":name,
    "describe": des,
    "image": image,
    "link": url
    };

}
