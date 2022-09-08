class User {
  final String? id;
  final String? username;
  final int? roleId;
  String? token;

  User({this.id, this.username, this.roleId, this.token});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        roleId = json['roleId'],
        token = json['token'];
}
