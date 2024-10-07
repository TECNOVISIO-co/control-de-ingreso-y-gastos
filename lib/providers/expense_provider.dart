import 'package:flutter/foundation.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/services/database_service.dart';
import 'package:intl/intl.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];
  final DatabaseService _databaseService = DatabaseService();

  List<Expense> get expenses => _expenses;

  List<Expense> get recentExpenses {
    final sortedExpenses = List<Expense>.from(_expenses)
      ..sort((a, b) => b.date.compareTo(a.date));
    return sortedExpenses.take(5).toList();
  }

  List<double> get monthlyExpenses {
    final now = DateTime.now();
    final lastSixMonths = List.generate(6, (index) => now.subtract(Duration(days: index * 30)));

    return lastSixMonths.map((date) {
      return _expenses
          .where((expense) => expense.date.month == date.month && expense.date.year == date.year)
          .fold(0, (sum, expense) => sum + expense.amount);
    }).toList().reversed.toList();
  }

  double get maxExpenseAmount {
    return monthlyExpenses.reduce((curr, next) => curr > next ? curr : next);
  }

  String getMonthAbbreviation(int index) {
    final now = DateTime.now();
    final date = now.subtract(Duration(days: (5 - index) * 30));
    return DateFormat('MMM').format(date);
  }

  Map<String, double> get categoryTotals {
    final totals = <String, double>{};
    for (var expense in _expenses) {
      totals[expense.category] = (totals[expense.category] ?? 0) + expense.amount;
    }
    return totals;
  }

  Map<DateTime, double> get monthlyTotals {
    final totals = <DateTime, double>{};
    for (var expense in _expenses) {
      final monthStart = DateTime(expense.date.year, expense.date.month, 1);
      totals[monthStart] = (totals[monthStart] ?? 0) + expense.amount;
    }
    return totals;
  }

  Future<void> fetchExpenses() async {
    _expenses = await _databaseService.getExpenses();
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    await _databaseService.insertExpense(expense);
    await fetchExpenses();
  }

  Future<void> updateExpense(Expense expense) async {
    await _databaseService.updateExpense(expense);
    await fetchExpenses();
  }

  Future<void> deleteExpense(String id) async {
    await _databaseService.deleteExpense(id);
    await fetchExpenses();
  }
}