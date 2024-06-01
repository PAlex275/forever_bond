import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forever_bond/Model/expense.dart';

class ExpenseViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'expenses';

  Future<void> addExpense(Expense expense) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await _firestore
          .collection('users')
          .doc(user.email)
          .collection(_collectionName)
          .doc(expense.id)
          .set(expense.toJson());
    } catch (e) {
      throw Exception('Failed to add expense: $e');
    }
  }

  Stream<List<Expense>> getExpenses() async* {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      yield* _firestore
          .collection('users')
          .doc(user.email)
          .collection(_collectionName)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Expense.fromJson(doc.data()))
            .toList();
      });
    } catch (e) {
      throw Exception('Failed to get expenses: $e');
    }
  }

  Future<void> updateExpense(Expense expense) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await _firestore
          .collection('users')
          .doc(user.email)
          .collection(_collectionName)
          .doc(expense.id)
          .update(expense.toJson());
    } catch (e) {
      throw Exception('Failed to update expense: $e');
    }
  }

  Future<void> deleteExpense(String expenseId) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await _firestore
          .collection('users')
          .doc(user.email)
          .collection(_collectionName)
          .doc(expenseId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete expense: $e');
    }
  }

  Future<double> getTotalExpenses() async {
    double total = 0;
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final snapshot = await _firestore
          .collection('users')
          .doc(user.email)
          .collection(_collectionName)
          .get();

      // ignore: avoid_function_literals_in_foreach_calls
      snapshot.docs.forEach((doc) {
        final expense = Expense.fromJson(doc.data());
        total += expense.amount;
      });
    } catch (e) {
      throw Exception('Failed to get total expenses: $e');
    }
    return total;
  }
}
