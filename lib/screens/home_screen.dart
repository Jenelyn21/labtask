// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../models/expense.dart';
import 'add_expense_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Shows a confirmation dialog before deleting
  void _confirmDelete(BuildContext context, ExpenseProvider provider, Expense expense) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          'Delete Expense',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Are you sure you want to delete "${expense.title}"?',
          style: const TextStyle(color: Color(0xFF9E9E9E)),
        ),
        actions: [
          // Cancel
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF9E9E9E)),
            ),
          ),
          // Confirm delete
          TextButton(
            onPressed: () {
              provider.deleteExpense(expense.id);
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [

              // Total banner
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  border: Border.all(color: const Color(0xFF424242)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Total Expenses',
                      style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₱${provider.total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Expense list
              Expanded(
                child: provider.expenses.isEmpty
                    ? const Center(
                        child: Text(
                          'No expenses yet.\nTap + to add one!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFF616161)),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: provider.expenses.length,
                        itemBuilder: (_, i) {
                          final expense = provider.expenses[i];

                          return Dismissible(
                            key: Key(expense.id),
                            direction: DismissDirection.endToStart,
                            // Ask for confirmation on swipe too
                            confirmDismiss: (_) async {
                              bool confirmed = false;
                              await showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  backgroundColor: const Color(0xFF1E1E1E),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  title: const Text(
                                    'Delete Expense',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text(
                                    'Are you sure you want to delete "${expense.title}"?',
                                    style: const TextStyle(
                                        color: Color(0xFF9E9E9E)),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        confirmed = false;
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel',
                                          style: TextStyle(
                                              color: Color(0xFF9E9E9E))),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        confirmed = true;
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Delete',
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              );
                              return confirmed;
                            },
                            onDismissed: (_) =>
                                provider.deleteExpense(expense.id),
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3A1A1A),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.delete,
                                  color: Colors.redAccent),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E1E1E),
                                border: Border.all(
                                    color: const Color(0xFF2C2C2C)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  // Title + amount
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          expense.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '₱${expense.amount.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            color: Color(0xFF9E9E9E),
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Edit button
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        size: 20,
                                        color: Color(0xFF9E9E9E)),
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => AddExpenseScreen(
                                            expense: expense),
                                      ),
                                    ),
                                  ),

                                  // Delete button
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        size: 20,
                                        color: Color(0xFF757575)),
                                    onPressed: () => _confirmDelete(
                                        context, provider, expense),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}