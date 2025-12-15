import 'package:flutter/material.dart';
import 'model/expense_model.dart';
import 'data/expense.dart';
import './ui/widget/expenseForm.dart';
import './ui/widget/expenseItem.dart';
void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Expenses(expenses: expenses)
    )
  );
}

class Expenses extends StatefulWidget {
  final List<Expense> expenses;
  const Expenses({required this.expenses, super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Expense> _registeredExpenses = [];
  @override
  void initState(){
    super.initState();
    _registeredExpenses = widget.expenses;
  }
  
  void onAddPress() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ExpenseForm(onPressCreate: (expense){
        setState(() {
          _registeredExpenses.add(expense);
        });
      },),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "The-Best Expenses App", 
          style: TextStyle(fontWeight: FontWeight.bold)) ,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton( 
              icon: Icon(Icons.add),
              onPressed: () {
                onAddPress();
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: ListView.builder(
          itemCount: _registeredExpenses.length,
          itemBuilder: (context, index){
            return ExpenseItem(expense: _registeredExpenses[index]);
          }
        ),
      )
    );
  }
}























// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ExpenseApp(),
//     );
//   }
// }

// class ExpenseApp extends StatefulWidget {
//   const ExpenseApp({super.key});

//   @override
//   State<ExpenseApp> createState() => _ExpenseAppState();
// }

// class _ExpenseAppState extends State<ExpenseApp> {
//   final List<String> _expenses = [];
//   bool _showList = true;

//   final TextEditingController _controller = TextEditingController();

//   int get totalExpenses => _expenses.length;

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _addExpense() {
//     if (_controller.text.isEmpty) return;

//     setState(() {
//       _expenses.add(_controller.text);
//       _controller.clear();
//     });
//   }

//   void _toggleList() {
//     setState(() {
//       _showList = !_showList;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightBlueAccent,
//       appBar: AppBar(
//         backgroundColor: Colors.blue[700],
//         title: const Text(
//           "Simple Expense App",
//           style: TextStyle(color: Colors.white),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.swap_vert, color: Colors.white),
//             onPressed: _toggleList,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             ExpenseInput(
//               controller: _controller,
//               onAdd: _addExpense,
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "Total items: $totalExpenses",
//               style: const TextStyle(color: Colors.white),
//             ),
//             const SizedBox(height: 10),
//             if (_showList)
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _expenses.length,
//                   itemBuilder: (context, index) {
//                     return ExpenseItem(
//                       title: _expenses[index],
//                       onDelete: () {
//                         setState(() {
//                           _expenses.removeAt(index);
//                         });
//                       },
//                     );
//                   },
//                 ),
//               )
//             else
//               const Text(
//                 "List hidden",
//                 style: TextStyle(color: Colors.white),
//               ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.white,
//         onPressed: _addExpense,
//         child: const Icon(Icons.add, color: Colors.blue),
//       ),
//     );
//   }
// }

// class ExpenseInput extends StatelessWidget {
//   final TextEditingController controller;
//   final VoidCallback onAdd;

//   const ExpenseInput({
//     super.key,
//     required this.controller,
//     required this.onAdd,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             controller: controller,
//             style: const TextStyle(color: Colors.white),
//             decoration: const InputDecoration(
//               hintText: "Enter expense",
//               hintStyle: TextStyle(color: Colors.white),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(width: 8),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.white,
//           ),
//           onPressed: onAdd,
//           child: const Text(
//             "Add",
//             style: TextStyle(color: Colors.blue),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ExpenseItem extends StatelessWidget {
//   final String title;
//   final VoidCallback onDelete;

//   const ExpenseItem({
//     super.key,
//     required this.title,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.blue,
//       child: ListTile(
//         title: Text(
//           title,
//           style: const TextStyle(color: Colors.white),
//         ),
//         trailing: IconButton(
//           icon: const Icon(Icons.delete, color: Colors.green),
//           onPressed: onDelete,
//         ),
//       ),
//     );
//   }
// }
