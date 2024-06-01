part of 'expenses_bloc.dart';

abstract class ExpensesState extends Equatable {
  const ExpensesState();

  @override
  List<Object?> get props => [];
}

class ExpensesLoading extends ExpensesState {}

class ExpensesLoaded extends ExpensesState {
  final List<Expense> expenses;
  final double total;

  const ExpensesLoaded(this.expenses, this.total);

  @override
  List<Object> get props => [expenses, total];
}

class ExpensesError extends ExpensesState {
  final String message;

  const ExpensesError(this.message);

  @override
  List<Object?> get props => [message];
}
