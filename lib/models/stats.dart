class Stats {
  String usrename;
  String description;
  String date;
  int code;

  Stats(this.usrename, this.description, this.date, this.code);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'username': this.usrename,
      'description': this.description,
      'time': this.date,
      'code': this.code,
    };
    return map;
  }

  Stats.fromMap(Map<String, dynamic> map) {
    usrename = map['username'];
    description = map['description'];
    date = map['time'];
    code = map['code'];
  }
}
