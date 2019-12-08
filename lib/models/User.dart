
class User {
  String usrename;
  String password;
  int imageIndex;

  User(this.usrename, this.password, this.imageIndex);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'username': this.usrename,
      'password': this.password,
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    usrename = map['username'];
    password = map['password'];
  }
}
