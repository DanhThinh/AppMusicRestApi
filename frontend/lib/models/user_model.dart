class UserModel{
  late String username;
  late String password;
  UserModel({
    required this.username,
    required this.password
  });
  Map<String, dynamic> toJson() => {
    "username":username,
    "password":password
  };

}