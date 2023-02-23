import 'package:tanny_app/Models/Admin.dart';
import 'package:tanny_app/Models/Machine.dart';
import 'package:tanny_app/Models/Operator.dart';

class AdminReport {
  final int id;
  final String description;
  final String date;
  final String turn;
  final Operator operator;
  final Machine machine;

  AdminReport({
    required this.id,
    required this.description,
    required this.date,
    required this.turn,
    required this.operator,
    required this.machine,
  });

  factory AdminReport.fromJson(Map<String, dynamic> json) {
    return AdminReport(
      id: json['id'],
      description: json['description'],
      date: json['date'],
      turn: json['turn'],
      operator: Operator.fromJson(json['operator']),
      machine: Machine.fromJson(json['machine']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'date': date,
      'turn': turn,
      'operator': operator.toJson(),
      'machine': machine.toJson(),
    };
  }
}
