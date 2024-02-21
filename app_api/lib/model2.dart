class UserModel {
  int id;
  String email;
  String username;
  String password;
  Name name;
  String phone;
  int iV;

  UserModel(
      {
      required this.id,
      required this.email,
      required this.username,
      required this.password,
      required this.name,
      required this.phone,
      required this.iV});

  UserModel.fromJson(Map<String, dynamic> json) 
    :
    id = json['id'],
    email = json['email'],
    username = json['username'],
    password = json['password'],
    name = Name.fromJson(json['name']),
    phone = json['phone'],
    iV = json['__v'];
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    data['name'] = this.name.toJson();
    data['phone'] = this.phone;
    data['__v'] = this.iV;
    return data;
  }
}

class Name {
  String firstname;
  String lastname;

  Name({required this.firstname, required this.lastname});

  Name.fromJson(Map<String, dynamic> json) :
    firstname = json['firstname'],
    lastname = json['lastname'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    return data;
  }
}
