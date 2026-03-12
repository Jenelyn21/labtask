// lib/screens/add_expense_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  final Expense? expense;

  const AddExpenseScreen({super.key, this.expense});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _titleCtrl  = TextEditingController();
  final TextEditingController _amountCtrl = TextEditingController();

  bool get _isEditing => widget.expense != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _titleCtrl.text  = widget.expense!.title;
      _amountCtrl.text = widget.expense!.amount.toString();
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  void _save() {
    final title  = _titleCtrl.text.trim();
    final amount = double.tryParse(_amountCtrl.text) ?? 0;
    if (title.isEmpty || amount <= 0) return;

    final provider = context.read<ExpenseProvider>();

    if (_isEditing) {
      provider.updateExpense(
        widget.expense!.copyWith(title: title, amount: amount),
      );
    } else {
      provider.addExpense(title, amount);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Expense' : 'Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _titleCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Amount (₱)',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                child: Text(_isEditing ? 'Save Changes' : 'Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}