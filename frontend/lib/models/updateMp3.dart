import 'comment_model.dart';

class UpdateMp3 {
    UpdateMp3({
        required this.username,
        required this.name,
        required this.like,
        required this.comment,
    });

    late String username;
    late String name;
    late List<String> like;
    late List<CommentModel> comment;

    UpdateMp3.fromMap(Map<String, dynamic> json){
      name = json["name"];
      like = List<String>.from(json["like"].map((x) => x[0]));
      comment = List<CommentModel>.from(json["comment"].map((x) => CommentModel.fromMap(x)));
    }

    Map<String, dynamic> toJson() => {
      "username": username,
        "name": name,
        "like": List<dynamic>.from(like.map((x) => x)),
        "comment": List<dynamic>.from(comment.map((x) => x.toJson())),
    };

    Map<String,dynamic> toDeleteMp3Json() => {
      "username": username,
      "name": name,
    };
}

