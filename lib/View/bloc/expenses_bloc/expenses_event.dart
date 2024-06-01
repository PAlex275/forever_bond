part of 'expenses_bloc.dart';

abstract class ExpensesEvent extends Equatable {
  const ExpensesEvent();

  @override
  List<Object?> get props => [];
}

class LoadExpenses extends ExpensesEvent {}

class AddExpense extends ExpensesEvent {
  final Expense expense;

  const AddExpense(this.expense);

  @override
  List<Object?> get props => [expense];
}

class UpdateExpense extends ExpensesEvent {
  final Expense updatedExpense;

  const UpdateExpense(this.updatedExpense);

  @override
  List<Object> get props => [updatedExpense];
}

class DeleteExpense extends ExpensesEvent {
  final String expenseId;

  const DeleteExpense(this.expenseId);

  @override
  List<Object?> get props => [expenseId];
}
