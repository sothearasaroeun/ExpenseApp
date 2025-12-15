import 'package:flutter/material.dart';
import '../../model/expense.dart';
import 'expense_form.dart';
import 'expense_item.dart';

class ExpensesScreen extends StatefulWidget {
  final List<Expense> expenses;
  const ExpensesScreen({required this.expenses, super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  late List<Expense> _registeredExpenses;

  @override
  void initState() {
    super.initState();
    _registeredExpenses = List.from(widget.expenses);
  }

  void _onAddPress() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ExpenseForm(onPressCreate: (expense) {
        setState(() {
          _registeredExpenses.add(expense);
        });
      }),
    );
  }

  void _removeExpense(int index, Expense removeExpense) {
    setState(() {
      _registeredExpenses.removeAt(index);
    });
    
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted.'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo', 
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(index, removeExpense);
            });
          }),
        ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final bool isEmpty = _registeredExpenses.isEmpty;

    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Ronan-The-Best Expenses App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: _onAddPress,
            ),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: isEmpty ? const Center(
          child: Text(
            "No Expenses found. Start adding some!",
            style: TextStyle(fontSize: 18, color: Colors.black),
            textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
          itemCount: _registeredExpenses.length,
          itemBuilder: (context, index) {
            final expense = _registeredExpenses[index];

            return Dismissible(
              key: Key(expense.id),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                _removeExpense(index, expense);
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete, color: Colors.white, size: 30),
              ),
              child: ExpenseItem(expense: expense),
              );
          },
        ),
      ),
    );
  }
}

