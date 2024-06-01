// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forever_bond/Model/expense.dart';
import 'package:forever_bond/View/bloc/expenses_bloc/expenses_bloc.dart';
import 'package:uuid/uuid.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  static const String routeName = '/expenses';

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  void initState() {
    var _expensesBloc = BlocProvider.of<ExpensesBloc>(context);
    _expensesBloc.add(LoadExpenses());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TotalExpensesWidget(),
          ExpensesListWidget(),
          AddExpenseButton(),
        ],
      ),
    );
  }
}

class TotalExpensesWidget extends StatelessWidget {
  const TotalExpensesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesBloc, ExpensesState>(
      builder: (context, state) {
        if (state is ExpensesLoaded) {
          final total = state.total;
          return Text('Total expenses: \$${total.toStringAsFixed(2)}');
        } else {
          return const Text('Total expenses: Loading...');
        }
      },
    );
  }
}

class ExpensesListWidget extends StatelessWidget {
  const ExpensesListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesBloc, ExpensesState>(
      builder: (context, state) {
        if (state is ExpensesLoaded) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.expenses.length,
              itemBuilder: (context, index) {
                final expense = state.expenses[index];
                return ListTile(
                  title: Text(expense.name),
                  subtitle: Text('\$${expense.amount.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          _showEditExpenseDialog(context, expense);
                        },
                        child: const Icon(Icons.edit),
                      ),
                      TextButton(
                        onPressed: () {
                          _showDeleteExpenseConfirmation(context, expense);
                        },
                        child: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          if (state is ExpensesLoading) {
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return const Expanded(child: SizedBox());
          }
        }
      },
    );
  }

  void _showEditExpenseDialog(BuildContext context, Expense expense) {
    final TextEditingController _nameController =
        TextEditingController(text: expense.name);
    final TextEditingController _amountController =
        TextEditingController(text: expense.amount.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text.trim();
                final amount = double.tryParse(_amountController.text.trim());
                if (name.isNotEmpty && amount != null) {
                  final updatedExpense =
                      expense.copyWith(name: name, amount: amount);
                  BlocProvider.of<ExpensesBloc>(context)
                      .add(UpdateExpense(updatedExpense));
                  Navigator.pop(context);
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteExpenseConfirmation(BuildContext context, Expense expense) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this expense?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<ExpensesBloc>(context)
                  .add(DeleteExpense(expense.id));
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class AddExpenseButton extends StatelessWidget {
  const AddExpenseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const AddExpenseDialog(),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

class AddExpenseDialog extends StatelessWidget {
  const AddExpenseDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _amountController = TextEditingController();

    return AlertDialog(
      title: const Text('Add Expense'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(labelText: 'Amount'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final name = _nameController.text.trim();
            final amount = double.tryParse(_amountController.text.trim());
            if (name.isNotEmpty && amount != null) {
              final expense = Expense(
                id: const Uuid().v4(),
                name: name,
                amount: amount,
                date: DateTime.now(),
              );
              BlocProvider.of<ExpensesBloc>(context).add(AddExpense(expense));
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
