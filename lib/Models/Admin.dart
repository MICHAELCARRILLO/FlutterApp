class Admin {
  int id;
  String name;
  String lastname;
  String dni;
  String responsability;
  String username;
  String password;

  Admin({
    required this.id,
    required this.name,
    required this.lastname,
    required this.dni,
    required this.responsability,
    required this.username,
    required this.password,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'],
      name: json['name'],
      lastname: json['lastname'],
      dni: json['dni'],
      responsability: json['responsability'],
      username: json['username'],
      password: json['password'],
    );
  }
}
