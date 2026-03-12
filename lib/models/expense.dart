// lib/models/expense.dart

class Expense {
  final String id;
  final String title;
  final double amount;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
  });

  // ADD THIS — required by add_expense_screen.dart
  Expense copyWith({
    String? title,
    double? amount,
  }) {
    return Expense(
      id:     id,
      title:  title  ?? this.title,
      amount: amount ?? this.amount,
    );
  }
}