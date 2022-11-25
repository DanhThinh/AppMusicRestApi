import 'package:ltm/models/comment_model.dart';

class Mp4Model {
    Mp4Model({
        required this.keyId,
        required this.name,
        required this.comment,
    });

    late String keyId;
    late String name;
    late List<dynamic> comment;

    Mp4Model.fromJson(Map<String, dynamic> json){
      keyId = json["keyId"];
      name = json["name"];
      comment = List<dynamic>.from(json["comment"].map((x) => CommentModel.fromMap(x)));
    }

    Map<String, dynamic> toJson(String value) => {
        "username":value,
        "keyId": keyId,
        "like":[],
        "name": name,
        "comment": List<dynamic>.from(comment.map((x) => x.toJson())),
    };

    Map<String, dynamic> toJsonKey() => {
      "keyId":keyId.toString()
    };

    Map<String, dynamic> toJsonAddMp4() => {
      "keyId": keyId,
      "name":name,
      "like":[]
    };
}
