import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Wallet {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String type;

  @HiveField(3)
  double balance;

  @HiveField(4)
  final String currency;

  Wallet({
    required this.id,
    required this.name,
    required this.type,
    required this.balance,
    required this.currency,
  });
}