import 'package:flutter/foundation.dart';
import 'package:expense_tracker/models/wallet.dart';
import 'package:expense_tracker/services/database_service.dart';

class WalletProvider with ChangeNotifier {
  List<Wallet> _wallets = [];
  final DatabaseService _databaseService = DatabaseService();

  List<Wallet> get wallets => _wallets;

  Future<void> fetchWallets() async {
    _wallets = await _databaseService.getWallets();
    notifyListeners();
  }

  Future<void> addWallet(Wallet wallet) async {
    await _databaseService.insertWallet(wallet);
    await fetchWallets();
  }

  Future<void> updateWalletBalance(String walletId, double amount) async {
    final wallet = _wallets.firstWhere((w) => w.id == walletId);
    wallet.balance += amount;
    await _databaseService.updateWallet(wallet);
    notifyListeners();
  }
}