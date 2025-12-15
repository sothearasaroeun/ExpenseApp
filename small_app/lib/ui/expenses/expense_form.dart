import 'package:flutter/material.dart';
import '../../model/expense_model.dart';

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(onPressed: () => Navigator.pop(context, 'OK'), child: const Text('OK')),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}


class ExpenseForm extends StatefulWidget {
  final Function(Expense) onPressCreate;
  const ExpenseForm({required this.onPressCreate, super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

void showdialog () {
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(onPressed: () => Navigator.pop(context, 'OK'), child: const Text('OK')),
          ],
        ),
      );    
}
  void onCreate(){
    Expense expense = Expense(title: titleController.text, amount: double.tryParse(amountController.text), date: DateTime.now(), type: ExpenseType.food);
    Navigator.pop(context);
    widget.onPressCreate(expense);

  }

  void onCloseModal() {
    Navigator.pop(context);
  }
  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            maxLength: 50,
            decoration: InputDecoration(labelText: "Title"),
            controller: titleController,
          ),
          SizedBox(height: 20,),
          TextField(
            keyboardType: TextInputType.number,
            maxLength: 50,
            controller: amountController,
            decoration: InputDecoration(labelText: "Amount", prefixText: "\$", ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: onCloseModal,
                child: Text("Close", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: onCreate,
                child: Text("Create", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),
            ],
          )
        ],
      ),
    );
  }
}