class User {
  String name;
  String password;
  String office;
  String pKey;
  User(this.name, this.password, this.office, this.pKey);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        password = json['000000'],
        office = json['USEROFFICE'],
        pKey = json["PERMIT_TYPE"];
}
