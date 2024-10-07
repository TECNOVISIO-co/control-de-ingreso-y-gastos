import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/providers/wallet_provider.dart';
import 'package:expense_tracker/utils/app_localizations.dart';
import 'package:uuid/uuid.dart';

class AddEditExpenseScreen extends StatefulWidget {
  final Expense? expense;

  AddEditExpenseScreen({this.expense});

  @override
  _AddEditExpenseScreenState createState() => _AddEditExpenseScreenState();
}

class _AddEditExpenseScreenState extends State<AddEditExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late double _amount;
  late DateTime _date;
  late String _category;
  late String _walletId;

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      _title = widget.expense!.title;
      _amount = widget.expense!.amount;
      _date = widget.expense!.date;
      _category = widget.expense!.category;
      _walletId = widget.expense!.walletId;
    } else {
      _title = '';
      _amount = 0.0;
      _date = DateTime.now();
      _category = '';
      _walletId = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final walletProvider = Provider.of<WalletProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.expense == null
            ? localizations.translate('addExpense')
            : localizations.translate('editExpense')),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              initialValue: _title,
              decoration: InputDecoration(labelText: localizations.translate('title')),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations.translate('pleaseEnterTitle');
                }
                return null;
              },
              onSaved: (value) => _title = value!,
            ),
            TextFormField(
              initialValue: _amount.toString(),
              decoration: InputDecoration(labelText: localizations.translate('amount')),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations.translate('pleaseEnterAmount');
                }
                if (double.tryParse(value) == null) {
                  return localizations.translate('pleaseEnterValidAmount');
                }
                return null;
              },
              onSaved: (value) => _amount = double.parse(value!),
            ),
            DropdownButtonFormField<String>(
              value: _category,
              decoration: InputDecoration(labelText: localizations.translate('category')),
              items: [
                'Food',
                'Transportation',
                'Entertainment',
                'Bills',
                'Other'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(localizations.translate(value.toLowerCase())),
                );
              }).toList(),
              onChanged: (value) => setState(() => _category = value!),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations.translate('pleaseSelectCategory');
                }
                return null;
              },
            ),
            DropdownButtonFormField<String>(
              value: _walletId,
              decoration: InputDecoration(labelText: localizations.translate('wallet')),
              items: walletProvider.wallets.map((wallet) {
                return DropdownMenuItem<String>(
                  value: wallet.id,
                  child: Text(wallet.name),
                );
              }).toList(),
              onChanged: (value) => setState(() => _walletId = value!),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations.translate('pleaseSelectWallet');
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text(localizations.translate('save')),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
      final expense = Expense(
        id: widget.expense?.id ?? Uuid().v4(),
        title: _title,
        amount: _amount,
        date: _date,
        category: _category,
        walletId: _walletId,
      );
      if (widget.expense == null) {
        expenseProvider.addExpense(expense);
      } else {
        expenseProvider.updateExpense(expense);
      }
      Navigator.of(context).pop();
    }
  }
}