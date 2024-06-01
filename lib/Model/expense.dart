import 'package:equatable/equatable.dart';

class Expense extends Equatable {
  final String id;
  final String name;
  final double amount;
  final DateTime date;

  const Expense({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
  });

  @override
  List<Object?> get props => [id, name, amount, date];

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'] as String,
      name: json['name'] as String,
      amount: json['amount'] as double,
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  Expense copyWith({
    String? id,
    String? name,
    double? amount,
    DateTime? date,
  }) {
    return Expense(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }
}
