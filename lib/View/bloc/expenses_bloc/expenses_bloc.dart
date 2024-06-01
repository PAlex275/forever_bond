import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forever_bond/Model/expense.dart';
import 'package:forever_bond/ViewModel/expense_vm.dart'; // Asigură-te că ai viewmodelul ExpenseViewModel importat aici

part 'expenses_event.dart';
part 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  final ExpenseViewModel expenseViewModel;

  ExpensesBloc({required this.expenseViewModel}) : super(ExpensesLoading()) {
    on<LoadExpenses>(_onLoadExpenses);
    on<AddExpense>(_onAddExpense);
    on<UpdateExpense>(_onUpdateExpense);
    on<DeleteExpense>(_onDeleteExpense);
  }

  Future<void> _onLoadExpenses(
      LoadExpenses event, Emitter<ExpensesState> emit) async {
    emit(ExpensesLoading());
    try {
      final expenses = await expenseViewModel.getExpenses().first;
      final total = await expenseViewModel.getTotalExpenses();
      emit(ExpensesLoaded(expenses, total));
    } catch (e) {
      emit(ExpensesError('Failed to load expenses: $e'));
    }
  }

  Future<void> _onAddExpense(
      AddExpense event, Emitter<ExpensesState> emit) async {
    emit(ExpensesLoading());
    try {
      await expenseViewModel.addExpense(event.expense);
      final expenses = await expenseViewModel.getExpenses().first;
      final total = await expenseViewModel.getTotalExpenses();
      emit(ExpensesLoaded(expenses, total));
    } catch (e) {
      emit(ExpensesError('Failed to add expense: $e'));
    }
  }

  Future<void> _onUpdateExpense(
      UpdateExpense event, Emitter<ExpensesState> emit) async {
    emit(ExpensesLoading());
    try {
      await expenseViewModel.updateExpense(event.updatedExpense);
      final expenses = await expenseViewModel.getExpenses().first;
      final total = await expenseViewModel.getTotalExpenses();
      emit(ExpensesLoaded(expenses, total));
    } catch (e) {
      emit(ExpensesError('Failed to update expense: $e'));
    }
  }

  Future<void> _onDeleteExpense(
      DeleteExpense event, Emitter<ExpensesState> emit) async {
    emit(ExpensesLoading());
    try {
      await expenseViewModel.deleteExpense(event.expenseId);
      final expenses = await expenseViewModel.getExpenses().first;
      final total = await expenseViewModel.getTotalExpenses();
      emit(ExpensesLoaded(expenses, total));
    } catch (e) {
      emit(ExpensesError('Failed to delete expense: $e'));
    }
  }
}
