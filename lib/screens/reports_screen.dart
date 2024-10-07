import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/utils/app_localizations.dart';
import 'package:expense_tracker/widgets/expense_chart.dart';

class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('reports')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpenseChart(),
            SizedBox(height: 16),
            _buildCategoryReport(context, expenseProvider),
            SizedBox(height: 16),
            _buildMonthlyReport(context, expenseProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryReport(BuildContext context, ExpenseProvider provider) {
    final localizations = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.translate('categoryReport'),
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            ...provider.categoryTotals.entries.map((entry) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.key),
                    Text(localizations.formatCurrency(entry.value)),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyReport(BuildContext context, ExpenseProvider provider) {
    final localizations = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.translate('monthlyReport'),
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            ...provider.monthlyTotals.entries.map((entry) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localizations.formatDate(entry.key)),
                    Text(localizations.formatCurrency(entry.value)),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}