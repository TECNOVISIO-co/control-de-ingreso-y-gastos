import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:expense_tracker/models/expense.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'expense_tracker.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE expenses(
            id TEXT PRIMARY KEY,
            title TEXT,
            amount REAL,
            date INTEGER,
            category TEXT,
            currency TEXT
          )
        ''');
      },
    );
  }

  Future<List<Expense>> getExpenses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('expenses');
    return List.generate(maps.length, (i) {
      return Expense(
        id: maps[i]['id'],
        title: maps[i]['title'],
        amount: maps[i]['amount'],
        date: DateTime.fromMillisecondsSinceEpoch(maps[i]['date']),
        category: maps[i]['category'],
        currency: maps[i]['currency'],
      );
    });
  }

  Future<void> insertExpense(Expense expense) async {
    final db = await database;
    await db.insert(
      'expenses',
      {
        'id': expense.id,
        'title': expense.title,
        'amount': expense.amount,
        'date': expense.date.millisecondsSinceEpoch,
        'category': expense.category,
        'currency': expense.currency,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// TODO: Implementar métodos para actualizar y eliminar gastos
}