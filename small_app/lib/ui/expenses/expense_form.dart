import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  
  ExpenseType? _selectedType = ExpenseType.food;
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000), 
      lastDate: DateTime(2030),
      );

      if (picked != null && picked != _selectedDate) {
        setState(() {
          _selectedDate = picked;
        });
      }
  }

  void _onSaveExpense() {
    final double? amount = double.tryParse(amountController.text);
    if (
      titleController.text.isEmpty || 
      amount == null || 
      amount <= 0 || 
      _selectedType == null ) {
      return;
    }

    Expense expense = Expense(
      title: titleController.text.trim(),
      amount: amount,
      date: _selectedDate ?? DateTime.now(),
      type: ExpenseType.food,
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

          DropdownButton<ExpenseType>(
            value: _selectedType,
            hint: const Text("Selected category"),
            isExpanded: true,
            icon: const Icon(Icons.arrow_downward_sharp),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
            items: ExpenseType.values.map<DropdownMenuItem<ExpenseType>>((ExpenseType type) {
              return DropdownMenuItem<ExpenseType>(
                value: type,
                child: Text(
                  type.name.toUpperCase(), 
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            }).toList(), 
            onChanged: (ExpenseType? newValue) {
              setState(() {
                _selectedType = newValue;
              });
            }),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedDate == null ? "No date selected" : DateFormat('EEE, MMM d').format(_selectedDate!),
                style: const TextStyle(fontSize: 16),
              ),
              IconButton(
                onPressed: () => _selectDate(context), 
                icon: const Icon(Icons.calendar_today))
            ],
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
                onPressed: _onSaveExpense,
                child: const Text(
                  "Save Expense",
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