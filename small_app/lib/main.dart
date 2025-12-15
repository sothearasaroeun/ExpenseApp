import 'package:flutter/material.dart';
import '../../data/expenses.dart';
import 'ui/expenses/expense_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpensesScreen(expenses: expenses),
    ),
  );
}