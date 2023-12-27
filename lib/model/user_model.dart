class User {
  String? id;
  String? name;
  String? address;
  String? firstName;
  String? secondName;
  String? userName;
  String? password;

  User(
      {this.id,
      this.name,
      this.address,
      this.firstName,
      this.secondName,
      this.userName,
      this.password});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    firstName = json['firstName'];
    secondName = json['secondName'];
    userName = json['userName'];
    password = json['password'];
  }

// Factory method to create User object from a map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['ID'].toString(),
      name: map['NAME'],
      address: map['ADDRESS'],
      firstName: map['FIRST_NAME'],
      secondName: map['SECOND_NAME'],
      userName: map['USER_NAME'],
      password: map['PASSWORD'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['firstName'] = this.firstName;
    data['secondName'] = this.secondName;
    data['userName'] = this.userName;
    data['password'] = this.password;
    return data;
  }
}
