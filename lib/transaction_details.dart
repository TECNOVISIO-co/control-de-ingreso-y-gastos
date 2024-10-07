import 'package:flutter/material.dart';
import 'db/database.dart';
import 'main.dart';

class TransactionDetailsPage extends StatefulWidget {
  final Map<String, dynamic> transaction;

  TransactionDetailsPage({required this.transaction});

  @override
  _TransactionDetailsPageState createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  // Function to delete the transaction
  void _deleteTransaction() async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.deleteTransaction(widget.transaction['id']);
    Navigator.pop(context, true); // Return true to indicate deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteTransaction,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${widget.transaction['type']}'),
            Text('Amount: ${widget.transaction['currency']} ${widget.transaction['amount']}'),
            Text('Date: ${widget.transaction['date']}'),
            Text('Category: ${widget.transaction['category']}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTransactionPage(transaction: widget.transaction),
            ),
          ).then((_) => Navigator.pop(context, false)); // Return without deletion
        },
      ),
    );
  }
}
