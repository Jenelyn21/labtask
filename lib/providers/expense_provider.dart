import 'package:flutter/foundation.dart';
import '../models/expense.dart';

class ExpenseProvider extends ChangeNotifier {

  final List<Expense> _expenses = [
    Expense(id: '1', title: 'Groceries',       amount: 58.75),
    Expense(id: '2', title: 'Bills',        amount: 12.50),
    Expense(id: '3', title: 'Netflix',          amount: 15.99),
    Expense(id: '4', title: 'Personal', amount: 1800.00),
    Expense(id: '5', title: 'Load',         amount: 430.00),
  ];

  List<Expense> get expenses => List.unmodifiable(_expenses);
  double get total => _expenses.fold(0, (sum, e) => sum + e.amount);

  void addExpense(String title, double amount) {
    _expenses.add(Expense(
      id:     DateTime.now().millisecondsSinceEpoch.toString(),
      title:  title,
      amount: amount,
    ));
    notifyListeners();
  }

  void updateExpense(Expense updated) {
    final index = _expenses.indexWhere((e) => e.id == updated.id);
    if (index == -1) return;
    _expenses[index] = updated;
    notifyListeners();
  }

  void deleteExpense(String id) {
    _expenses.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}