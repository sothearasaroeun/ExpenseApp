import 'package:flutter/material.dart';
import '../../model/expense_model.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem({required this.expense, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(expense.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                SizedBox(height: 5),
                Text("\$${expense.amount.toString()}")
              ],
            ),
            Row(
              children: [
                Icon(expense.type.icon),
                SizedBox(width: 10),
                Text(DateFormat('MM/dd/yyyy').format(expense.date))
              ],
            )
          ],
        ),
      )
    );
  }
}