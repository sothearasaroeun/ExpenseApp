import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/expense.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem({required this.expense, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 5),
                Text("\$${expense.amount?.toStringAsFixed(2) ?? '0.00'}"),
              ],
            ),
            Row(
              children: [
                Icon(expense.type.icon),
                const SizedBox(width: 10),
                Text(DateFormat('MM/dd/yyyy').format(expense.date)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}