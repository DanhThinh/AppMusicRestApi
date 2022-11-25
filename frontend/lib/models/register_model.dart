class Registe{
  late String username;
  late String password;
  Registe({
    required this.username,
    required this.password
  });
  Map<String, dynamic> toJson() => {
    "username":username,
    "password":password,
     "role":"user"
  };

}