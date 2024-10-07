import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/models/wallet.dart';
import 'package:expense_tracker/providers/wallet_provider.dart';
import 'package:expense_tracker/utils/app_localizations.dart';
import 'package:uuid/uuid.dart';

class WalletManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('wallets')),
      ),
      body: ListView.builder(
        itemCount: walletProvider.wallets.length,
        itemBuilder: (context, index) {
          final wallet = walletProvider.wallets[index];
          return ListTile(
            title: Text(wallet.name),
            subtitle: Text('${localizations.formatCurrency(wallet.balance)} ${wallet.currency}'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _showWalletDialog(context, wallet),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showWalletDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showWalletDialog(BuildContext context, [Wallet? wallet]) {
    final localizations = AppLocalizations.of(context);
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    final nameController = TextEditingController(text: wallet?.name ?? '');
    final balanceController = TextEditingController(text: wallet?.balance.toString() ?? '0.0');
    String currency = wallet?.currency ?? 'COP';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(wallet == null
              ? localizations.translate('addWallet')
              : localizations.translate('editWallet')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: localizations.translate('walletName')),
              ),
              TextField(
                controller: balanceController,
                decoration: InputDecoration(labelText: localizations.translate('balance')),
                keyboardType: TextInputType.number,
              ),
              DropdownButton<String>(
                value: currency,
                items: ['COP', 'USD', 'EUR'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  currency = value!;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(localizations.translate('cancel')),
            ),
            TextButton(
              onPressed: () {
                final name = nameController.text;
                final balance = double.tryParse(balanceController.text) ?? 0.0;
                if (wallet == null) {
                  walletProvider.addWallet(Wallet(
                    id: Uuid().v4(),
                    name: name,
                    balance: balance,
                    currency: currency,
                    type: 'Cash', // You can add more types later
                  ));
                } else {
                  walletProvider.updateWallet(Wallet(
                    id: wallet.id,
                    name: name,
                    balance: balance,
                    currency: currency,
                    type: wallet.type,
                  ));
                }
                Navigator.of(context).pop();
              },
              child: Text(localizations.translate('save')),
            ),
          ],
        );
      },
    );
  }
}