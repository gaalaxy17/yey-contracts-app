class LoginForm {
  String? username;
  String? password;

  LoginForm();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['username'] = this.username;
    map['password'] = this.password;
    return map;
  }
}
