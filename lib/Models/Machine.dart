import 'package:tanny_app/Models/Operator.dart';

class Machine {
  late int id;
  late String code;
  late String licensePlate;
  late String description;
  late String observation;
  late String brand;
  late String registeredDate;
  late List<Operator> operators;

  Machine({
    int id = 0,
    String code = '',
    String licensePlate = '',
    String description = '',
    String observation = '',
    String brand = '',
    String registeredDate = '',
    List<Operator> operators = const [],
  })  : this.brand = brand,
        this.code = code,
        this.description = description,
        this.id = id,
        this.licensePlate = licensePlate,
        this.observation = observation,
        this.registeredDate = registeredDate,
        this.operators = operators;

  getOperatorAt(int index) {
    return operators[index];
  }

  factory Machine.fromJson(Map<String, dynamic> json) {
    var operatorsList = <Operator>[];
    var operatorsJson = json['operators'];
    for (var i = 0; i < operatorsJson.length; i++) {
      var operator = Operator.fromJson(operatorsJson[i]);
      operatorsList.add(operator);
    }
    return Machine(
      id: json['id'],
      code: json['code'],
      licensePlate: json['licensePlate'],
      description: json['description'],
      observation: json['observation'],
      brand: json['brand'],
      registeredDate: json['registeredDate'],
      operators: operatorsList,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'licensePlate': licensePlate,
        'description': description,
        'observation': observation,
        'brand': brand,
        'registeredDate': registeredDate,
        'operators': operators.map((operator) => operator.toJson()).toList(),
      };
}
