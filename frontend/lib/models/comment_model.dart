class CommentModel{
  late String username;
  late String comment;
  CommentModel({
    required this.username,
    required this.comment
  });

  CommentModel.fromMap(Map<String,dynamic> data){
    username = data["username"]??"";
    comment = data["comment"]??"";
  }

   Map<String, dynamic> toJson() => {
    "username": username,
    "comment":comment
    };
}