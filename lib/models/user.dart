class User {
  late String name, password, type, email, id, token;

  User({required this.email, required this.id, required this.name, required this.password, required this.token, required this.type});

  User.fromJson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
    password = json['password'];
    type = json['type'];
    id = json['_id'];
    token = json['token'];
  }
}