import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
enum ExpenseType{
  food(icon: Icons.fastfood),
  travel(icon: Icons.travel_explore),
  leisure(icon: Icons.movie),
  work(icon: Icons.work);
  
  final IconData icon;
  const ExpenseType({required this.icon});
}


var uuid = Uuid();
class Expense{
  String id;
  String title;
  double? amount;
  DateTime date;
  ExpenseType type;

  Expense({
    String? id, 
    required this.title, 
    required this.amount, 
    required this.date,
    required this.type
  }) : this.id = id ?? uuid.v4();
}