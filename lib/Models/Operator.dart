class Operator {
  int id;
  String name;
  String lastname;
  String dni;
  String responsability;
  int machineId;

  Operator(
      {required this.id,
      required this.name,
      required this.lastname,
      required this.dni,
      required this.responsability,
      required this.machineId});

  getName() {
    return name;
  }

  getLastname() {
    return lastname;
  }

  getDni() {
    return dni;
  }

  getResponsability() {
    return responsability;
  }

  factory Operator.fromJson(Map<String, dynamic> json) {
    return Operator(
      id: json['id'],
      name: json['name'],
      lastname: json['lastname'],
      dni: json['dni'],
      responsability: json['responsability'],
      machineId: json['machineId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lastname': lastname,
        'dni': dni,
        'responsability': responsability,
        'machineId': machineId,
      };
}
