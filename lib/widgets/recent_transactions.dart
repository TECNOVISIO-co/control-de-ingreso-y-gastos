import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/utils/app_localizations.dart';
import 'package:expense_tracker/screens/add_edit_expense_screen.dart';

class RecentTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final localizations = AppLocalizations.of(context);

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: expenseProvider.recentExpenses.length,
      itemBuilder: (context, index) {
        final expense = expenseProvider.recentExpenses[index];
        return ListTile(
          leading: CircleAvatar(
            child: Icon(_getCategoryIcon(expense.category)),
          ),
          title: Text(expense.title),
          subtitle: Text(localizations.formatDate(expense.date)),
          trailing: Text(
            localizations.formatCurrency(expense.amount),
            style: TextStyle(
              color: expense.amount < 0 ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AddEditExpenseScreen(expense: expense),
              ),
            );
          },
        );
      },
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.fastfood;
      case 'transportation':
        return Icons.directions_car;
      case 'entertainment':
        return Icons.movie;
      case 'bills':
        return Icons.receipt;
      default:
        return Icons.category;
    }
  }
}