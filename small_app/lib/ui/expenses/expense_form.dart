import 'package:flutter/material.dart';
import '../../model/expense.dart';

class ExpenseForm extends StatefulWidget {
  final Function(Expense) onPressCreate;
  const ExpenseForm({required this.onPressCreate, super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void _onCreate() {
    final double? amount = double.tryParse(amountController.text);
    if (titleController.text.isEmpty || amount == null || amount <= 0) {
      return;
    }

    Expense expense = Expense(
      title: titleController.text.trim(),
      amount: amount,
      date: DateTime.now(),
      type: ExpenseType.food, // Will improve with dropdown later
    );

    widget.onPressCreate(expense);
    Navigator.pop(context);
  }

  void _onCloseModal() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            maxLength: 50,
            decoration: const InputDecoration(labelText: "Title"),
            controller: titleController,
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.number,
            maxLength: 50,
            controller: amountController,
            decoration: const InputDecoration(
              labelText: "Amount",
              prefixText: "\$",
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: _onCloseModal,
                child: const Text(
                  "Close",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: _onCreate,
                child: const Text(
                  "Create",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 300), // Space for keyboard
        ],
      ),
    );
  }
}